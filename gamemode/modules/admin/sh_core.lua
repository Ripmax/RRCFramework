RRC.Module["admin"] = {}

// Shared Files
if(SERVER) then
	AddCSLuaFile("RRCBase/gamemode/modules/admin/sh_getters.lua")
end
include("RRCBase/gamemode/modules/admin/sh_getters.lua")

// Server Files
if(SERVER) then
	include("RRCBase/gamemode/modules/admin/sv_management.lua")
	include("RRCBase/gamemode/modules/admin/sv_auth.lua")
end
// Client Files