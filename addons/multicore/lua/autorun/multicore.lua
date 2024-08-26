
if CLIENT then

---------------------------------------------------
-- POPUP CONFIGURATION
---------------------------------------------------
local main_color = Color(32, 34, 37) -- Main color
local secondary_color = Color(54, 57, 62) -- Secondary color
local text_color = Color(255, 255, 255) -- Main text color

local button_color = Color(47, 49, 54) -- Button color
local button_hovered_color = Color(66, 70, 77) -- Button color (if hovered)

local header_message = "Включить Оптимизацию[Рекомендуется]" -- Header message
local header_color = Color(255, 255, 255) -- Header text color

local subtext_color = Color(0, 195, 165) -- Subtext color
local subtext_message = "Оптимизация" -- Subtext message

local width = 500 -- The width of the popup
local height = 150 -- The height of the popup

local disable_multicore_button = "Отказаться от Оптимизации"  -- Disable Multicore button text
---------------------------------------------------
-- CHAT MESSAGES 
---------------------------------------------------
local enable_multicore_message = "Оптимизация активирована"
local disable_multicore_message = "Вы отказались от Оптимизации"

---------------------------------------------------
-- FONTS
---------------------------------------------------
surface.CreateFont( "Roboto_Title", { 
	font = "Roboto", 
	extended = false,
	size = 25,
	weight = 800,
	antialias = true,
})

surface.CreateFont( "Roboto_Button", {
	font = "Roboto", 
	extended = false,
	size = 15,
	weight = 500,
	antialias = true,
})

surface.CreateFont( "Roboto_Subtext", {
	font = "Roboto",
	extended = false,
	size = 18,
	weight = 400,
	antialias = true,
})	

	
local function enableCores()
	local popup = vgui.Create("DFrame")
	popup:SetTitle("")
	popup:SetSize( width, height )
	popup:Center()
	popup:MakePopup()
	popup:ShowCloseButton(false)
	function popup.Paint(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, main_color)
		draw.RoundedBox(0, 1, 1, w - 2, h - 2, secondary_color)
	end

	local btns = vgui.Create("DPanel", popup)
	btns:SetDrawBackground(false)
	btns:Dock(BOTTOM)
	btns:DockMargin(4, 4, 4, 4)
			
	local title = vgui.Create("DLabel", popup)
	title:SetText("Раскрыть свой потенциал")
	title:SetFont("Roboto_Title")
	title:Center()
	title:SetTextColor( text_color )
	title:SetContentAlignment(8)
	title:Dock(FILL)
	title:DockMargin(0, 0, 0, 0)

	local subtext = vgui.Create("DLabel", popup)
	subtext:SetText( subtext_message )
	subtext:SetFont("Roboto_Subtext")
	subtext:Center()
	subtext:SetTextColor( subtext_color )
	subtext:SetContentAlignment(5)
	subtext:Dock(FILL)
	subtext:DockMargin(0, 0, 0, 0)
		
	local button_enable = vgui.Create("DButton", btns)
	button_enable:SetText( header_message )
	button_enable:SetFont("Roboto_Button")
	button_enable:Center()
	button_enable:SetTextColor( header_color )
	button_enable:SetWide(popup:GetWide() * 0.5 - 14)
	button_enable:Dock(LEFT)
	function button_enable.Paint(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, button_color)
		
		if (s.Hovered) then
			draw.RoundedBox(0, 0, 0, w, h, button_hovered_color)																																																			-- Copyright 76561198110511213
        end
    end
    button_enable:SetTextColor( text_color )
    button_enable.DoClick = function()
   -- RunConsoleCommand( "cl_interp", 1 )
   -- RunConsoleCommand( "cl_interp_ratio", 2 )
   -- RunConsoleCommand( "cl_updaterate", 20 )
   -- RunConsoleCommand( "cl_cmdrate", 30 )
   -- RunConsoleCommand( "cl_phys_props_enable" , 0 )
   -- RunConsoleCommand( "cl_phys_props_max" , 0 )
   -- RunConsoleCommand( "props_break_max_pieces" , 0 )
   -- RunConsoleCommand( "r_propsmaxdist" , 1 )
 
   -- RunConsoleCommand("cl_threaded_bone_setup", 1)
    --RunConsoleCommand("cl_threaded_client_leaf_system", 1)
    --RunConsoleCommand("r_threaded_client_shadow_manager", 1)
    --RunConsoleCommand("r_threaded_particles", 1)
    --RunConsoleCommand("r_threaded_renderables", 1)
    --RunConsoleCommand("r_queued_ropes", 1)
    --RunConsoleCommand("studio_queue_mode", 1)
    RunConsoleCommand("gmod_mcore_test", 1)
    --RunConsoleCommand("mat_queue_mode", 2)
	
	--RunConsoleCommand("mat_fastspecular", 1)
	--RunConsoleCommand("mat_fastnobump", 1)
 
    --RunConsoleCommand("r_3dsky", 1)
    --RunConsoleCommand("r_WaterDrawReflection", 0)
    --RunConsoleCommand("r_waterforcereflectentities", 0)
    --RunConsoleCommand("r_teeth", 0)
    --RunConsoleCommand("r_ropetranslucent", 0)
    --RunConsoleCommand("r_maxmodeldecal", 0) --50
    --RunConsoleCommand("r_maxdlights", 0) --32
    RunConsoleCommand("r_decals", 0) --2048
    --RunConsoleCommand("r_drawmodeldecals", 0)
   --RunConsoleCommand("r_drawdetailprops", 1)
    --RunConsoleCommand("r_worldlights", 0)
    --RunConsoleCommand("cl_forcepreload", 1)
    --RunConsoleCommand("snd_mix_async", 1)
    --RunConsoleCommand("cl_ejectbrass", 0)
    --RunConsoleCommand("cl_detaildist", 1)
    --RunConsoleCommand("cl_show_splashes", 0)
    --RunConsoleCommand("r_drawflecks", 0)
    --RunConsoleCommand("r_dynamic", 0)
    --RunConsoleCommand("r_WaterDrawRefraction", 0)
 
    --RunConsoleCommand("r_fastzreject", -1)
    --RunConsoleCommand("Cl_ejectbrass", 0)
    --RunConsoleCommand("Muzzleflash_light", 0)
    --RunConsoleCommand("cl_wpn_sway_interp", 0)
    --RunConsoleCommand("in_usekeyboardsampletime", 0)
 
--[[
hook.Add('InitPostEntity', "SomeFix", function()
    LocalPlayer():ConCommand('cl_updaterate 20; cl_cmdrate 30; cl_interp 0.1; cl_interp_ratio 2;')
end)

hook.Add("NetworkEntityCreated", "fpsup", function(ent)
    timer.Simple( 1, function() if not IsValid(ent) then return end
       
   
    ent.RenderOverride = function()
            if (LocalPlayer():GetViewEntity():GetPos():Distance(ent:GetPos()) < 2000) then --6000 --3000
                ent:DrawModel()
            end
        end
    end)
end)
]]
 
        popup:Remove()
        surface.PlaySound( "garrysmod/ui_click.wav" )
        LocalPlayer():ChatPrint( enable_multicore_message )
    end
 
    local button_disable = vgui.Create("DButton", btns)
    button_disable:SetText( disable_multicore_button )
    button_disable:SetFont("Roboto_Button")
    button_disable:Center()
    button_disable:SetWide(popup:GetWide() * 0.5 - 14)
    button_disable:Dock(RIGHT)
    function button_disable.Paint(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(47, 49, 54))
       
        if (s.Hovered) then
            draw.RoundedBox(0, 0, 0, w, h, Color(66, 70, 77))
        end
    end
    button_disable:SetTextColor( text_color )
    button_disable.DoClick = function()
        popup:Remove()
        surface.PlaySound( "garrysmod/ui_click.wav" )
        LocalPlayer():ChatPrint( disable_multicore_message )
    end
   
end    
--[[             
hook.Add("InitPostEntity","MultiRenderingPopup",function()
    timer.Simple(5,function()
        enableCores()
    end)
end)
]]
concommand.Add("multicore_enable", enableCores)
end