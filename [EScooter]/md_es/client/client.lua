local usingScooter = false
local ScooterEntity = nil
local ESModel = 'serv_electricscooter'

RegisterNetEvent('md_es:useScooter')
AddEventHandler('md_es:useScooter', function()
	local timeUI = 5000
	if usingScooter then
		-- Notification : Already using scooter
	else
		RequestModel(ESModel)
		while not HasModelLoaded(ESModel) do
			Citizen.Wait(500)
		end
		local playerPed = PlayerPedId() -- get the local player ped
		local pos = GetEntityCoords(playerPed) -- get the position of the local player ped
		ScooterEntity = CreateVehicle(ESModel, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)
		if DoesEntityExist(ScooterEntity) then
			SetVehicleOnGroundProperly(ScooterEntity)
			SetVehicleAsNoLongerNeeded(ScooterEntity)
			SetModelAsNoLongerNeeded(ESModel)
			TaskWarpPedIntoVehicle(PlayerPedId(), ScooterEntity, -1)
			usingScooter = true
			TriggerServerEvent('md_es:sv_useScooter', NetworkGetNetworkIdFromEntity(ScooterEntity))
			while not IsPedInAnyVehicle(PlayerPedId(), false) do
				Citizen.Wait(10)
			end
			StartScooter()
		else
			-- Notification : Fail to spawn scooter
		end
	end
end)

--RegisterCommand("testes", function(source, args, rawCommand)
--	TriggerEvent('md_es:useScooter')
--end, false)

function StartScooter()
	Citizen.CreateThread(function()
		while usingScooter do
			if not IsPedInAnyVehicle(PlayerPedId(), false) then
				TriggerServerEvent('md_es:stopUsingScooter')
				DeleteEntity(ScooterEntity)
				usingScooter = false
			end
			Citizen.Wait(10)
		end
	end)
end
