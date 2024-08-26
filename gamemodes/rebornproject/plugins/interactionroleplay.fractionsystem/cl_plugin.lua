local PLUGIN = PLUGIN

local Already = false
function PLUGIN:HUDPaint()
	for _, entity in pairs(ents.FindByClass("ix_newshipment")) do
        if LocalPlayer():Team() != entity:GetNetVar("faction") then return end
        local dist = LocalPlayer():GetPos():Distance(entity:GetPos())
		local Position = ( entity:GetPos() + Vector( 0,0,25 ) ):ToScreen()
        local iconSize = math.Clamp(500 / dist, 28, 28)

        if dist <= 5000 then -- тут очень сильно зависит от карты, так что я поставил на 5000 юнитов, но ты можешь изменить на большее значение
            if !Already then
                chat.AddText(Color(0, 255, 0), "Около вас находится поставка, на нее поставлена метка.")
                LocalPlayer():EmitSound("buttons/blip1.wav")
                Already = true
            end

            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(Material("icon16/box.png"))
            surface.DrawTexturedRect(Position.x - 15, Position.y + 10, iconSize, iconSize)
            draw.DrawText( string.format("%.i м", dist), "Default", Position.x, Position.y, Color( 255, 255, 255), 1 )
        else
            Already = false
        end
	end
end --)