
RECIPE.name = "«Бинт»"
RECIPE.description = ""
RECIPE.model = "models/kek1ch/dev_bandage.mdl"
RECIPE.category = "[DONATE]"
RECIPE.KnownRecipe = RECIPE.uniqueID -- это лучше не трогать ибо это рецепт предмета

RECIPE.isDefaultLearn = false -- знает ли этот рецепт персонаж с самого начала?

--RECIPE.flag = "F" -- флаг для крафта предмета (можно и не использовать)

RECIPE.requirements = {
	["marla"] = 2, 

    -- что необходимо для крафта
}

RECIPE.results = {
	["bint"] = 4 -- что получаешь

}

 --RECIPE.tools = {
	--"wrench",
-- }


RECIPE.UsingWorkBench = true -- необходим ли для этого предмета верстак?
RECIPE.WorkBenchLevel = 1 -- какой уровень верстака необходим для крафта
RECIPE.CraftTime = 200 -- Как долго будет крафтится предмет (в секундах) (false если мгновенный крафт.)

RECIPE.WorkBenchCanUseUpper = true -- можно ли использовать верстаки более высокого уровня? (пример: мне нужно скрафтить отвертку на 1 уровне, смогу ли я его скрафтить на 2? false - нет, true - да)
RECIPE.WorkBenchUpper = {
	["ix_station_workbench1"] = 1, 
	["ix_station_workbench2"] = 2, 
	["ix_station_workbench3"] = 3, -- множитель времени
} -- сюда думаю итак знаешь что впихивать.

---------------HOOKS---------------

RECIPE:PostHook("OnCanCraft", function(self, client)
	local character = client:GetCharacter()
	local btrue
	local amountcheck = amount

	if !self.isDefaultLearn then
		for _,v in pairs(character:GetData("knownRecipes") or {}) do
			if v == self.KnownRecipe then
				if self.UsingWorkBench then
					btrue = true
				else
					return true
				end
			end
		end
	else
		if self.UsingWorkBench then
			btrue = true
		else
			return true
		end
	end

	if self.UsingWorkBench then
		if self.WorkBenchCanUseUpper then
			for k,v in pairs(self.WorkBenchUpper) do
				for _, v2 in pairs(ents.FindByClass(k)) do
					if (client:GetPos():DistToSqr(v2:GetPos()) < 100 * 100) then
						if btrue then
							return true
						end
					end
				end
			end
		else
			for _, v in pairs(ents.FindByClass("ix_station_workbench"..self.WorkBenchLevel)) do
				if (client:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
					if btrue then
						return true
					end
				end
			end
		end
	end

	if self.UsingWorkBench then
		if self.WorkBenchCanUseUpper then
			return false, "Вы должны находится около верстака "..self.WorkBenchLevel.." уровня или выше."
		else
			return false, "Вы должны находится около верстака "..self.WorkBenchLevel.." уровня."
		end
	else
		return false, "Вы не знаете этот рецепт!"
	end
end)



RECIPE:PreHook("OnCraft", function(self, client)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local trace = client:GetEyeTraceNoCursor() 
	local entTrace = trace.Entity

	if self.CraftTime then
		if self.UsingWorkBench then
			if self.WorkBenchCanUseUpper then
				for k,v in pairs(self.WorkBenchUpper) do
					for _, v2 in pairs(ents.FindByClass(k)) do
						if v2 == entTrace then
							client:SetAction("Крафчу...", self.CraftTime / v)
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
															if amountcheck == 0 then return end
															itemTable:Remove()
															goto calculation
														end
						
														if ( itemTable:GetData('stacks', 1) > amount ) then
															itemTable:SetData('stacks', itemTable:GetData('stacks', 1) - amount)
						
															if (itemTable:GetData('stacks', 1) <= 0) then
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
										return false, Format('Вам не удалось создать %s и вы потеряли свои ресурсы.', self.name)
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
							end, self.CraftTime / v, function() 
								client:SetAction()
								client:Notify("Вы должны смотреть на верстак!")
								return false
							end)
						end
					end
				end
			else
				for _, v in pairs(ents.FindByClass("ix_station_workbench"..self.WorkBenchLevel)) do
					if v == entTrace then
						client:SetAction("«Ого! Металл..»", self.CraftTime)
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
														if amountcheck == 0 then return end
														itemTable:Remove()
														goto calculation
													end
					
													if ( itemTable:GetData('stacks', 1) > amount ) then
														itemTable:SetData('stacks', itemTable:GetData('stacks', 1) - amount)
					
														if (itemTable:GetData('stacks', 1) <= 0) then
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
										return true
									end
								end
							end
						end, self.CraftTime, function() 
							client:SetAction()
							client:Notify("Вы должны смотреть на верстак!")
							return false
						end)
					end
				end
			end
			return false
		end
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