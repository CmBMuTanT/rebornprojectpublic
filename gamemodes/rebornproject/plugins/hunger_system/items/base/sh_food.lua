ITEM.name = "Food base"
ITEM.model = Model("models/props_junk/popcan01a.mdl")
ITEM.description = "This is base a food."

ITEM.width = 1
ITEM.height = 1

ITEM.quantity = 1

ITEM.destroy_item = true

-- В процентах от -100 до 100.
ITEM.thirst_amount = 0
ITEM.hunger_amount = 0
ITEM.drunk_amount = 0

ITEM.EQSsound = nil

ITEM.category = "[REBORN] FOOD"

ITEM.ViewModel = nil
ITEM.inventoryType = "hotkey"

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
		
		local str = self.description .. "\n\nКоличество "..quantity..""
		
		local cooklevel = self:GetData("cooklevel", 0)
		
		if (cooklevel > 0) then
			str = (str .. "\n" .. "Качество: ".. COOKLEVEL[cooklevel][2])
		end

		return str
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
		local mul = COOKLEVEL[item:GetData("cooklevel", 0)][1]
		
		if mul < 1 then
			mul = 1
		end
		
		if item.EQSsound then
		client:EmitSound(item.EQSsound) 
		end

		if item.ViewModel != nil then
		
			local wep = nil
		
			if IsValid(client:GetActiveWeapon()) then 
				wep = client:GetActiveWeapon():GetClass()
			end
		
			
			if SERVER then
			
				client.last_weapon = wep
			
				client:Give(item.ViewModel)
				
				client.foodmodel = item.ViewModel
				
				client.thirst_amount = item.thirst_amount
				client.hunger_amount = item.hunger_amount
				client.drunk_amount = item.drunk_amount
				
				client:SelectWeapon(item.ViewModel)
				
			end
			
		end
		
		if (item.thirst_amount ~= 0) then
			client:AddThirstVar(item.thirst_amount * mul)
		end
		
		if (item.hunger_amount ~= 0) then
			client:AddHungerVar(item.hunger_amount * mul)
		end
		
		if (item.drunk_amount ~= 0) then
			client:AddDrunkVar(item.drunk_amount)
		end
		
		if (math.random(1, 5) == 3) then
			client:SetHealth(math.Clamp(client:Health() + math.random(1, 10), 0, client:GetMaxHealth()))
		end
		
		client:EmitSound("player/pl_scout_dodge_can_drink.wav", 50, 75)
		
		if (quantity <= 0) then
			if (item.empty_item and ix.item.Get(item.empty_item)) then
				if (!client:GetCharacter():GetInventory():Add(item.empty_item)) then
					ix.item.Spawn(item.empty_item, client)
					return true
				end
			end
			
			if (item.destroy_item) then
				return true
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

function ITEM:OnInstanced(invID, x, y, item)
	item:SetData("quantity", item.quantity or 1)
end
