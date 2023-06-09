local PlayerUsingScooter = {
	-- [Key] = { NetworkID = ClientNetworkID } 
}

RegisterServerEvent('md_es:useScooter')
AddEventHandler('md_es:useScooter', function(NetworkID)
	local src = source
	PlayerUsingScooter[src] = { NetworkID = NetworkID }
end)

RegisterServerEvent('md_es:stopUsingScooter')
AddEventHandler('md_es:stopUsingScooter', function()
	local src = source
	if PlayerUsingScooter[src] then
		PlayerUsingScooter[src] = nil
	end
end)

Citizen.CreateThread(function()
	while true do
		for srcID, scooterID in pairs(PlayerUsingScooter) do
			if not GetPlayerPed(srcID) then
				local tScooter = NetworkGetEntityFromNetworkId(scooterID.NetworkID)
				if tScooter then
					DeleteEntity(tScooter)
				end
				PlayerUsingScooter[srcID] = nil
			end
		end
		Citizen.Wait(1000)
	end
end)