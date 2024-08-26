ITEM.name = "Food base"
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.description = "This is base a food."
ITEM.category = "[REBORN] Еда самоприготовления"

ITEM.width = 1
ITEM.height = 1

ITEM.quantity = 0

ITEM.thirst_amount = 0
ITEM.hunger_amount = 0


ITEM.EQSsound = nil

ITEM.destroy_item = true
ITEM.empty_item = nil

ITEM.IsFluid = false -- для жидкостей.
ITEM.IsVegan = false -- это фрукт/овощ?
ITEM.IsMeat = false -- это мясо?

ITEM.Type = "raw"
ITEM.quality = 0
ITEM.inventoryType = "hotkey"

ITEM.Typetbl = {
	["dirty"] = {
		["color"] = Color(193, 115, 48),
		["name"] = "Грязное",

		["SVcallback"] = function(item, client) -- функция на дебаффы и прочее говно, так проще убирать или добавлять то или другое смотря по типу.
			ix.Diseases:InfectPlayer(client, "poisoning" ) -- сразу же заражаем отравлением
		end,
	},

	["dirtynope"] = {
		["color"] = Color(193, 115, 48),
		["name"] = "Испорченное",

		["SVcallback"] = function(item, client) -- функция на дебаффы и прочее говно, так проще убирать или добавлять то или другое смотря по типу.
			ix.Diseases:InfectPlayer(client, "poisoning" ) -- сразу же заражаем отравлением
		end,
	},

	["rotten"] = {
		["color"] = Color(43, 95, 51),
		["name"] = "Гнилое",

		["SVcallback"] = function(item, client)
			if math.random(3) == 1 then -- 25/75
				ix.Diseases:InfectPlayer(client, "poisoning" )
			end
		end,
	},

	["raw"] = {
		["color"] = Color(216, 216, 216),
		["name"] = "Сырое",

		["SVcallback"] = function(item, client)
			if math.random(2) == 1 then -- 50/50
				ix.Diseases:InfectPlayer(client, "poisoning" )
			end
		end,
	},

	["clean"] = {
		["color"] = Color(0, 177, 186),
		["name"] = "Чистое",

		["SVcallback"] = function(item, client)

		end,
	},

	["fried"] = {
		["color"] = Color(137, 37, 0),
		["name"] = "Жаренное",

		["SVcallback"] = function(item, client)

		end,
	},

	["boiled"] = {
		["color"] = Color(191, 161, 91),
		["name"] = 	"Варенное",

		["SVcallback"] = function(item, client)

		end,
	},

	["baked"] = {
		["color"] = Color(215, 111, 6),
		["name"] = 	"Запеченное",

		["SVcallback"] = function(item, client)

		end,
	},
}


if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", item.quantity or 1)
		
		if (quantity > 0) then
			draw.SimpleText(quantity, "DermaDefault", w - 5, h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end
	end
	
	function ITEM:GetDescription()
		local quantity = self:GetData("quantity", self.quantity or 1)
		if (quantity <= 0) then
			return self.description
		end
		
		local str = self.description .. "\n\nКоличество: "..quantity
		

		return str
	end

	function ITEM:PopulateTooltip(tooltip)

		if self:GetData("type") ~= nil then
			local typetooltip = tooltip:AddRowAfter("description", "typetooltip")
			typetooltip:SetText(self.Typetbl[self:GetData("type")]["name"])
			typetooltip:SetBackgroundColor(self.Typetbl[self:GetData("type")]["color"])
			typetooltip:SizeToContents()
		end

		if isnumber(self:GetData("quality", nil)) then
			local quality = tooltip:AddRowAfter("description", "quality")
			quality:SetText("Качество: "..self:GetData("quality", 0).."%")
			quality:SetBackgroundColor(Color(255, 255, 0))
			quality:SizeToContents()
		end

		if !table.IsEmpty(self:GetData("ingredients", {})) then
			local ingredients = {}
			for i, v in ipairs(self:GetData("ingredients", {})) do
				if v ~= 1 then
					table.insert(ingredients, v)
				end
			end

			local ingredients_str = ""
			if #ingredients ~= 0 then
				ingredients_str = "Ингридиенты: ".. table.concat(ingredients, "; ")
			end
			
			local ingredients = tooltip:AddRowAfter("description", "ingredients")
			ingredients:SetText(ingredients_str)
			ingredients:SetBackgroundColor(Color(94, 255, 0))
			ingredients:SizeToContents()
		end
	end
end

function ITEM:OnInstanced(invID, x, y, item)
	item:SetData("quantity", item.quantity or 1) -- это количество
	item:SetData("type", item.Type) -- это тип
    item:SetData("ingredients", {})
    item:SetData("quality", item.quality) -- это качество

	item:SetData("saturation", {
		["thirst"] = item.thirst_amount, 
		["hunger"] = item.hunger_amount
	}) -- ага да

	if item.IsVegan or item.IsFluid or item.IsMeat then
		item:SetData("quality", 100)
	end
end


ITEM.functions.use = {
    name = "Употребить",
	icon = "icon16/cup.png",
    OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity or 1)
		
		quantity = quantity - 1
		item:SetData("quantity", quantity)
		
		local client = item.player
		
		if item.EQSsound then
			client:EmitSound(item.EQSsound) 
		end


		item.Typetbl[item:GetData("type")]["SVcallback"](item, client) -- удобно на самом деле.

		 if (item:GetData("saturation")["thirst"] ~= 0) then
		 	client:AddThirstVar(item:GetData("saturation")["thirst"])
		 end
		
		 if (item:GetData("saturation")["hunger"] ~= 0) then
		 	client:AddHungerVar(item:GetData("saturation")["hunger"])
		 end
		
		if (quantity <= 0) then
			if (item.empty_item and ix.item.Get(item.empty_item)) then
				if (!client:GetCharacter():GetInventory():Add(item.empty_item)) then
					ix.item.Spawn(item.empty_item, client)
					return true
				end
			end
			
			if (item.destroy_item) then
				return true
			else
				item:SetData("type", "dirty")
				item:SetData("ingredients", nil)
				item:SetData("quality", 0)
			end
		end

        return false
	end,
	
	OnCanRun = function(item)
		if (item:GetData("quantity", item.quantity or 1) <= 0) then
			return false
		end
		
		return true
	end
}

ITEM.functions.add = {
    name = "Добавить ингридиент",
    tip = "useTip",
    icon = "icon16/add.png",
    isMulti = true,
    multiOptions = function( item, client )
        local targets = {}

        for k, v in next, client:GetCharacter():GetInventory():GetItems() do
            if v.base == "base_newfood" and v.quantity ~= 0 then
                table.insert( targets, {
                    name = v.name,
                    data = {v.id, v.name},
                } )
            end
        end

        return targets
    end,
    OnCanRun = function( item )
        local client = item.player
        return !IsValid(item.entity) and IsValid(client) and item.invID == client:GetCharacter():GetInventory():GetID() and item.quantity == 0 and item:GetData("MaxIngredients", 0) ~= item.MaxIngredients
    end,
	OnRun = function( item, data )
		if data and data[1] and data[2] then
			local client = item.player
			local item2 = client:GetCharacter():GetInventory():GetItemByID( data[1], true )
			if not item2 then return false end
	
			local keywords = {
				"Бутылка с",
				"Банка с",
				"Тара с",
				"Флакон с",
				"Фляга с",
				"Канистра с"
			}
	
			local matchedKeyword = nil
	
			for _, keyword in ipairs(keywords) do
				if string.find(data[2], keyword) then
					matchedKeyword = keyword
					break
				end
			end

			if matchedKeyword then
				data[2] = string.gsub(data[2], matchedKeyword, "Жидкость с")
				item:SetData("type", "clean")
			end
	
			if item:GetData("type") ~= "clean" then item:SetData("type", "raw") end

			local currentIngredients = item:GetData("ingredients") or {}
			table.insert(currentIngredients, data[2])
			item:SetData("ingredients", currentIngredients)
			item:SetData("MaxIngredients", item:GetData("MaxIngredients", 0) + 1)
			item:SetData("quality", item:GetData("quality", 0))
			item:SetData("quantity", item:GetData("quantity", 0) + 1)

			if !table.IsEmpty(item:GetData("saturation")) and !table.IsEmpty(item2:GetData("saturation")) then
				local saturation1 = item:GetData("saturation")
				local saturation2 = item2:GetData("saturation")
	
				for k, v in pairs(saturation2) do
					saturation1[k] = (saturation1[k] or 0) + v
				end

				for k, v in pairs(saturation1) do
					if v < 0 then
						local cookatt = client:GetCharacter():GetAttribute("cook", 0)
						local correction = 0
	
						if cookatt >= 100 then
							correction = math.random(0, 3)
						elseif cookatt >= 50 then
							correction = math.random(0, 1)
						else
							correction = math.random(-3, 0)
						end
	
						saturation1[k] = v + correction
					end
				end

				item:SetData("saturation", saturation1)
			end

			item2:Remove()
		end
	
		return false
	end,
}


ITEM.functions.addto = {
    name = "Положить",
    tip = "useTip",
    icon = "icon16/add.png",
    isMulti = true,
    multiOptions = function( item, client )
        local targets = {}

        for k, v in next, client:GetCharacter():GetInventory():GetItems() do
            if v.base == "base_newfood" and item:GetData("Maxquantity", 0) ~= item.Maxquantity and v.IsDishes then
				local ingredients = item:GetData("ingredients")
				local dataToInsert
		
				if ingredients and #ingredients > 0 then
					dataToInsert = ingredients
				else
					dataToInsert = item.name
				end

				
                table.insert( targets, {
                    name = v.name,
                    data = {v.id, v.name, dataToInsert},
                } )
            end
        end

        return targets
    end,
    OnCanRun = function( item )
        local client = item.player
        return !IsValid(item.entity) and IsValid(client) and item.invID == client:GetCharacter():GetInventory():GetID() and item:GetData("quantity", 0) ~= 0 and item:GetData("Maxquantity", 0) ~= item.Maxquantity and !item.IsDishes
    end,
	OnRun = function( item, data )
		if data and data[1] and data[2] and data[3] then
			local client = item.player
			local item2 = client:GetCharacter():GetInventory():GetItemByID( data[1], true )

			if not item2 then return false end


			if isstring(data[3]) then
				local ingredients = item2:GetData("ingredients", {}) 
				table.insert(ingredients, data[3])
				item2:SetData("ingredients", ingredients) 
			else
				item2:SetData("ingredients", data[3])
			end

			

			item2:SetData("Maxquantity", item2:GetData("Maxquantity", 0) + 1)
			item2:SetData("type", item:GetData("type", "raw"))
			item2:SetData("quality", item:GetData("quality", 0))
			item2:SetData("saturation", item:GetData("saturation"))

			item2:SetData("quantity", item2:GetData("quantity", 0) + 1)
			item:SetData("quantity", item:GetData("quantity", 0) - 1)

			if item:GetData("quantity") <= 0 then
				if (item.destroy_item) then
					return true
				else
					item:SetData("type", "dirty")
					item:SetData("ingredients", nil)
					item:SetData("quality", 0)
				end
			end
		end
	
		return false
	end,
}