if(!SERVER || CLIENT) then return end
local Module = RRC.Module["admin"]

function Module:Initialise()
	self:Load()
end

function Module:Load()
	self:LoadRanks()
	//self:LoadSettings()
	self:LoadBans()
end

function Module:LoadRanks()
	RRC.Module["admin"].CachedRanks = {}
	
	local db = RRC.Module["database"]
	
	local res = db:Query("SELECT rank, steamid FROM players")
	res = db:EscapeBunch(res)
	
	-- for k, v in pairs(res) do
		-- table.insert(self.CachedRanks, {SteamID = res[1], Rank = res[2]})
	-- end
end

function Module:LoadSettings()
	RRC.Module["admin"].Settings = {}
	
	local db = RRC.Module["database"]
	
	local res = db:Query("SELECT option, value FROM admin_config")
	
	for k, v in pairs(res) do
		local data = db:EscapeBunch(v)
		self.Settings[data[1]] = data[2]
	end
end

function Module:LoadBans()
	RRC.Module["admin"].Bans = {}
	
	local db = RRC.Module["database"]
	
	local res = db:Query("SELECT steamid, expiredate, adminid, adminname, victimname FROM bans")
	
	for k, v in pairs(res) do
		local data = db:EscapeBunch(v)
		self.Bans[data[1]] = {Expiry = data[2], Admin = {SteamID = data[3], Name = data[4]}, VictimName = data[4]}
	end
end

RRC:RegisterModule("Admin", RRC.Module["admin"])