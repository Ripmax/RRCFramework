local PLAYER = {}
print("hi")

if(SERVER) then
	PLAYER.StartWeapons = {"weapon_gravcannon","weapon_physgun"}
	
	function PLAYER:Init()
		RRC:Message(MSGTYPE_CONSOLE, {forceserver = true}, "Player " .. self.Player:Nick() .. " has initialised!")
	end
	
	function PLAYER:Spawn()
		self.Player:SetCanWalk(false)
		RRC:Message(MSGTYPE_CONSOLE, {forceserver = true}, "Player " .. self.Player:Nick() .. " has spawned!")
	end
	
	function PLAYER:SetModel()
		self.Player:SetModel("models/player/group03/male_01.mdl")
	end
	
	function PLAYER:Loadout()
		for k, v in pairs(PLAYER.StartWeapons) do
			self.Player:Give(v)
		end
	end
	
	function GM:PlayerNoClip(Player)
		return true
	end
end

player_manager.RegisterClass("sh_player", PLAYER, "player_default")