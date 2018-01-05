if(!SERVER || CLIENT) then return end

RRC.Module["database"] = {}

local Module = RRC.Module["database"]

require("tmysql")
	
function Module:Initialise()
	RRC:Message(MSGTYPE_CONSOLE, nil, "Loading MYSQL")

	if(!tmysql) then
		RRC:Message(MSGTYPE_CONSOLE, nil, "MYSQL failed to load!")
		return
	else
		RRC:Message(MSGTYPE_CONSOLE, nil, "MYSQL Loaded!")
	end
	self:Connect()
end

function Module:Connect()
	tmysql.initialize(RRC:GetConfig("db", "host"), RRC:GetConfig("db", "user"), RRC:GetConfig("db", "pass"), RRC:GetConfig("db", "dbname"), RRC:GetConfig("db", "port"))
end

function Module:Query(query, callback)
	if(callback) then
		tmysql.query(query, function(data) pcall(callback, data) end)
	else
		tmysql.query(query)
	end
end

function Module:CheckResult(res)
	if(!res || !res[1] || !res[1][1]) then
		return false
	else
		return true
	end
end

function Module:Escape(data)
	return tmysql.escape(data)
end

function Module:EscapeBunch(data)
	if(!data) then return end
	if(type(data) != "table") then return end
	local newtable = {}
	for k, v in pairs(data) do
		newtable[k] = self:Escape(v)
	end
	return newtable
end

RRC:RegisterModule("Database", RRC.Module["database"])

