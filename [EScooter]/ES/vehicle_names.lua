function AddTextEntryEx(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry('0x06CCB6A0', 'Electric Scooter') -- Gamename = Vehicle model name // Display Name = Name it shows ingame
end)