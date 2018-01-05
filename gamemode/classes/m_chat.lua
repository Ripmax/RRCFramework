if(SERVER) then AddCSLuaFile("RRCBase/gamemode/classes/sh_chatcommand.lua") end
include("RRCBase/gamemode/classes/sh_chatcommand.lua")

local string = string
local hook = hook
local chat = chat

// Message type enumerations

MSGTYPE_ANNOUNCE = 0
MSGTYPE_ANNOUNCE_ADMIN = 1
MSGTYPE_PLAYER = 2
MSGTYPE_PRIVATE = 3
MSGTYPE_PLAYERCONSOLE = 4
MSGTYPE_CONSOLE = 5
MSGTYPE_ADMIN = 6
MSGTYPE_RANK = 7
MSGTYPE_RANKCONSOLE = 8

if(SERVER) then
	util.AddNetworkString("rrc_outputmsg")
	
	function sendMessage(client, tbl)
		if(!client || !IsValid(client)) then return end
		if(!tbl) then return end
		
		net.Start("rrc_outputmsg")
			net.WriteTable(tbl)
		net.Send(client)
	end
end

if(CLIENT) then
	net.Receive("rrc_outputmsg",function(l) chat.AddText(unpack(net.ReadTable())) end)
end

local function printMsg(client, arg)
	if(SERVER) then
		sendMessage(client, arg)
	else
		chat.AddText(unpack(arg))
	end
end

function RRC:Message(msgtype, extrainfo, msg)
	if(extrainfo && extrainfo.forceserver && !SERVER) then return end
	if(extrainfo && extrainfo.forceclient && !CLIENT) then return end
	if(!msgtype) then return end
	if(!msg) then return end
	local msg = tostring(msg)
	if(msgtype == MSGTYPE_ANNOUNCE && SERVER) then
		for k, v in pairs(player.GetAll()) do
			printMsg(v, {Color(100, 100, 255), "[ANNOUNCEMENT] ", Color(210, 210, 210), msg})
		end
	elseif(msgtype == MSGTYPE_ANNOUNCE_ADMIN && SERVER) then
		for k, v in pairs(player.GetAll()) do
			printMsg(v, {Color(100, 100, 255), RRC.Colours.black, "[", RRC.Colours.green, "ADMIN", RRC.Colours.black, "] ", Color(210, 210, 210), msg})
		end
	elseif(msgtype == MSGTYPE_PLAYER && extrainfo) then
		if(CLIENT) then return end
		local target = extrainfo.target
		if(!target || !IsValid(target) || !target:IsPlayer()) then return end
		printMsg(target, {Color(210, 210, 210), msg})
	elseif(msgtype == MSGTYPE_PRIVATE && extrainfo) then
		if(CLIENT) then return end
		local target = extrainfo.target
		local from = extrainfo.sender
		if(!target || !IsValid(target) || !target:IsPlayer()) then return end
		if(!from || !IsValid(from) || !from:IsPlayer()) then return end
		printMsg(target, {Color(100, 100, 255), "[PM]", Color(10, 210, 10), " ", from:Nick() " -> ", msg})
	elseif(msgtype == MSGTYPE_PLAYERCONSOLE) then
		if(CLIENT) then
			LocalPlayer():PrintMessage(HUD_PRINTCONSOLE, msg)
		elseif(SERVER && extrainfo) then
			local target = extrainfo.target
			if(!target || !IsValid(target) || !target:IsPlayer()) then return end
			target:PrintMessage(HUD_PRINTCONSOLE, msg)
		end
	elseif(msgtype == MSGTYPE_CONSOLE) then
		if(SERVER) then Msg(msg .. "\n") else LocalPlayer():PrintMessage(HUD_PRINTCONSOLE, msg) end
	elseif(msgtype == MSGTYPE_ADMIN) then
		if(CLIENT) then return end
		for k, v in pairs(player.GetAll()) do
			if(RRC:IsAdmin(RRCA_ANDABOVE, v)) then
				printMsg(v, {Color(210, 210, 210), msg})
			end
		end
	elseif(msgtype == MSGTYPE_RANK && extrainfo) then
		if(CLIENT) then return end
		local rank = extrainfo.rank
		if(!rank) then return end
		for k, v in pairs(player.GetAll()) do
			if(RRC:IsRank(RRC:GetRank(v), rank)) then
				printMsg(v, {Color(210, 210, 210), msg})
			end
		end
	end
end

if(SERVER) then
	hook.Add("PlayerSay", "OverwriteText", function(Player, text, team)
		if(!Player || !IsValid(Player)) then return false end
		local cmdprefix = text:sub(1, 1)
		if(cmdprefix == "/") then
			RRC:ProcessCommand(CMDTYPE_CHAT, Player, text:sub(2))
			return false
		end
		return string.Trim(text)
	end)
end
