CMDTYPE_CHAT = 0
CMDTYPE_CONSOLE = 1

local tempcommands = {}

tempcommands[1] = {"suicide", function(Player, Args)
							Player:Kill()
							RRC:Message(MSGTYPE_ANNOUNCE, nil, "Killed " .. Player:Nick())
						end}

tempcommands[2] = {"respawn", function(Player, Args)
							Player:Spawn()
							RRC:Message(MSGTYPE_ANNOUNCE, nil, "Respawned " .. Player:Nick())
						end}
					
tempcommands[3] = {"give", function(Player, Args)
							Player:Give(Args[1])
							RRC:Message(MSGTYPE_ANNOUNCE, nil, "Giving a " .. Args[1] .. " to " .. Player:Nick())
						end}
						
tempcommands[4] = {"announce", function(Player, Args)
							RRC:Message(MSGTYPE_ANNOUNCE, nil, table.concat(Args, " ", 1 ) or "")
						end}
						
RRC.Commands = {}

function RRC:ProcessCommand(cmdtype, Player, cmd)
	local c = tempcommands
	local found
	local Args = {}
	local args_temp = string.Explode(" ", cmd)
	for k, v in pairs(args_temp) do
		if(k > 1) then table.insert(Args, v) end
	end
	for k, v in pairs(c) do
		if(v[1] == args_temp[1]) then
			c[k][2](Player, Args)
			found = true
		end
		if(k == #c && !found) then
			RRC:Message(MSGTYPE_PLAYER, {target = Player}, "Unknown command: " .. args_temp[1])
		end
	end
end

function RRC:CreateCommand(cmd)
	if(!cmd) then return end
	
end
	
	