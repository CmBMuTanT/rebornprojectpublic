RECIPE.name = "Хлебная лепешка"
RECIPE.description = "Массивный шматок хлеба, внутри которого содержаться дольки грибов.. М-м-м! Боже, я сейчас упаду, у меня гастрономический оргазм! Кстати, это блюдо очень сухое!"
RECIPE.model = "models/kek1ch/notes_paper_2.mdl"
RECIPE.category = "«Готовка»"


RECIPE.KnownRecipe = RECIPE.uniqueID -- это лучше не трогать ибо это рецепт предмета
RECIPE.isDefaultLearn = false -- не трожь это.

RECIPE.requirements = {
	["mooka"] = 2, 
	["vegan_mushroom"] = 1,-- что необходимо для крафта
}

RECIPE.results = {
	["shitfood_bredlepes"] = 1 -- что получаешь
}

RECIPE.CraftTime = 75-- Как долго будет крафтится предмет (в секундах) (false если мгновенный крафт.)

RECIPE.StationNeed = "ix_station_duhovk" -- какая необходима станция для крафта

---------------HOOKS---------------

RECIPE:PostHook("OnCanCraft", function(self, client)
	local character = client:GetCharacter()

	for _, v in pairs(ents.FindByClass(self.StationNeed)) do
		if (client:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
			return true
		end
	end

	return false, "Вы должны быть около обогревательной станции!"
end)


RECIPE:PreHook("OnCraft", function(self, client)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local trace = client:GetEyeTraceNoCursor() 
	local entTrace = trace.Entity
	local amountcheck = 0

	if self.CraftTime then
		client:SetAction("Готовим..", self.CraftTime)
		client:DoStaredAction(entTrace, function()

			if (self.requirements) then
				local removedItems = {}
	
				for _, itemTable in pairs(inventory:GetItems()) do
					local uniqueID = itemTable.uniqueID
	
					if (self.requirements[uniqueID]) then
						local amountRemoved = removedItems[uniqueID] or 0
						local amount = self.requirements[uniqueID]
	
						if (amountRemoved < amount) then
							local ffAmount = 1
	
							if (itemTable.base) then
								if (itemTable.base == 'base_rebornitems') then
									if ( itemTable:GetData('stacks', 1) == amount ) then
										amountcheck = amount
										if amountcheck == 0 then return end
										itemTable:Remove()
										goto calculation
									end
	
									if ( itemTable:GetData('stacks', 1) > amount ) then
										itemTable:SetData('stacks', itemTable:GetData('stacks', 1) - amount)
	
										if (itemTable:GetData('stacks', 1) <= 0) then
											amountcheck = amount
											if amountcheck == 0 then return end
											itemTable:Remove()
										end
										ffAmount = amount
										goto calculation
									end
	
									client:Notify("Вам нужно собрать использованные материалы в одну стопку")
									return false
								else
									amountcheck = amount
									if amountcheck == 0 then return end
									itemTable:Remove()
								end
							else
								amountcheck = amount
								if amountcheck == 0 then return end
								itemTable:Remove()
							end
	
							::calculation::
							removedItems[uniqueID] = amountRemoved + ffAmount
						end
					end
				end
			end
	
			
			for uniqueID, amount in pairs(self.results or {}) do
				if (istable(amount)) then
					if (amount["min"] and amount["max"]) then
						amount = math.random(amount["min"], amount["max"])
					else
						amount = amount[math.random(1, #amount)]
					end
				end
	
				if amount == 0 then
					return false, Format('You failed to create %s and lost your resources.', self.name)
				else
					for i = 1, amount do
						if amountcheck == 0 then return end

						if (!inventory:Add(uniqueID)) then
							ix.item.Spawn(uniqueID, client)
						end

						client:NotifyLocalized("CraftSuccess", self.GetName and self:GetName() or self.name)
					end
					return true
				end
			end

		end, self.CraftTime, function()
			client:SetAction()
			client:Notify("Вы должны смотреть на стол!")
			return false
		end)
	else
		if (self.requirements) then
			local removedItems = {}

			for _, itemTable in pairs(inventory:GetItems()) do
				local uniqueID = itemTable.uniqueID

				if (self.requirements[uniqueID]) then
					local amountRemoved = removedItems[uniqueID] or 0
					local amount = self.requirements[uniqueID]

					if (amountRemoved < amount) then
						local ffAmount = 1

						if (itemTable.base) then
							if (itemTable.base == 'base_rebornitems') then
								if ( itemTable:GetData('stacks', 1) == amount ) then
									itemTable:Remove()
									goto calculation
								end

								if ( itemTable:GetData('stacks', 1) > amount ) then
									itemTable:SetData('stacks', itemTable:GetData('stacks', 1) - amount)

									if (itemTable:GetData('stacks', 1) <= 0) then
										itemTable:Remove()
									end
									ffAmount = amount
									goto calculation
								end

								client:Notify("Вам нужно собрать использованные материалы в одну стопку")
								return false
							else
								amountcheck = amount
								if amountcheck == 0 then return end
								itemTable:Remove()
							end
						else
							amountcheck = amount
							if amountcheck == 0 then return end
							itemTable:Remove()
						end

						::calculation::
						removedItems[uniqueID] = amountRemoved + ffAmount
					end
				end
			end
		end

		
		for uniqueID, amount in pairs(self.results or {}) do
			if (istable(amount)) then
				if (amount["min"] and amount["max"]) then
					amount = math.random(amount["min"], amount["max"])
				else
					amount = amount[math.random(1, #amount)]
				end
			end

			if amount == 0 then
				return false, Format('You failed to create %s and lost your resources.', self.name)
			else
				for i = 1, amount do
					if amountcheck == 0 then return end

					if (!inventory:Add(uniqueID)) then
						ix.item.Spawn(uniqueID, client)
					end

					client:NotifyLocalized("CraftSuccess", self.GetName and self:GetName() or self.name)
					return true
				end
			end
		end
	end

	return false
end)