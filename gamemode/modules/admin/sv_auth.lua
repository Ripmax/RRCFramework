local __check = function(steamid64, ip, svPassword, clPassword, name)
	if(svPassword != "") then
		if(clPassword != svPassword) then
			return false, "#GameUI_ServerRejectBadPassword"
		end
	end
	
	local banned = RRC.Module["admin"]:IsBanned({SteamID = util.SteamIDFrom64(steamid), SteamID64 = steamid, IP = ip, Nick = name}, true)
	
	if(banned != false) then
		if(banned.Banned) then
			return false, "You are banned from this server."
		end
	else
		return true
	end
end
hook.Add("CheckPassword", __check)