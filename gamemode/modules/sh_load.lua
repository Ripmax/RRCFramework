if(SERVER) then
	RRC.ModuleList = {}
	function RRC:RegisterModule(Name, Table)
		if(!Name || !Table) then return end
		RRC.ModuleList[#RRC.ModuleList + 1] = Name
		RRC:Message(MSGTYPE_CONSOLE, nil, "\t--\tRegistered module " .. Name)
		RRC:Message(MSGTYPE_CONSOLE, nil, "\t--\tInitialising...")
		Table:Initialise()
		RRC:Message(MSGTYPE_CONSOLE, nil, "\t--\tFinished.")
		RRC:Message(MSGTYPE_CONSOLE, nil, "\n")
	end
end

local Modules = {"database", "admin"}
	
for k, v in pairs(Modules) do
	if(file.Exists("RRCBase/gamemode/modules/" .. v .. "/sh_core.lua", "LUA")) then
		if(SERVER) then AddCSLuaFile("RRCBase/gamemode/modules/" .. v .. "/sh_core.lua") end
		include("RRCBase/gamemode/modules/" .. v .. "/sh_core.lua")
	end
	if(SERVER) then include("RRCBase/gamemode/modules/" .. v .. "/sv_core.lua") end
end