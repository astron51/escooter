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
			Citizen.Wait(0)
		end
		local MyPed = PlayerPedId()
		ScooterEntity = CreateVehicle(ESModel, GetEntityCoords(MyPed), GetEntityHeading(MyPed), true, false)
		SetModelAsNoLongerNeeded(ESModel)
		if DoesEntityExist(ScooterEntity) then
			TaskWarpPedIntoVehicle(PlayerPedId(), ScooterEntity, -1)
			SetVehicleAsNoLongerNeeded(ScooterEntity)
			usingScooter = true
			TriggerServerEvent('md_es:useScooter', NetworkGetNetworkIdFromEntity(ScooterEntity))
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
