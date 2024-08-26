ITEM.name = "Repair Kit Base"
ITEM.category = "RepairKit"
ITEM.description = "The repair kit repairs %s units of the durability."
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.useSound = "interface/inv_repair_kit.ogg"
ITEM.width = 1
ITEM.height = 1

ITEM.durability = 25 -- На сколько рем комплект сможет починить предмет при 100% прокачке аттрибута?
ITEM.quantity = 1 -- через сколько использований рем комплект сломается?

ITEM.isWeaponKit = true -- Only allowed for weapons.

if SERVER then
	function ITEM:UseRepair(item, ply)
		local character = ply:GetCharacter()
		local max_dur = item.maxDurability or ix.config.Get("maxValueDurability", 100)

		local add_dur = math.floor(self.durability * character:GetAttribute("entretien", 0))

		if add_dur > 0 then
			local new_dur = item:GetData("durability", max_dur) + add_dur
			item:SetData("durability", math.Clamp(new_dur, 0, max_dur))
		else
			ply:ChatPrint("Ваш навык техника слишком плох, у вас не получилось починить предмет!")
		end
	end
else
	function ITEM:PaintOver(item, w, h)
		local quantity = item:GetData("quantity", item.quantity or 1)

		if (quantity > 0) then
			draw.SimpleText(quantity, "DermaDefault", w - 5, h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end
	end

	function ITEM:GetDescription()
		return Format(self.description, self.durability)
	end
end

function ITEM:OnInstanced(invID, x, y, item)
	item:SetData("quantity", item.quantity or 1)
end