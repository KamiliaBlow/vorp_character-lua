local function toggleComp(hash, item)
	local __player = PlayerPedId()
	if Citizen.InvokeNative(0xFB4891BD7578CDC1, __player, hash) then
		Citizen.InvokeNative(0xD710A5007C2AC539, __player, hash, 0)
	else
		Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, item, false, false, false)
		Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, item, true, true, true)
	end
	UpdateVariation(__player)
end


for key, v in pairs(Config.commands) do
	RegisterCommand(v.command, function()
		print(key, CachedComponents[key])
		toggleComp(Config.HashList[key], CachedComponents[key])
	end)
end

RegisterCommand("rings", function()
	toggleComp(0x7A6BBD0B, CachedComponents.RingLh)
	toggleComp(0xF16A1D23, CachedComponents.RingRh)
end)

RegisterCommand("belt", function()
	toggleComp(0x9B2C8B89, CachedComponents.Gunbelt)
	toggleComp(0xB6B6122D, CachedComponents.Holster)
	toggleComp(0xA6D134C6, CachedComponents.Belt)
end)

RegisterCommand("undress", function()
	local __player = PlayerPedId()
	for Category, Components in pairs(CachedComponents) do
		if Components ~= -1 then
			if Citizen.InvokeNative(0xFB4891BD7578CDC1, __player, Config.HashList[Category]) then
				Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList[Category], 0)
			end
		end
	end
	UpdateVariation(__player)
end)

RegisterCommand("dress", function()
	local __player = PlayerPedId()
	for _, Components in pairs(CachedComponents) do
		if Components ~= -1 then
			Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, Components, false, false, false)
			Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, Components, true, true, false)
		end
	end
	UpdateVariation(__player)
end)
