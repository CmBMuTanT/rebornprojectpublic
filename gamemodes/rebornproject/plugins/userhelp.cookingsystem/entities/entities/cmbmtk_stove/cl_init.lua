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

function LerpColor(frac,from,to)
	local col = Color(
		Lerp(frac,from.r,to.r),
		Lerp(frac,from.g,to.g),
		Lerp(frac,from.b,to.b),
		Lerp(frac,from.a,to.a)
	)
	return col
end

function ENT:Draw()
    self:DrawModel()

    if LocalPlayer():GetPos():Distance(self:GetPos()) > 100 then return end

    local imgui = PLUGIN.IMGUI

    if imgui.Entity3D2D(self, Vector(0, -51, 2), Angle(0, 90, 0), 0.1) then
        draw.RoundedBox(3, -290, -150, 538, 301, Color(25, 25, 25, 230))

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( Material("mutantsimgs/arrows.png") )
        surface.DrawTexturedRect( 140, -50, 100, 100 )

        surface.SetDrawColor(Color(255, 255, 255))
        surface.DrawOutlinedRect( 20, -50, 110, 110, 4)
        
    imgui.End3D2D() end

    
    if imgui.Entity3D2D(self, Vector(14.2, 0, 0), Angle(0, 90, 90), 0.1) then
        draw.RoundedBox(3, -250, -176, 500, 330, Color(25, 25, 25, 230))

        if self:GetIgnite() == false then
            local gasbutton = imgui.xButton(-250, -50, 200, 200, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
            local grill = imgui.xButton(50, -130, 150, 150, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))

            if gasbutton then
                netstream.Start("cmbmtk:gasoline", self)
            elseif imgui.IsHovering(-250, -50, 200, 200) then
                surface.SetDrawColor( 80, 80, 80, 255 )
            else
                surface.SetDrawColor( 255, 255, 255, 255 )
            end
            surface.SetMaterial( Material("mutantsimgs/gasbalon.png") )
            surface.DrawTexturedRect( -220, -50, 140, 200 )


            if grill then
                local panel = vgui.Create("CMBMTK:ChoiceButton")
                panel:Status("bake", self)
            elseif imgui.IsHovering(50, -130, 150, 150) then
                surface.SetDrawColor( 80, 80, 80, 255 )
            else
                surface.SetDrawColor( 255, 255, 255, 255 )
            end
            surface.SetMaterial( Material("mutantsimgs/grill.png") )
            surface.DrawTexturedRect(50, -130, 150, 150)
        end


        local x,y = -250, -176
        local w, h = 500, 330
        xCursorcustom(x,y,w,h, imgui)
    imgui.End3D2D() end

    if imgui.Entity3D2D(self, Vector(0, 0, 20.1), Angle(0, 90, 0), 0.1) then

        draw.RoundedBox(3, -264, -176, 520, 330, Color(25, 25, 25, 230))
        draw.DrawText("Плита", "DermaLarge", 0, -176, Color(255, 255, 255), TEXT_ALIGN_CENTER)

        if self:GetIgnite() == false then
            local panbutton = imgui.xButton(60, -20, 100, 100, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
            local potbutton = imgui.xButton(-165, -20, 100, 100, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
            

            if panbutton then
                local panel = vgui.Create("CMBMTK:ChoiceButton")
                panel:Status("fry", self)
            elseif imgui.IsHovering(60, -20, 100, 100) then
                surface.SetDrawColor( 80, 80, 80, 255 )
            else
                surface.SetDrawColor( 255, 255, 255, 255 )
            end

            surface.SetMaterial( Material("mutantsimgs/fryingpan.png") )
            surface.DrawTexturedRect( 60, -20, 100, 100 )

            if potbutton then
                local panel = vgui.Create("CMBMTK:ChoiceButton")
                panel:Status("boil", self)
            elseif imgui.IsHovering(-165, -20, 100, 100) then
                surface.SetDrawColor( 80, 80, 80, 255 )
            else
                surface.SetDrawColor( 255, 255, 255, 255 )
            end

            surface.SetMaterial( Material("mutantsimgs/pot.png") )
            surface.DrawTexturedRect( -165, -20, 100, 100 )
        else
            local lerpedColor = LerpColor(self:GetProgress() / 100, Color(255, 0, 0), Color(0, 255, 0))

            surface.SetDrawColor( lerpedColor )
            surface.SetMaterial( Material("mutantsimgs/gear.png") )
            surface.DrawTexturedRectRotated( 0, 0, 200, 200, CurTime() % 360 * 80)
        end


        --cursor
        local x,y = -264, -176
        local w, h = 520, 330
        xCursorcustom(x,y,w,h, imgui)

    imgui.End3D2D() end
end
