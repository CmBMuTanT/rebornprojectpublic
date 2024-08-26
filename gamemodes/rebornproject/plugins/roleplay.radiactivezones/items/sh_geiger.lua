ITEM.name = "Счетчик Гейгера"
ITEM.description = "Обычный старый счетчик Гейгера, максимум что он может сделать, так это условно узнать есть ли радиация."
ITEM.category = "[REBORN] ELECTRONIC"
ITEM.width = 1
ITEM.height = 1

ITEM.exRender = true
ITEM.model = "models/cmbmtk/eft/diagset.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(89.77, 0.19, 0),
	fov = 3.7
}


ITEM.inventoryType = "armband"

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("Equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end


-- ITEM.functions.equip = {
-- 	name = "Включить/Выключить",
-- 	tip = "useTip",
-- 	icon = "icon16/arrow_up.png",
-- 	OnRun = function(item)
-- 		local client = item.player

--         if item:GetData("Equip", false) == false then
--             item:SetData("Equip", true)
--             client:EmitSound("buttons/button14.wav", 75, 110)
--         else
--             item:SetData("Equip", false)
--             client:EmitSound("buttons/button17.wav", 75, 110)
--         end
		
-- 		return false
-- 	end,
--     OnCanRun = function(item)
-- 		return !IsValid(item.entity)
-- 	end
-- }

if SERVER then
	function ITEM:Equip(client)
		self:SetData("Equip", true)
		client:EmitSound("buttons/button14.wav", 75, 110)
	end

	function ITEM:Unequip(client)
		self:SetData("Equip", false)
		client:EmitSound("buttons/button17.wav", 75, 110)
	end
end
