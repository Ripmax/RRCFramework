if(!SERVER || CLIENT) then return end

RRC.Configuration = {}

// Serverside ONLY config
// For protected values

// Database Details

RRC.Configuration["db"] = {}

// Host
RRC.Configuration["db"]["host"] = "localhost"

// Username
RRC.Configuration["db"]["user"] = "root"

// Password
RRC.Configuration["db"]["pass"] = ""

// Database Name
RRC.Configuration["db"]["dbname"] = "rrc"

// Port
RRC.Configuration["db"]["port"] = 3306