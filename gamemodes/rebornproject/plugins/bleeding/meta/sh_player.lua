local player_meta = FindMetaTable'Player'

function player_meta:get_bleeding()
	return self:GetNetVar('bleeding', 0)
end

if SERVER then
	function player_meta:set_bleeding(value)
		if !isnumber(value) then value = 0 end
		
		local character = self:GetCharacter()

		if character then
			self:SetNetVar('bleeding', value)
			character:SetData('bleeding', value)
		end
	end
end
