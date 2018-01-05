RRC.Util = {}

function RRC.Util:GetPlayerByName(name)
	if(!name) then return false end
	if(type(name) != "string") then return false end
	
	for k, v in pairs(player.GetAll()) do
		local processedName = string.Replace(v:Nick():lower(), " ", "")
		if(processedName:find(string.Replace(name:lower(), " ", ""))) then
			return v
		end
	end
	return false
end

function RRC.Util:GetPlayerBySteamID(steamid)
	if(!steamid) then return false end
	if(type(steamid) != "string") then return false end
	for k, v in pairs(player.GetAll()) do
		if(v:SteamID():lower() == string.Trim(steamid:lower())) then
			return v
		end
	end
	return false
end