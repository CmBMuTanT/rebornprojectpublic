ITEM.name = "Рация"
ITEM.description= "Позволяет общаться на дистанции.Выбирите частоту и нажмите X+ЛевыйAlt"
ITEM.category = "[REBORN] ELECTRONIC"
ITEM.model = "models/metro_redux/other_exodus/walkie_talkie.mdl"
ITEM.inventoryType = "unload"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1

ITEM.inventoryType = "radio"

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
		else
			surface.SetDrawColor(255, 110, 110, 100)
		end

		surface.DrawRect(w - 14, h - 14, 8, 8)
	end
end

function ITEM:OnInstanced()
   -- self:SetData("power")
    
end


function ITEM:Equip(client)
   -- self:SetData("power", !self:GetData("power", false), nil, nil)

    if self:GetData("equip") then

        client:EmitSound("weapons/flaymi/stalker/anomaly/pda/pda_welcome.wav", 30)
    end
end


ITEM.functions.use = {
	name = "Частота",
	tip = "useTip",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		netstream.Start(item.player, "radioAdjust", item:GetData("freq", "000,0"), item.id)
		return false
	end,
}
