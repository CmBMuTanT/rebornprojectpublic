ITEM.name = "Medicine"
ITEM.model = "models/props_junk/garbage_metalcan001a.mdl"
ITEM.description = "..."
ITEM.width = 1
ITEM.height = 1
ITEM.adminPills = false
ITEM.category = "[REBORN] MEDICINE"
ITEM.useSound = "items/medshot4.wav"
ITEM.destroy_item = true
ITEM.quantity = 1
ITEM.healing = {}
ITEM.inventoryType = "hotkey"

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", item.quantity or 1)
		
		if (quantity > 0) then
			draw.SimpleText(quantity, "DermaDefault", w - 5, h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end
	end
end


ITEM.functions.use = {
	name = "Использовать",
	tip = "useTip",
	icon = "icon16/arrow_right.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity or 1)
		local client = item.player
		local character = client:GetCharacter()

		quantity = quantity - 1
		item:SetData("quantity", quantity)

		item.player:EmitSound(item.useSound, 70)

		if item.adminPills then

			character:SetData("diseaseInfoTemp", "Нормальная Температура")
			ix.Diseases:RemoveAllDiseases(item.player)

		end

		character:SetData("diseaseInfoTemp", "Нормальная Температура")
		ix.Diseases:DisinfectPlayer(item.player, item.healing)

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
