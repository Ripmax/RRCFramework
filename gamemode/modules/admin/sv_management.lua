if(!SERVER || CLIENT) then return end

local RRCA_TYPE_NORMAL = 0
local RRCA_TYPE_CONSOLE = 1
local RRCA_TYPE_AUTO = 2
local RRCA_TYPE_UNKNOWN = 3

local Module = RRC.Module["admin"]

function Module:KickPlayer(target, admin, reason, silent, reasonrequired)
	if(target && type(target) == "string") then target = RRC.Util:GetPlayerBySteamID(target) end
	if(!target || !IsValid(target)) then print("error 1") return end
	if(!admin || !IsValid(admin)) then print("error 2") return end
	if(!reason || reason:len() == 0 || reason:gsub("%s$", ""):lower() == "") then if(reasonrequired) then return else reason = "You were kicked from the server!" end end
	
	local mode
	if(admin && IsValid(admin) && admin:IsPlayer()) then mode = RRCA_TYPE_NORMAL
	elseif(!admin:IsPlayer() && admin) then mode = RRCA_TYPE_CONSOLE
	elseif(admin:lower() == "autoban") then mode = RRCA_TYPE_AUTO
	else mode = RRCA_TYPE_UNKNOWN end
	
	local tname = target:Nick()
	local tid = target:SteamID()
	local aname = admin:Nick()
	target:Kick(reason)
	
	if(!silent) then
		RRC:Message(MSGTYPE_ANNOUNCE, nil, aname .. " kicked " .. tname .. " (" .. tid .. ") from the server for, " .. reason)
	else
		RRC:Message(MSGTYPE_ANNOUNCE_ADMIN, nil, aname .. " kicked " .. tname .. " (" .. tid .. ") from the server for, " .. reason)
	end
end

function Module:BanPlayer(target, admin, reason, time, silent, reasonrequired)
	if(target && type(target) == "string") then target = RRC.Util:GetPlayerBySteamID(target) end
	if(!target) then return end
	if(!admin) then return end
	
	local mode = RRCA_TYPE_UNKNOWN
	if(!IsValid(admin)) then mode = RRCA_TYPE_CONSOLE end
	if(!IsValid(target)) then mode = RRCA_TYPE_CONSOLE end
	if(!reason || reason:len() == 0 || reason:gsub("%s$", ""):lower() == "") then if(reasonrequired) then return else reason = "You were banned from the server!" end end
	
	if(admin:lower() == "autoban") then
		mode = RRCA_TYPE_AUTO
	end
	
	if(IsValid(admin) && admin:IsPlayer()) then
		mode = RRCA_TYPE_NORMAL
	end
	
	if(mode == RRCA_TYPE_NORMAL) then
		if(!IsValid(target)) then
			RRC:LogError(RRC.dump())
			return
		end
		if(!IsValid(admin)) then
			RRC:LogError(RRC.dump())
			return
		end
	end
	
	local seconds = time * 60
	local minutes = time
	local hours = minutes / 60
	local days = hours / 24
	local weeks = days / 7
	local months = days / 30
	local years = days / 365
	
	RRC:RegisterBan((type(target) != "string" and target:SteamID() or target), admin, time)
end