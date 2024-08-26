

function PLUGIN:EntityTakeDamage(entity, damage_info)
	if entity:IsPlayer() and damage_info:IsDamageType(DMG_BULLET) then
		if entity:get_bleeding() == 0 then
		  if math.random(1, 10) <= 2 then
				local level = math.random(1, 3)

				entity:set_bleeding(level)
			end
		elseif entity:get_bleeding() != 3 then
			if math.random(1, 4) == 1 then
				entity:set_bleeding(entity:get_bleeding() + 1)
			end
		end
	end
end

function PLUGIN:CharacterLoaded(character)
	local player = character:GetPlayer()

	player:set_bleeding(character:GetData('bleeding', 0))
	
	character:SetData("itemblock", false)
	character:SetData("cigblock", false)
	character:SetData("fireblock", false)
	character:SetData("playblock", false)
end

function PLUGIN:PlayerDeath(player, inflictor, attacker)
	player:set_bleeding(false)
end

function PLUGIN:PlayerOneSecond(player)
	local bleeding = player:get_bleeding()

	local levels = {
		[1] = 1,
		[2] = 2,
		[3] = 4
	}

	if bleeding != 0 then
		local damage = levels[bleeding] or 1

		player:TakeDamage(damage)
	end
end

function PLUGIN:CanPlayerInteractItem(client, action, item, data)
	
	if (client:GetCharacter():GetData("itemblock", true)) then
		client:NotifyLocalized("Сейчас нельзя взаимодействовать с этим предметом!")
		return false
	end
end
