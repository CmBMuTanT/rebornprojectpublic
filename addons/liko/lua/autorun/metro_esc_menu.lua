if CLIENT then

	local metro_esc_buttons = {

		[1] = { 
			text = "Продолжить путь", 
			func = function(ply)  
				CloseEsc()	
			end 
		},
		[2] = { 
			text = "Опции", 
			func = function(ply)  
				gui.ActivateGameUI()
				RunConsoleCommand( "gamemenucommand", "OpenOptionsDialog" )	
			end 
		},
		[3] = { 
			text = "Звук", 
			func = function(ply)  
				RunConsoleCommand( "menuha2" )	
			end 
		},
		[4] = { 
			text = "Отсоедениться", 
			func = function(ply)  
				RunConsoleCommand( "gamemenucommand", "Disconnect" )	
			end 
		},
		[5] = { 
			text = "Выйти из игры", 
			func = function(ply)  
				RunConsoleCommand( "gamemenucommand", "Quit" )	
			end 
		}

	}

surface.CreateFont( "MetroEscFont1", {
    font = "Impact",
    extended = true,
    size = 25,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )

surface.CreateFont( "MetroEscFont2", {
    font = "Impact",
    extended = true,
    size = 27,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )

local escmenu = nil

local nextescpress = 0
local MetroEscOpen = false
local metroesclerp = 0
local MetroEscState = 0

local function OpenMenuha2()

		local menuha = vgui.Create( "DFrame", escmenu )
		menuha:SetTitle( "Громкость" )
		menuha:SetSize( 400, 250 )
		menuha:ShowCloseButton( true )
		menuha:SetDraggable( true )
		menuha:SetBackgroundBlur(true)
		menuha:SetDeleteOnClose( true )

		menuha:SetPos(ScrW()/2 - 50, ScrH()/2 - 125)
		menuha:MakePopup()

		local DermaNumSlider = vgui.Create( "DNumSlider", menuha )
		DermaNumSlider:SetPos( 50, 50 )			
		DermaNumSlider:SetSize( 300, 100 )		
		DermaNumSlider:SetText( "Громкость" )	
		DermaNumSlider:SetMin( 0 )		
		DermaNumSlider:SetMax( 100 )		
		DermaNumSlider:SetDecimals( 0 )			
		DermaNumSlider:SetConVar( "metro_ambient_vol" )

	menuha.Paint = function()
		
		draw.RoundedBox( 0, 0, 0, menuha:GetWide(), menuha:GetTall(), Color( 0, 0, 0, 200 ) )
		
		if MetroEscOpen == true then
			metroesclerp = Lerp(FrameTime()*10, metroesclerp, 1)
		end
		
		--surface.SetDrawColor( Color(255,255,255,255) )
		--surface.SetTexture( surface.GetTextureID("metroui/ui_pausemenu_back_001") )	
		--surface.DrawTexturedRectRotated( (ScrH()/2)*metroesclerp, ScrH()/2, ScrH(), ScrH(), 0 )	
		
		--draw.SimpleText( "(Esc)", "MetroEscFont1", (ScrH()/2*metroesclerp)-50, ScrH()/1.3, Color( 155, 71, 54, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		--draw.SimpleText( "BACK", "MetroEscFont2", ScrH()/2*metroesclerp, ScrH()/1.3, Color( 80, 71, 54, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
			if input.IsKeyDown( KEY_ESCAPE ) and nextescpress < CurTime() then
				CloseEsc()
			end	
	end

end

concommand.Add("menuha2", OpenMenuha2)

local function OpenEscMenu()
		
		escmenu = vgui.Create( "DFrame" )
		escmenu:SetTitle( "" )
		escmenu:SetSize( ScrW(), ScrH() )
		escmenu:ShowCloseButton( false )
		escmenu:SetDraggable( false )
		escmenu:SetBackgroundBlur(true)
		escmenu:SetDeleteOnClose( true )

		escmenu:Center()
		escmenu:MakePopup()


		local Players = player.GetAll()
		
        local DermaLabel = vgui.Create("DLabel", escmenu)
        DermaLabel:SetPos(ScrW() * 0.25, ScrH() * 0.18)
        DermaLabel:SetColor(Color(0,0,0,255))
		DermaLabel:SetFont("ixMenuMiniFont")
        DermaLabel:SetText(table.Count( player.GetAll() ).." / "..game.MaxPlayers().." ИГ.")

		
		
	function CloseEsc()
				MetroEscOpen = false		
				gui.HideGameUI()		
				metroesclerp = 0			
				nextescpress = CurTime() + 0.2	
				escmenu:Close()	
	end

	--ui/metroesc_back"
	escmenu.Paint = function()
	
		/*surface.SetDrawColor( Color(255,255,255,255*metroesclerp) )
		surface.SetTexture( surface.GetTextureID("ui/metroesc_back") )	
		surface.DrawTexturedRectRotated( ScrW()-ScrH()/2, ScrH()/2, ScrH(), ScrH(), 0 )	*/
		
		Derma_DrawBackgroundBlur( escmenu, escmenu.m_fCreateTime )
		
		if MetroEscOpen == true then
			metroesclerp = Lerp(FrameTime()*10, metroesclerp, 1)
		end
		
		surface.SetDrawColor( Color(255,255,255,255) )
		surface.SetTexture( surface.GetTextureID("metroui/ui_pausemenu_back_001") )	
		surface.DrawTexturedRectRotated( (ScrH()/2)*metroesclerp, ScrH()/2, ScrH(), ScrH(), 0 )	
		
		draw.SimpleText( "(Esc)", "MetroEscFont1", (ScrH()/2*metroesclerp)-50, ScrH()/1.3, Color( 155, 71, 54, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "BACK", "MetroEscFont2", ScrH()/2*metroesclerp, ScrH()/1.3, Color( 80, 71, 54, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
			if MetroEscState == 2 and input.IsKeyDown( KEY_ESCAPE ) and nextescpress < CurTime() and metroesclerp > 0.9 then
				CloseEsc()
				MetroEscState = 0
			end	
	end
	
		for k, v in pairs(metro_esc_buttons) do
				local button = vgui.Create( "DButton", escmenu )
				button:SetText( "" )
				button:SetSize( ScrH()/2, 64 )
				button:SetPos( 0, 0 )
				button.CurBool = false

				button.Paint = function()
					if button.CurBool == true then
						draw.RoundedBox( 0, 0, 0, ScrH()/2, 64, Color(70, 50, 41, 205) )
						draw.SimpleText( v.text, "MetroEscFont2", ScrH()/18-32, 32, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
						draw.SimpleText( k, "MetroEscFont2", ScrH()/2-16, 32, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
						
						draw.RoundedBox( 0, 8, 50, ScrH()/2-16, 2, Color( 255, 255, 255, 255 ) )	
					else
						draw.SimpleText( v.text, "MetroEscFont2", ScrH()/18-32, 32, Color( 80, 71, 54, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
						draw.SimpleText( k, "MetroEscFont2", ScrH()/2-16, 32, Color( 80, 71, 54, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
						
						draw.RoundedBox( 0, 8, 50, ScrH()/2-16, 2, Color( 80, 71, 54, 255 ) )						
					end
					
					button:SetPos( (ScrH()/2)*metroesclerp - ScrH()/3.5, ScrH()/4+(k*70) - 70 )
				end
				
				button.DoClick = function()
					if v.func != nil then
						v.func(LocalPlayer())
					end
				end
				
				button.OnCursorEntered = function() button.CurBool = true end
				button.OnCursorExited = function() button.CurBool = false end
		end	
		
end

	hook.Add('PreRender', 'MetroEscapeMenu', function()
	
		if input.IsKeyDown(KEY_ESCAPE) then
			gui.HideGameUI()
			if MetroEscOpen == false and nextescpress < CurTime() and ( LocalPlayer():GetNWInt("ambactiontimer") < CurTime() and LocalPlayer():GetNWInt("ambtensiontimer") < CurTime() ) then
					nextescpress = CurTime() + 0.1			
					
					if !LocalPlayer().inventory then
						OpenEscMenu()
						MetroEscOpen = true
						MetroEscState = 1
					end	
					
					return true		
			end
		end
		
		if !input.IsKeyDown(KEY_ESCAPE) and MetroEscOpen and MetroEscState == 1 then
			MetroEscState = 2
		end
		
	end)
	
end
