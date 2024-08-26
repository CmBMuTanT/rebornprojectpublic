function PLUGIN:LoadData()

    if timer.Exists("ixAreaThink") then
        timer.Remove("ixAreaThink")
    end

	timer.Simple(1, function() -- постоянно перезаписывает с плагина хеликса, а новый таймер я создавать не хочу, это нагрузка.
		timer.Create("ixAreaThink", ix.config.Get("areaTickTime"), 0, function()
			self:AreaThink()
		end)
	end)
end

-- local delay = math.random(2, 5)
-- local nextOccurance = 0

function PLUGIN:AreaThink()
	for _, client in ipairs(player.GetAll()) do
		local character = client:GetCharacter()

		if (!client:Alive() or !character) then
			continue
		end

		local overlappingBoxes = {}
		local position = client:GetPos() + client:OBBCenter()

		for id, info in pairs(ix.area.stored) do
			if (position:WithinAABox(info.startPosition, info.endPosition)) then
				overlappingBoxes[#overlappingBoxes + 1] = id
				
				if info.type == "RadiationZone" then

					if client:GetMoveType() == MOVETYPE_NOCLIP then return end
					--[[ OLD, with Damage

					local damage = DamageInfo()
					damage:SetDamage( math.random(2, 8) )
					damage:SetAttacker( game.GetWorld() )
					damage:SetDamageType( DMG_RADIATION )
					
					client:TakeDamageInfo( damage )
					]]


					--NEW with rad collect into player
					--local timeLeft = nextOccurance - CurTime()
					--local item = character:GetInventory():HasItem("dosimetr") or character:GetInventory():HasItem("geiger")
					local radinv = client:ExtraInventory("armband")
					local item = radinv:GetEquipedItem()
					local inv = client:ExtraInventory("head_gasmask")

					if client.firsttime and item and item.uniqueID == "dosimetr" and item:GetData("Equip", true) and item:GetData("BatteryCondition") ~= nil and item:GetData("BatteryCondition") > 1 then
						client:EmitSound("HL1/fvox/radiation_detected.wav", 75, 90)
						client.firsttime = false
					end

					--if timeLeft < 0 then
						--local randomOccurance = math.random(2, 5)

						if item and item:GetData("Equip", true) and item:GetData("BatteryCondition") ~= nil and item:GetData("BatteryCondition") > 1  then
								
							if info.properties.Radiationamount >= 3 then -- Тяжелая зона
								client:EmitSound("player/geiger3.wav")
							elseif info.properties.Radiationamount > 1 then -- Средняя зона
								client:EmitSound("player/geiger2.wav")
							else
								client:EmitSound("player/geiger1.wav") -- Легкая зона
							end

						end

						if inv and inv:GetEquipedItem() and inv:GetEquipedItem():GetData("FilterTime") > 0 then
							local gasmaskdata = inv:GetEquipedItem():GetData("FilterTime")

							--inv:GetEquipedItem():SetData("FilterTime", math.max(0, gasmaskdata - randomOccurance))
							inv:GetEquipedItem():SetData("FilterTime", math.max(0, gasmaskdata - 1))
						else
							character:SetData("RadAmount", character:GetData("RadAmount", 0) + info.properties.Radiationamount)
						end
						--nextOccurance = CurTime() + randomOccurance
					--end
				end
			end
		end

		if (#overlappingBoxes > 0) then
			local oldID = client:GetArea()
			local id = overlappingBoxes[1]

			if (oldID != id) then
				hook.Run("OnPlayerAreaChanged", client, client.ixArea, id)
				client.ixArea = id
			end

			client.ixInArea = true
		else
			client.ixInArea = false
			client.firsttime = true
		end
	end
end


local delay2 = 5
local nextOccurance = 0

function PLUGIN:Think() -- ебучие тики знаю, но я их сделал как таймер, по 5 секунд, так что все ок считай как таймер, ибо просто таймер добавлять не особо то и хочется. (но и забавно будет, ибо дамажить будет всех одновременно XDD)
	local timeLeft = nextOccurance - CurTime()

	if timeLeft < 0 then
		for _, client in ipairs(player.GetAll()) do

			local character = client:GetCharacter()

			if (!client:Alive() or !character) then
				continue
			end

			if character:GetData("RadAmount", 0) >= 100 then -- тут элзифы они же симптомы, но оно никак не влияет на оптимизацию
				local damage = DamageInfo()
				damage:SetDamage( math.random(2, 5) )
				damage:SetAttacker( game.GetWorld() )
				damage:SetDamageType( DMG_RADIATION )
				client:TakeDamageInfo( damage )
				client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 0.1 )
				client:ConsumeStamina(100)

				if math.random(2) == 2 then -- 50% на то что он блеванет и ему нанесется дополнительный урон
					util.Decal("Blood", client:GetPos(), client:GetPos() - Vector(0, 0, 64), client )
					client:EmitSound("npc/barnacle/barnacle_die1.wav")
					ix.chat.Send(client, "me", "Критически плохо себя чувствует что начинает блевать кровью")

					client:SetHealth(math.max(0, client:Health() - 3))
				end
			elseif character:GetData("RadAmount", 0) >= 75 then
				if math.random(6) == 6 then
					if client:GetLocalVar("ragdoll") then return end
					client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 0.1 )
					client:ConsumeStamina(75)
					util.Decal("YellowBlood", client:GetPos(), client:GetPos() - Vector(0, 0, 64), client )
					client:EmitSound("npc/barnacle/barnacle_die1.wav")
					ix.chat.Send(client, "me", "Настолько плохо себя чувствует, что его рвет желчью с кровью")
				end  -- чисто прикол как раз на рвоту и стамину с 33% шанса

				-- ну и классику дублируем чтоб падал в обморок
				if math.random(6) == 6 then -- уже вероятность 25%
					if client:GetLocalVar("ragdoll") then return end

					ix.chat.Send(client, "me", "Плохо себя чувствует и упал в короткий обморок")
					client:SetRagdolled(true, 6)
				end
			
			elseif character:GetData("RadAmount", 0) >= 50 then
				if math.random(8) == 8 then -- маленький шанс что он упадет в обморок
					if client:GetLocalVar("ragdoll") then return end -- если он уже упал

					ix.chat.Send(client, "me", "Плохо себя чувствует и упал в короткий обморок")
					client:SetRagdolled(true, 4)
				end
			end

			character:SetData("RadAmount", math.max(0, character:GetData("RadAmount", 0) - 0.1)) -- будем убирать по чуть-чуть, но можно и убрать если не надо. Но лучше не стоит, пусть убирает каждые 5 секунд.
			client:SetNetVar("RadAmount", character:GetData("RadAmount", 0))
		end
		nextOccurance = CurTime() + delay2
	end
end


function PLUGIN:PlayerDeath(client)
	local char = client:GetCharacter()

	if char then
		char:SetData("RadAmount", 0)
	end
end