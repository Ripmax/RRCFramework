 function RRC:HandlePlayerInitialise(Player)
	print(Player:Nick() .. " has spawnedsss.")
end

local function hook_handlePlayerInit(ply)
	RRC:HandlePlayerInitialise(ply)
end
hook.Add("PlayerInitialSpawn", "RRC_HandlePlayerInitialise",  hook_handlePlayerInit)