--[[ЧИСТО ПРИМЕР ОБЪЯСНЯЮЩИЙ КАК ДЕЛАТЬ РЕЦЕПТЫ]]

RECIPE.name = "Очистка воды"
RECIPE.description = "Э-э-э.. Ну, все-же лучше чем с плесенью?"
RECIPE.model = "models/props_junk/MetalBucket01a.mdl"
RECIPE.category = "«Ручное»"
RECIPE.KnownRecipe = RECIPE.uniqueID -- это лучше не трогать ибо это рецепт предмета

RECIPE.isDefaultLearn = true -- знает ли этот рецепт персонаж с самого начала?

RECIPE.requirements = {
	["bucketwithsnow"] = 1,
	["isexyidontknow26655"] = 1,
}

RECIPE.results = {
	["bucketwithwater"] = 1 -- что получаешь
--	["Предмет"] = {1, 5, 10}, -- массив на выбор (не тестил)
-- 	["Предмет"] = {["min"] = 2, ["max"] = 20}, -- массив минимального и максимального значения (не тестил)
}

-- RECIPE.tools = {
-- 	"Предмет" -- какой инструмент нужен для изготовления
-- }

RECIPE.CraftTime = 100 -- Как долго будет крафтится предмет (в секундах) (false если мгновенный крафт.)

---------------HOOKS---------------

---ONLY SHITCODE---
RECIPE:PreHook("OnCraft", function(self, client)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local amountcheck = 0

	if self.CraftTime then
		client:Freeze(true)
		client:SetAction("Растворяем таблетки..", self.CraftTime, function()
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
										if amountcheck == 0 then client:Freeze(false) return end

										itemTable:Remove()
										goto calculation
									end
	
									if ( itemTable:GetData('stacks', 1) > amount ) then
										itemTable:SetData('stacks', itemTable:GetData('stacks', 1) - amount)
	
										if (itemTable:GetData('stacks', 1) <= 0) then
											amountcheck = amount
											if amountcheck == 0 then client:Freeze(false) return end
											itemTable:Remove()
										end
										ffAmount = amount
										goto calculation
									end
	
									client:Notify("Вам нужно собрать использованные материалы в одну стопку")
									client:Freeze(false)
									return
								else
									amountcheck = amount
									if amountcheck == 0 then client:Freeze(false) return end
									itemTable:Remove()
								end
							else
								amountcheck = amount
								if amountcheck == 0 then client:Freeze(false) return end
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
						if amountcheck == 0 then client:Freeze(false) return end

						if (!inventory:Add(uniqueID)) then
							ix.item.Spawn(uniqueID, client)
						end

						client:Freeze(false)
						client:NotifyLocalized("CraftSuccess", self.GetName and self:GetName() or self.name)
						return true
					end
				end
			end

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