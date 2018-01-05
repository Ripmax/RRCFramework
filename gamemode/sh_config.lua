if(CLIENT) then
	// Clientside config
end


function RRC:GetConfig(option, value)
	if(!RRC.Configuration[option:lower()]) then return nil end
	if(!RRC.Configuration[option:lower()][value:lower()]) then return nil end
	return RRC.Configuration[option:lower()][value:lower()]
end
