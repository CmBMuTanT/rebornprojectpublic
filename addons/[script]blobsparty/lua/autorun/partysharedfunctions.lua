local meta = FindMetaTable("Player")

function meta:GetParty()								-- Returns the party the player is currently in
	for v, k in pairs(parties) do
		if table.HasValue(parties[v].members, self:SteamID64()) then
			return v
		end
	end
end

function meta:GetPartyName()							-- Returns the party name
	if self:GetParty() != nil then
		return parties[self:GetParty()].name
	end
end



-- hook.Add("CanJoinParty" , "ForceSameTeam" , function (ply, partyid)
	-- if ply:Team() != player.GetBySteamID64(partyid):Team() then
		-- ply:Notify("That's a different team's party!")
		-- return false
	-- end
	-- return true
-- end)
