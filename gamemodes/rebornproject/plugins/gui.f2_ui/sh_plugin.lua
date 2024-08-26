PLUGIN.name = "Radial Menu"

if (CLIENT) then
    local gradientDown = surface.GetTextureID("vgui/gradient-d")
	local gradientUp = surface.GetTextureID("vgui/gradient-u")
    
    BIND_CMD = 0 -- when selected, pressing the bind key will activate this one.
    BIND_BIND = 1 -- when selected, pressing the bind key will use it with + and -
    BIND_TOGGLE = 2 -- when selected, pressing the bind key will toggle + and -
    BIND_INSTANT = 3 -- when selected, this command will trigger instantly. It will then act like CMD.
    BIND_FALLINGCMD = 4 -- command triggers on falling edge
    BIND_BURST = 5 -- command triggers for X seconds
    BIND_DUALEDGE = 6 -- command triggers on rising and falling edge

    local PLUGIN = PLUGIN
    PLUGIN.menuBinds = PLUGIN.menuBinds or {}

    function PLUGIN:CreateRadialMenu()
        PLUGIN.isOpen = true
        return PLUGIN.menuBinds
    end

    function PLUGIN:ClearOptions()
        PLUGIN.menuBinds = {}
    end

    function PLUGIN:AddOption(options)
        table.insert(PLUGIN.menuBinds, options)
    end

    function PLUGIN:GetOption(option)
        for k, v in pairs(PLUGIN.menuBinds) do
            if v.name and v.name == option then return v.name end
        end
    end

    local mat_ring = Material("sgm/playercircle")
    
    PLUGIN.selectedOption = 0
    
    PLUGIN.menuOpen = false
    PLUGIN.menuFade = 0
    
    PLUGIN.mouseAng = 0
    PLUGIN.mouseRad = 0
    
    local function RadiusSpoke(x, y, angle, rad)
        x = x + (math.cos(angle) * rad)
        y = y + (math.sin(angle) * rad)
    
        return x, y
    end
    
    local segmenttime = 0.25
    local fadetime = 0.4
    
    hook.Add("HUDPaint", "ixRadialMenu", function()
        local activemenu = PLUGIN.menuBinds
        if !activemenu then return end
    
        if PLUGIN.isOpen then
            PLUGIN.menuFade = math.Approach(PLUGIN.menuFade, 2, FrameTime() / fadetime)
        else
            PLUGIN.menuFade = math.Approach(PLUGIN.menuFade, 0, FrameTime() / fadetime)
        end
    
        local a = PLUGIN.menuFade * 255
        if a <= 0 then return end
        local ss = ScreenScale(1)
    
    
        local segments = table.Count(activemenu)

        local x = ScrW() / 2
        local y = ScrH() / 2
		
		local faction = ix.faction.indices[LocalPlayer():Team()]

        surface.SetDrawColor(0,0,0, a * 0.3)
        surface.DrawRect(0, 0, ScrW(), ScrH())

		surface.SetDrawColor(28, 26, 26, a * 0.5)
		surface.SetTexture(gradientDown)
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

		surface.SetDrawColor(28, 26, 26, a * 0.5)
		surface.SetTexture(gradientUp)
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        local rad = ss * 100
        if segments > 0 then
            -- draw each segment
            local arc = 360 / segments
    
            for i = 1, segments do
                local angle = (i * arc) - 90
    
                local d = (PLUGIN.mouseAng - angle + 180 + 360) % 360 - 180
                d = math.abs(d)
    
                local selected = d <= arc / 2
    
                if PLUGIN.mouseRad == 0 then
                    selected = false
                end
    
                if !activemenu[i] then continue end
    
                activemenu[i].segment = activemenu[i].segment or 0
    
                local size = rad * (1 + (activemenu[i].segment * 0.1))
                local inf_x, inf_y = RadiusSpoke(x, y, math.rad(angle), size)
    
                if selected then
                    PLUGIN.selectedOption = i
                    activemenu[i].segment = math.Approach(activemenu[i].segment, 1, FrameTime() / segmenttime)
                else
                    activemenu[i].segment = math.Approach(activemenu[i].segment, 0, FrameTime() / segmenttime)
                end

                ----------
                -- TEXT --
                ----------
    
                local pick_x, pick_y = RadiusSpoke(x, y, math.rad(PLUGIN.mouseAng), PLUGIN.mouseRad)
                local pick_s = ss * 10
                surface.SetDrawColor(255, 255, 255, a * 0.1)
                surface.DrawLine(x, y, pick_x, pick_y)

                surface.SetMaterial(mat_ring)
                surface.SetDrawColor(255, 255, 255, a)
                surface.DrawTexturedRect(pick_x - (pick_s / 2), pick_y - (pick_s / 2), pick_s, pick_s)

                surface.SetFont("ixMenuButtonFont")
                local inf_w, inf_h = 64, 64
                local tb_w = inf_w + (ss * 14)

                draw.SimpleText(activemenu[i].name, "ixMenuButtonFontSmall", inf_x, inf_y - 40, Color( 255, 255, 255, PLUGIN.selectedOption ~= i and a * 0.3 or a * 1 ), TEXT_ALIGN_CENTER)

                surface.SetDrawColor( 255, 255, 255, a * (selected and 0.8 or 0.3) )
                surface.SetMaterial(Material(string.find(activemenu[i].icon, "icon16") and activemenu[i].icon or "icon16/" .. activemenu[i].icon .. ".png"))
                surface.DrawTexturedRect(inf_x - (inf_w / 2), inf_y, 64, 64)
            end
        end
    end)

    function PLUGIN:PlayerButtonDown(client, button)
        if not IsFirstTimePredicted() then return end
        if not PLUGIN.isOpen then return end
        local activemenu = PLUGIN.menuBinds
        local selection = activemenu[PLUGIN.selectedOption]
        if not selection then return end

        if (button == MOUSE_LEFT) then
            if selection.callback then
                selection.callback()

                if not selection.newmenu then
                    PLUGIN.isOpen = false
                end
            end
        elseif (button == KEY_E || button == MOUSE_RIGHT) then
            PLUGIN.isOpen = false
        end
    end

    function PLUGIN:PlayerBindPress(client, bind, bPressed)
        if PLUGIN.isOpen and bPressed then return true end
    end

    function PLUGIN:ShouldPopulateEntityInfo(entity)
        if PLUGIN.isOpen then return false end
    end
    
    hook.Add("InputMouseApply", "PLUGIN.menuBinds_Mouse", function(cmd, x, y, ang)
        if !PLUGIN.isOpen then return end
    
        if math.abs(x) + math.abs(y) <= 0 then return end
    
        cmd:SetMouseX( 0 )
        cmd:SetMouseY( 0 )
    
        local mousex = math.cos(math.rad(PLUGIN.mouseAng)) * PLUGIN.mouseRad
        local mousey = math.sin(math.rad(PLUGIN.mouseAng)) * PLUGIN.mouseRad
    
        mousex = mousex + x
        mousey = mousey + y
    
        local newang = math.deg(math.atan2(mousey, mousex))
        local newrad = math.sqrt(math.pow(mousex, 2) + math.pow(mousey, 2))
    
        newrad = math.min(newrad, ScreenScale(100))
    
        PLUGIN.mouseRad = newrad
        PLUGIN.mouseAng = newang
    
        return true
    end)
end