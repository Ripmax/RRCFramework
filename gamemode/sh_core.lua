RRC = {}
RRC.Module = {}

GM.Name = "RRC Framework"
GM.Author = "Ripmax"

DeriveGamemode("sandbox")

RRC.GMPath = {}
RRC.GMPath.Main = "RRCBase/gamemode"
RRC.GMPath.Classes = RRC.GMPath.Main .. "/classes"

if(SERVER) then
	include("RRCBase/gamemode/sv_config.lua")
	include("sv_player.lua")

	AddCSLuaFile("classes/m_chat.lua")
	AddCSLuaFile("sh_enums.lua")
	AddCSLuaFile("sh_config.lua")
	AddCSLuaFile("sh_utility.lua")
	AddCSLuaFile("modules/sh_load.lua")
	AddCSLuaFile("classes/modules/von.lua")
end
include("classes/m_chat.lua")
include("sh_enums.lua")
include("sh_config.lua")
include("sh_utility.lua")
include("modules/sh_load.lua")
include("classes/modules/von.lua")

function RRC:LoadFolder(dir, exceptions, subfolders)

	local files, directories = file.Find("RRCBase/gamemode/" .. dir, "LUA")

	for k, v in pairs(files) do
		local makeexception = false
		if(exceptions) then
			for __, o in pairs(exceptions) do
				if(v == o) then makeexception = true end
			end
		end
		if(!makeexception) then
			local prefix = v:sub(1, 2)
			if(prefix == "cl") then
				if(SERVER) then AddCSLuaFile(dir .. "/" .. v) end
				if(CLIENT) then include(dir .. "/" .. v) end
			elseif(prefix == "sv") then
				if(SERVER) then include(dir .. "/" .. v) end
			else
				if(SERVER) then AddCSLuaFile(dir .. "/" .. v) end
				include(dir .. "/" .. v)
			end
			--print("including " .. dir .. "/" .. v)
		end
	end
	
	if(subfolders) then
		for k, v in pairs(directories) do
			RRC:LoadFolder(dir .. "/" .. v, false, true)
		end
	end
				
	
end

function RRC:LoadClasses()
	RRC:LoadFolder("classes")
end

function RRC:LoadSubModules()
	RRC:LoadFolder("classes/modules", false, true)
end

--RRC:LoadClasses()
--RRC:LoadSubModules()

RRC.Colours = {
	text = Color(210,210,210),
	lightsalmon	= Color(255,160,122),
	salmon = Color(250,128,114),
	darksalmon = Color(233,150,122),
	lightcoral = Color(240,128,128),
	indianred = Color(205,92,92),
	crimson = Color(220,20,60),
	firebrick = Color(178,34,34),
	red = Color(255,0,0),
	darkred = Color(139,0,0),
	coral = Color(255,127,80),
	tomato = Color(255,99,71),
	orangered = Color(255,69,0),
	gold = Color(255,215,0),
	orange = Color(255,165,0),
	darkorange = Color(255,140,0),
	lightyellow = Color(255,255,224),
	lemonchiffon = Color(255,250,205),
	lightgoldenrodyellow = Color(250,250,210),
	papayawhip = Color(255,239,213),
	moccasin = Color(255,228,181),
	peachpuff = Color(255,218,185),
	palegoldenrod = Color(238,232,170),
	khaki = Color(240,230,140),
	darkkhaki = Color(189,183,107),
	yellow = Color(255,255,0),
	lawngreen = Color(124,252,0),
	chartreuse = Color(127,255,0),
	limegreen = Color(50,205,50),
	lime = Color(0,255,0),
	forestgreen = Color(34,139,34),
	green = Color(0,128,0),
	darkgreen = Color(0,100,0),
	greenyellow = Color(173,255,47),
	yellowgreen = Color(154,205,50),
	springgreen = Color(0,255,127),
	mediumspringgreen = Color(0,250,154),
	lightgreen = Color(144,238,144),
	palegreen = Color(152,251,152),
	darkseagreen = Color(143,188,143),
	mediumseagreen = Color(60,179,113),
	seagreen = Color(46,139,87),
	olive = Color(128,128,0),
	darkolivegreen = Color(85,107,47),
	olivedrab = Color(107,142,35),
	lightcyan = Color(224,255,255),
	cyan = Color(0,255,255),
	aqua = Color(0,255,255),
	aquamarine = Color(127,255,212),
	mediumaquamarine = Color(102,205,170),
	paleturquoise = Color(175,238,238),
	turquoise = Color(64,224,208),
	mediumturquoise = Color(72,209,204),
	darkturquoise = Color(0,206,209),
	lightseagreen = Color(32,178,170),
	cadetblue = Color(95,158,160),
	darkcyan = Color(0,139,139),
	teal = Color(0,128,128),
	powderblue = Color(176,224,230),
	lightblue = Color(173,216,230),
	lightskyblue = Color(135,206,250),
	skyblue = Color(135,206,235),
	deepskyblue = Color(0,191,255),
	lightsteelblue = Color(176,196,222),
	dodgerblue = Color(30,144,255),
	cornflowerblue = Color(100,149,237),
	steelblue = Color(70,130,180),
	royalblue = Color(65,105,225),
	blue = Color(0,0,255),
	mediumblue = Color(0,0,205),
	darkblue = Color(0,0,139),
	navy = Color(0,0,128),
	midnightblue = Color(25,25,112),
	mediumslateblue = Color(123,104,238),
	slateblue = Color(106,90,205),
	darkslateblue = Color(72,61,139),
	lavender = Color(230,230,250),
	thistle = Color(216,191,216),
	plum = Color(221,160,221),
	violet = Color(238,130,238),
	orchid = Color(218,112,214),
	fuchsia = Color(255,0,255),
	magenta = Color(255,0,255),
	mediumorchid = Color(186,85,211),
	mediumpurple = Color(147,112,219),
	blueviolet = Color(138,43,226),
	darkviolet = Color(148,0,211),
	darkorchid = Color(153,50,204),
	darkmagenta = Color(139,0,139),
	purple = Color(128,0,128),
	indigo = Color(75,0,130),
	pink = Color(255,192,203),
	lightpink = Color(255,182,193),
	hotpink = Color(255,105,180),
	deeppink = Color(255,20,147),
	palevioletred = Color(219,112,147),
	mediumvioletred = Color(199,21,133),
	white = Color(255,255,255),
	snow = Color(255,250,250),
	honeydew = Color(240,255,240),
	mintcream = Color(245,255,250),
	azure = Color(240,255,255),
	aliceblue = Color(240,248,255),
	ghostwhite = Color(248,248,255),
	whitesmoke = Color(245,245,245),
	seashell = Color(255,245,238),
	beige = Color(245,245,220),
	oldlace = Color(253,245,230),
	floralwhite = Color(255,250,240),
	ivory = Color(255,255,240),
	antiquewhite = Color(250,235,215),
	linen = Color(250,240,230),
	lavenderblush = Color(255,240,245),
	mistyrose = Color(255,228,225),
	gainsboro = Color(220,220,220),
	lightgray = Color(211,211,211),
	silver = Color(192,192,192),
	darkgray = Color(169,169,169),
	gray = Color(128,128,128),
	dimgray = Color(105,105,105),
	lightslategray = Color(119,136,153),
	slategray = Color(112,128,144),
	darkslategray = Color(47,79,79),
	black = Color(0,0,0),
	cornsilk = Color(255,248,220),
	blanchedalmond = Color(255,235,205),
	bisque = Color(255,228,196),
	navajowhite = Color(255,222,173),
	wheat = Color(245,222,179),
	burlywood = Color(222,184,135),
	tan = Color(210,180,140),
	rosybrown = Color(188,143,143),
	sandybrown = Color(244,164,96),
	goldenrod = Color(218,165,32),
	peru = Color(205,133,63),
	chocolate = Color(210,105,30),
	saddlebrown = Color(139,69,19),
	sienna = Color(160,82,45),
	brown = Color(165,42,42),
	maroon = Color(128,0,0)
}