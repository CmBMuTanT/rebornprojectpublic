include("shared.lua")
local PLUGIN = PLUGIN

function ENT:Initialize()
    -- self.knifeent = ClientsideModel("models/weapons/doi/w_marinebayonet.mdl")
    -- self.knifeent:Spawn()
end

--custom cursor
function xCursorcustom(x, y, w, h, imgui)
	local fgColor = imgui.IsPressing() and imgui.skin.foregroundPress or imgui.skin.foreground
	local mx, my = imgui.CursorPos()

	if not mx or not my then return end

	if x and w and (mx < x or mx > x + w) then return end
	if y and h and (my < y or my > y + h) then return end

	local cursorSize = math.ceil(0.3 / 0.1)
	surface.SetDrawColor(fgColor)

    surface.SetMaterial(Material("mutantsimgs/cursor.png"))
    surface.DrawTexturedRect(mx - cursorSize, my - cursorSize, cursorSize * 4, cursorSize * 5)
end

function ENT:Draw()
    self:DrawModel()
    local imgui = PLUGIN.IMGUI
    
    if imgui.Entity3D2D(self, Vector(0, 0, 18.2), Angle(0, 90, 0), 0.1) then

        draw.RoundedBox(3, -338, -198, 676, 396, Color(25, 25, 25, 230))
        draw.DrawText("Кулинарный стол", "DermaLarge", 0, -198, Color(255, 255, 255), TEXT_ALIGN_CENTER)

        local foodbutton = imgui.xButton(-80, -80, 150, 150, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
        local knifebutton = imgui.xButton(200, 50, 100, 100, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
        

        --meat
        if foodbutton then
            --funcs()
        elseif imgui.IsHovering(-80, -80, 150, 150) then
            surface.SetDrawColor( 80, 80, 80, 255 )
        else
            surface.SetDrawColor( 255, 255, 255, 255 )
        end

        surface.SetMaterial( Material("mutantsimgs/meat.png") )
        surface.DrawTexturedRect( -80, -80, 150, 150 )

        --knife
        if knifebutton then
            --funcs()
        elseif imgui.IsHovering(200, 50, 100, 100) then
            surface.SetDrawColor( 80, 80, 80, 255 )
        else
            surface.SetDrawColor( 255, 255, 255, 255 )
        end

        surface.SetMaterial( Material("mutantsimgs/knife.png") )
        surface.DrawTexturedRect( 200, 50, 100, 100 )


        --ETC
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( Material("mutantsimgs/arrows.png") )
        surface.DrawTexturedRect( -190, -50, 100, 100 )

        surface.SetDrawColor(Color(255, 255, 255))
        surface.DrawOutlinedRect(-310, -50, 110, 110, 4)
        --cursor
        local x,y = -338, -198
        local w, h = 676, 396
        xCursorcustom(x,y,w,h, imgui)

    imgui.End3D2D() end
end
