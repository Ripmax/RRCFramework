RRCA_EQUAL = 0
RRCA_ANDABOVE = 1

function RRC:IsGuest(player)
	if(!player || !IsValid(player)) then return false end
	return player.data.rank == 3
end

function RRC:IsAdmin(above, player)
	if(!player || !IsValid(player)) then return false end
	local result
	if(above == RRCA_EQUAL) then result = player.data.rank == 2 elseif(above == RRCA_ANDABOVE) then result = player.data.rank <= 2 else result = false end
	return result
end

function RRC:IsSuperAdmin(above, player)
	if(!player || !IsValid(player)) then return false end
	local result
	if(above == RRCA_EQUAL) then result = player.data.rank == 1 elseif(above == RRCA_ANDABOVE) then result = player.data.rank <= 1 else result = false end
	return result
end

function RRC:IsOwner(player)
	if(!player || !IsValid(player)) then return false end
	return player.data.rank == 0
end