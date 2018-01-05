local Module = RRC.Module["admin"]

function Module:IsBanned(infoTable, CheckShare)
	local bans = self.Bans
	if(!infoTable) then return false end
	if(!infoTable.SteamID) then return false end
	local SID = infoTable.SteamID
	local SID64 = infoTable.SteamID64
	local UNID = infoTable.UniqueID
	local NAM = infoTable.Nick
	local IP = infoTable.IPAddress
	local SHARED = {}
	
	if(CheckShare) then
		http.Fetch(
			string.format("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=%s&format=json&steamid=%s&appid_playing=4000",
				APIKey,
				SID64
			),

			function(body)
				body = util.JSONToTable(body)

				if(!body || !body.response || !body.response.lender_steamid) then
					Error("Failed API response for player " .. NAM .. " (" .. SID .. ")")
				end

				local lender = string.Trim(body.response.lender_steamid)
				if lender ~= "0" then
					//self:RegisterBan({SteamID = util.SteamIDFrom64(lender)}, nil, "Ban evasion by game borrowing", 0, nil, true)
					SHARED = {Lender = util.SteamIDFrom64(lender), Lender64 = lender}
				end
			end,
			
			function(code)
				error(string.format("Failed API call for %s | %s (Error: %s)\n", NAM, SID, code))
			end)
		end
		
			
	local find = false
	local __bandata = {}
	local __check1 = false
	local __check2 = false
	local __check3 = false
	local __check4 = false
	local __check5 = false

	
	for i = 1, #bans do
		if(!bans[i]) then continue end
		
		if(infoTable.IPAddress) then
			if(bans[i].IPAddress) then
				if(string.Trim(bans[i].IPAddress):lower() == string.Trim(IP):lower()) then
					__check1 = true
					
					__bandata = bans[i]
					break
				end
			end
		end
		
		if(infoTable.UniqueID) then
			if(bans[i].UniqueID) then
				if(string.Trim(bans[i].UniqueID):lower() == string.Trim(UNID):lower()) then
					__check2 = true
					
					__bandata = bans[i]
					break
				end
			end
		end
		
		if(infoTable.SteamID64) then
			if(bans[i].SteamID64) then
				if(string.Trim(bans[i].SteamID64):lower() == string.Trim(ID64):lower()) then
					__check3 = true
					
					__bandata = bans[i]
					break
				end
			end
		end
		
		if(string.Trim(bans[i].SteamID):lower() == string.Trim(SID):lower()) then
			__check5 = true
			
			__bandata = bans[i]
			break
		end
	end
	
	local lent = false
	
	lenderBanInfo = {}
	if(SHARED && CheckShare) then
		local lenderBan = self:IsBanned({SteamID = SHARED.Lender, SteamID64 = SHARED.Lender64}, false)
		if(lenderBan) then
			local lenderBanID = lenderBan.BanInfo.ID
			lenderBanInfo = lenderBan.BanInfo
			if(lenderBanInfo) then
				lent = true
			end
		end
	end
	
	if(__bandata && (__check1 || __check2 || __check3 || __check4 || __check5)) then
		if(CheckShare && lent) then
			return {Banned = true, Lent = true, LendDetails = lenderBanInfo, BanDetails = __bandata}
		else
			return {Banned = true, BanDetails = __bandata}
		end
	else
		return false
	end
end

function Module:RegisterBan(targetsteamid, admin, reason, 0, uk, uk1)
end
	