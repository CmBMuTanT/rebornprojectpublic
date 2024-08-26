-- VGUI includes
local GTS 	= GTS
print("lol")
local files = { "vgui/dbutton_gts.lua", "vgui/dimagebutton_gts.lua", "vgui/dslider.lua", "vgui/dnumslider_gts.lua", "vgui/dscrollpanel_gts.lua" }
for i = 1, #files do 
	include( files[i] )
end

-- GTS Arial Fonts ( normal / bold )
local sizes = { 13, 15, 20, 25, 30, 35, 40, 50, 60, 80 }
for _, size in pairs ( sizes ) do
	local fontName = "Arial_GTS_" .. size
	surface.CreateFont( fontName, { font = "Arial",	size = size, weight = 500 } )
	surface.CreateFont( fontName .. "_Bold", { font = "Arial", size = size,	weight = 5000 } )
end

-- Materials
local warning = Material( "gts/warning.png" )
local thumbs = Material( "gts/thumbs.png" )
local frenchFlag = Material( "gts/french.png" )
local englishFlag = Material( "gts/english.png" )
local checkMat = Material( "gts/check.png" )
 
-- Functions
local function Circle( x, y, radius, seg )
	local cir = {}
	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end
	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	surface.DrawPoly( cir )
end
local function RotatedTexture( x, y, w, h, rot, x0, y0 )
	local c = math.cos( math.rad( rot ) )
	local s = math.sin( math.rad( rot ) )
	local newx = y0 * s - x0 * c
	local newy = y0 * c + x0 * s
	surface.DrawTexturedRectRotated( x + newx, y + newy, w, h, rot )
end

-- Convar
if ( not ConVarExists( "gts_language" ) ) then
	CreateClientConVar( "gts_language", "english", true )
end 

GTS.Interface = GTS.Interface or {}

GTS.Interface.Theme = {}
GTS.Interface.Theme.Dark = { background = Color( 35, 35, 30 ) }
GTS.Interface.SelectedTheme = "Dark"

GTS.Interface.Languages = {}

GTS.Interface.Languages.english = {
	["request_screen"] = "Request screenshot",
	["select_player"] = "Select a player",
	["show_profile"] = "Show Steam profile",
	["no_player"] = "No player selected",
	["quality_screen"] = "Quality of the screen :",
	["recommended_quality"] = "Recommended quality : 75",
	["quality_note"] = "Note: Higher quality means higher delay",
	["select_language"] = "Select a language",
	["cancel"] = "Cancel",
	["close"] = "Close",
	["advanced_mode"] = "Use Advanced Mode",
	["advanced_mode_info"] = "Advanced mode is more reliable."
}

GTS.Interface.Languages.french = {
	["request_screen"] = "Récupérer l'image",
	["select_player"] = "Sélectionnez un joueur",
	["show_profile"] = "Profil Steam",
	["no_player"] = "Aucun joueur sélectionné",
	["quality_screen"] = "Qualité de l'image :",
	["recommended_quality"] = "Qualité recommandé : 75",
	["quality_note"] = "Note: Une qualité haute signifie un long temps d'attente",
	["select_language"] = "Sélectionnez un language",
	["cancel"] = "Annuler",
	["close"] = "Fermer",
	["advanced_mode"] = "Mode avancé",
	["advanced_mode_info"] = "Le mode avancé est plus fiable."
}

GTS.Interface.SelectedLanguage = GetConVar( "gts_language" ):GetString()

function GTS.Interface.GetText( key )
	local selectedLang = GetConVar( "gts_language" ):GetString()
	if ( GTS.Interface.Languages[selectedLang] ) then
		return GTS.Interface.Languages[selectedLang][key] or "Missing text"
	else
		return "Missing language"
	end
end

function GTS.Interface.ShowScreen( str )
	if ( IsValid( GTS.Interface.LoadingPnl ) ) then
		local w, h = GTS.Interface.LoadingPnl:GetWide(), GTS.Interface.LoadingPnl:GetTall() - 60
		local t = vgui.Create( "HTML", GTS.Interface.LoadingPnl )
		t:SetPos( 0, 20 )
		t:SetSize( w, h )
		t:SetHTML( [[ <img width="]] .. w-20 .. [[" height="]] .. h-45 .. [[" src="data:image/jpeg;base64, ]] .. str .. [["/> ]] )
		
		GTS.Interface.LoadingPnl.Paint = function() 
			surface.SetDrawColor( 0, 0, 0 )
			surface.DrawRect( 0, 0, w, h )
		end
	end
end

function GTS.Interface.OpenLoading()
	-- Remove older pnl
	if ( GTS.Interface.LoadingPnl ) then 
		GTS.Interface.LoadingPnl:Remove()
	end
	GTS.Interface.LoadingPnl = vgui.Create( "DFrame" )
	
	local loadingPnl = GTS.Interface.LoadingPnl
	
	loadingPnl:SetSize( ScrW() - 100, ScrH() - 100 )
	loadingPnl:Center()
	loadingPnl:SetTitle( "" )
	loadingPnl:SetAlpha( 0 )
	loadingPnl:AlphaTo( 255, 0.5 )
	loadingPnl:ShowCloseButton( true )
	loadingPnl:MakePopup()
	loadingPnl.selectedPlayer = nil
	loadingPnl.rotVal = 0
	
	local circleAmount = 50
	local totalDiff = 160
	local circleSize = 20
	local diffV = totalDiff/circleAmount 
	
	GTS.Interface.LoadingPnl.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0 )
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( 120, 120, 120, 255 )
		draw.NoTexture()
		for i = 1, 360 do
			local xPos, yPos = (w/2)+math.cos( math.rad( i ) )*150, (h/2)+math.sin( math.rad( i ) )*150 
			Circle( xPos, yPos, 2, 15 )	 
		end
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		local speed = math.cos( CurTime()*1 )
		if ( speed < 0 ) then
			speed = math.cos( CurTime() ) *0.8
		end
		for i = 1, circleAmount do
			local mSpeed = speed
			if ( speed < 0 ) then
				mSpeed = math.cos( CurTime() ) *0.1
			end 
			local xPos, yPos = (w/2)+math.cos( math.rad( self.rotVal - ( i * (diffV * mSpeed) ) ) )*150, (h/2)+math.sin( math.rad( self.rotVal - ( i * (diffV * mSpeed) ) ) )*150
			-- local circleSize = circleSize * 
			Circle( xPos, yPos, circleSize - ( i/circleAmount ) * circleSize + 2, 20 )	 
		end
		
		self.rotVal = self.rotVal + ( 260 + speed * 250 ) * RealFrameTime()
		draw.SimpleText( "Loading ...", "Arial_GTS_40_Bold", w/2, h/2, color_white, 1, 1 )
	end
end 

function GTS.Interface.OpenPlayerSelection()
	if ( IsValid( GTS.Interface.PSPnl ) ) then GTS.Interface.PSPnl:Remove() end
	if not GTS["GTS:ObjectFactoryProvider"]:checkPermissions ("ulx gts",LocalPlayer ()) then
		return
	end
	
	GTS.Interface.PSPnl = vgui.Create( "DFrame" )
	local frame = GTS.Interface.PSPnl
	frame:SetSize( 900, 650 )
	frame:Center()
	frame:SetTitle( "" )
	frame:SetAlpha( 0 )
	frame:AlphaTo( 255, 0.3 )
	frame:ShowCloseButton( false )
	frame:MakePopup()
	frame.selectedPlayer = nil
	frame.OnRemove = function( self )
		net.Start( "GimmeThatScreen_RequestPVS" )
		net.SendToServer()
	end
	frame.Paint = function( self, w, h )
		local col = GTS.Interface.Theme[GTS.Interface.SelectedTheme]

		surface.SetDrawColor( col.background )
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( 50, 55, 180 )
		surface.DrawRect( 0, 0, w, 60 )
		
		draw.SimpleText( "GimmeThatScreen Menu", "Arial_GTS_35_Bold", w/2, 32.5, color_white, 1, 1 )
		surface.SetDrawColor( Color( 80, 80, 100 ) )
		for i = 0, 4 do
			surface.DrawOutlinedRect( i, i, w - ( i * 2 ), h - ( i * 2 ) )
		end
		
		if ( frame.selectedPlayer and IsValid( frame.selectedPlayer ) ) then
			local shootPos = frame.selectedPlayer:GetShootPos()
			local x, y = self:GetPos()
			local ang = frame.selectedPlayer:EyeAngles()

			local tr = util.TraceLine( {
				start = shootPos,
				endpos = shootPos + ang:Forward() * -30,
				filter = function( ent ) if ( ent == frame.selectedPlayer ) then return false end end
			} )
			render.RenderView( { origin = tr.HitPos, angles = ang, x = x + 420, y = y + 180 , w = 440, h = 256, drawviewmodel = false } )
		else
			surface.SetDrawColor( 0, 0, 0 )
			surface.DrawRect( 420, 180, 440, 256 )

			surface.SetDrawColor( 210, 210, 210 )
			for i = 1, 120 do
				surface.DrawRect( 420 + math.random( 0, 440 ), 180 + math.random( 0, 256 ), 1, 1 )
			end
			draw.SimpleText( GTS.Interface.GetText( "no_player" ), "Arial_GTS_25_Bold", 640, 308, color_white, 1, 1 )
		end
	end
 
	frame.settingsBtn	= vgui.Create( "DImageButton_GTS", frame )
	frame.informationBtn= vgui.Create( "DImageButton_GTS", frame )
	frame.closeBtn 		= vgui.Create( "DImageButton_GTS", frame )
 
	frame.scrollPnl 	= vgui.Create( "DScrollPanel_GTS", frame )
	frame.avatarImg 	= vgui.Create( "AvatarImage", frame )
	frame.nickLbl 		= vgui.Create( "DLabel", frame )
	frame.sidLbl 		= vgui.Create( "DLabel", frame )
	frame.profilBtn 	= vgui.Create( "DButton_GTS", frame )
	frame.qualitySld 	= vgui.Create( "DSlider_GTS", frame )
	frame.requestBtn 	= vgui.Create( "DButton_GTS", frame )
	frame.methodCheck 	= vgui.Create( "DCheckBox", frame )

	local btns = { frame.settingsBtn, frame.informationBtn, frame.closeBtn }
	local xPos = 740
	for k, pnl in ipairs ( btns ) do
		pnl:SetPos( xPos, 7 )
		pnl:SetSize( 50, 50 )
		pnl:SetCircle( true )
		pnl.primaryColor = Color( 255, 0, 0, 0 )
		pnl.zoomMax = 5
		xPos = xPos + 50
	end

	frame.settingsBtn:SetMaterial( "gts/settings.png" )
	frame.settingsBtn.DoClick = function( self )
		GTS.Interface.OpenSettings()
	end
	
	frame.informationBtn:SetMaterial( "gts/information.png" )
	frame.informationBtn.DoClick = function( self )
		GTS.Interface.OpenInformation()
	end
	
	frame.closeBtn:SetMaterial( "gts/close.png" )
	frame.closeBtn.DoClick = function( self )
		frame.selectedPlayer = nil
		frame:AlphaTo( 0, 0.5, 0, function()
			if ( IsValid( frame ) ) then
				frame:Remove()
			end
		end )
	end
	
	frame.scrollPnl:SetPos( 10, 65 )
	frame.scrollPnl:SetSize( 375, 575 )
	frame.scrollPnl:SetGripSize( 10 )
	frame.scrollPnl.plySID = {}
	frame.scrollPnl.AddPlayer = function( self, ply )
		local btn = vgui.Create( "DButton_GTS" )
		btn:SetParent( self )
		btn:SetPos( 0, 0 )
		btn:SetSize( 365, 64 )
		btn:SetFont( "Arial_GTS_40_Bold" )
		btn:SetText( ply:Nick() )
		btn:SetIcon( ply )
		btn:SetParentScissor( self )
		btn.iconZoomRatio = 2.8	
		btn.DoClick = function( self )
			frame.avatarImg:SetPlayer( ply, 128 )
			frame.selectedPlayer = ply
			frame.requestBtn:SetEnabled( true )
		end
		self.plySID[ply:SteamID()] = btn
		self:RecalcBtn()
	end
	frame.scrollPnl.RecalcBtn = function( self )
		local yPos = 0
		for k, btn in pairs ( self.plySID ) do
			btn:SetPos( 0, yPos )
			yPos = yPos + 64 + 5
		end
	end

	local yPos = 5
	for k, ply in pairs ( player.GetAll() ) do
		if ( not ply:IsBot() ) then
			local font = "Arial_GTS_40_Bold"
			surface.SetFont( font )
			local width = surface.GetTextSize(ply:Nick())
			if ( width > 200 ) then
				font = "Arial_GTS_30_Bold"
			end
			
			local btn = vgui.Create( "DButton_GTS" )
			btn:SetParent( frame.scrollPnl )
			btn:SetPos( 5, yPos + 0 )
			btn:SetSize( 365, 64 )
			btn:SetFont( font )
			btn:SetText( ply:Nick() )
			btn:SetIcon( ply )
			btn:SetParentScissor( frame.scrollPnl )
			btn.iconZoomRatio = 2.8	
			btn.DoClick = function( self )
				if ( IsValid( ply ) ) then
					frame.avatarImg:SetPlayer( ply, 128 )
					frame.selectedPlayer = ply
					frame.requestBtn:SetEnabled( true )
					frame.profilBtn:SetEnabled( true )
					frame.nickLbl:SetText( ply:Nick() )
					frame.sidLbl:SetText( ply:SteamID() )
					net.Start( "GimmeThatScreen_RequestPVS" )
						net.WriteEntity( ply )
					net.SendToServer()
				end
			end
			frame.scrollPnl.plySID[ply:SteamID()] = btn
			yPos = yPos + 64 + 5
		end
	end

	frame.avatarImg:SetPos( 420, 80 )
	frame.avatarImg:SetSize( 80, 80 )

	frame.nickLbl:SetPos( 510, 80 )
	frame.nickLbl:SetSize( 350, 30 )
	frame.nickLbl:SetContentAlignment( 7 )
	frame.nickLbl:SetFont( "Arial_GTS_30" )
	frame.nickLbl:SetText( GTS.Interface.GetText( "select_player" ) )
	frame.nickLbl:SetTextColor( color_white )

	frame.sidLbl:SetPos( 510, 110 )
	frame.sidLbl:SetSize( 350, 20 )
	frame.sidLbl:SetContentAlignment( 7 )
	frame.sidLbl:SetFont( "Arial_GTS_20_Bold" )
	frame.sidLbl:SetText( "STEAM_0:0:00000000" )
	frame.sidLbl:SetTextColor( color_white )

	frame.profilBtn:SetPos( 510, 135 )
	frame.profilBtn:SetSize( 120, 25 )
	frame.profilBtn:SetFont( "Arial_GTS_15" )
	frame.profilBtn:SetText( "Show steam profil" )
	frame.profilBtn:SetEnabled( false )
	frame.profilBtn.zoomEnabled = false
	frame.profilBtn.DoClick = function()
		if ( IsValid( frame.selectedPlayer ) ) then
			frame.selectedPlayer:ShowProfile()
		end
	end
	
	local xPos, yPos = 420, 460
	frame.qualitySld:SetPos( xPos, yPos )
	frame.qualitySld:SetSize( 400, 60 )
	frame.qualitySld:SetMax( 100 )
	frame.qualitySld:SetMin( 10 )
	frame.qualitySld.lastState = 1
	frame.qualitySld.warningRotation = 50
	frame.qualitySld.OnValueChanged = function( self, value )
		local value = math.Round( value )
		if ( value > 90 ) then
			if ( self.lastState ~= 3 ) then	
				self.warningRotation = 55
				self.lastState = 3 
			end
		elseif ( value > 75 ) then
			if ( self.lastState ~= 2 ) then
				self.warningRotation = 40
				self.lastState = 2
			end
		else
			if ( self.lastState ~= 1 ) then
				self.warningRotation = 25
				self.lastState = 1
			end
		end
	end
	frame.qualitySld.Think = function( self, w, h )
		if ( self.warningRotation > 0 ) then
			self.warningRotation = math.max( self.warningRotation - ( 60 *RealFrameTime() ), 0 )
		end
	end
	frame.qualitySld.PaintOver = function( self, w, h )
		local val = self:GetValue()
		DisableClipping(true)
		if ( val > 75 ) then
			if ( val > 90 ) then
				surface.SetDrawColor( 255, 45, 45, 255 )
			else
				surface.SetDrawColor( 255, 255, 0, 255 )
			end
			surface.SetMaterial( warning )
		else
			surface.SetDrawColor(45, 255, 45, 255 )
			surface.SetMaterial( thumbs )
		end
		local size = 30
		surface.DrawTexturedRectRotated( w+30, h/2 - 2, size, size, math.sin( CurTime() * 16 ) * self.warningRotation )
		draw.SimpleText( GTS.Interface.GetText( "quality_screen" ), "Arial_GTS_20_Bold", -5, -5, color_white, 0, 0 )
		draw.SimpleText( "( " .. GTS.Interface.GetText( "recommended_quality" ) .. " )", "Arial_GTS_15", 0, 75, color_white, 0, 0 )
		draw.SimpleText( GTS.Interface.GetText( "quality_note" ), "Arial_GTS_15", 0, 95, Color( 230, 110, 110 ), 0, 0 )
		DisableClipping(false)
	end

	frame.requestBtn:SetPos( xPos, yPos + 120 )
	frame.requestBtn:SetSize( 256, 50 )
	frame.requestBtn:SetFont( "Arial_GTS_30" )
	frame.requestBtn:SetText( GTS.Interface.GetText( "request_screen" ) )
	frame.requestBtn:SetEnabled( false )
	frame.requestBtn.DoClick = function( self )
		local mode = "Local"
		if ( not frame.methodCheck:GetChecked() ) then
			mode = "Global"
		end
		if ( frame.selectedPlayer ) then
			--timer.Simple(3,function()
			net.Start("GimmeThatScreen_Provide")
			net.WriteBool(true)
			net.WriteString(frame.qualitySld:GetValue()) -- on verra après quoi mettre
			net.WriteEntity(frame.selectedPlayer) -- le joueur du tab
			net.WriteString( mode )
			net.SendToServer()
			GTS.Interface.OpenLoading()
		--	end)
		end
	end
	
	frame.methodCheck:SetPos( xPos + 270,  yPos + 145 )
	frame.methodCheck:SetValue( true )
	frame.methodCheck:SetSize( 20, 20 )
	frame.methodCheck.zoomValue = 5
	frame.methodCheck.OnChange = function( self, val )
		if ( val ) then self.zoomValue = 7 end
	end
	frame.methodCheck.Think = function( self )
		if ( self.zoomValue > 3 ) then
			self.zoomValue = math.max( self.zoomValue - 5 * (RealFrameTime() * 2), 3 )
		end
	end
	frame.methodCheck.DoClick = function( self )
		self:Toggle()
		if ( self:GetChecked() ) then
			surface.PlaySound( "gts/check.mp3" )
		end
	end
	frame.methodCheck.Paint = function( self, w, h )
		surface.SetDrawColor( 5, 10, 15, 255 )
		surface.DrawRect( 0, 0, w, h )
		
		DisableClipping( true )
			surface.SetDrawColor( 255, 255, 255 )
			surface.DrawOutlinedRect( -1, -1, w + 2, h + 2 )
			if ( self:GetChecked() ) then
				surface.SetDrawColor( 0, 255, 0, 255 )
				surface.SetMaterial( checkMat )
				surface.DrawTexturedRect( -self.zoomValue, -self.zoomValue, w+self.zoomValue*2, h+self.zoomValue*2 )
			end
			draw.SimpleText( GTS.Interface.GetText( "advanced_mode" ), "Arial_GTS_15_Bold", 25, 10, color_white, 0, 1 )
			draw.SimpleText( GTS.Interface.GetText( "advanced_mode_info" ), "Arial_GTS_13", 0, -20, color_white, 0, 3 )
		DisableClipping( false )
	end
	
end


function GTS.Interface.OpenInformation()
	if ( IsValid( GTS.Interface.PSPnl ) ) then
		local pW, pH = GTS.Interface.PSPnl:GetSize()
		local bg = vgui.Create( "DPanel", GTS.Interface.PSPnl )
		bg:SetPos( 0, 0 )
		bg:SetSize( pW, pH )
		bg:SetAlpha( 0 )
		bg:AlphaTo( 255, 0.3 )
		bg.Paint = function( self, w, h )
			surface.SetDrawColor( 0, 0, 0, 250 )
			surface.DrawRect( 0, 0, w, h )
			draw.SimpleText( "Credits :", "Arial_GTS_50_Bold", w/2, 20, color_white, 1, 0 )
			draw.SimpleText( "Front-end : Xenikay", "Arial_GTS_50_Bold", w/2, 350, color_white, 1, 0 )
			draw.SimpleText( "Back-end : Warlord", "Arial_GTS_50_Bold", w/2, 400, color_white, 1, 0 )
		end
		
		local WarlordImg = vgui.Create( "AvatarImage", bg )
		local XenikayImg = vgui.Create( "AvatarImage", bg )
		local closeBtn = vgui.Create( "DButton_GTS", bg )
		
		WarlordImg:SetSize( 128, 128 )
		WarlordImg:SetPos( pW/2-128-15, 200 )
		WarlordImg:SetSteamID( "76561198170145731", 128 )	

		XenikayImg:SetSize( 128, 128 )
		XenikayImg:SetPos( pW/2+30, 200 )
		XenikayImg:SetSteamID( "76561198012757646", 128 )
	
		closeBtn:SetPos( pW/2-100, pH - 60 )
		closeBtn:SetSize( 200, 40 )
		closeBtn:SetFont( "Arial_GTS_40_Bold" )
		closeBtn:SetText( GTS.Interface.GetText( "close" ) )
		closeBtn.DoClick = function( self )
			bg:AlphaTo( 0, 0.3, 0, function( _, self )
				if ( IsValid( self ) ) then
					self:Remove()
				end
			end )
		end	
	end
end

function GTS.Interface.OpenSettings()
	if ( IsValid( GTS.Interface.PSPnl ) ) then
		-- Original : https://github.com/EmmanuelOga/easing
		local function outCirc(t, b, c, d)
		  t = t / d - 1
		  return(c * math.sqrt(1 - math.pow(t, 2)) + b)
		end

		local pW, pH = GTS.Interface.PSPnl:GetSize()
		local bg = vgui.Create( "DPanel", GTS.Interface.PSPnl )
		bg:SetPos( 0, 0 )
		bg:SetSize( pW, pH )
		bg:SetAlpha( 0 )
		bg:AlphaTo( 255, 0.3 )
		bg.OnRemove = function( self, w, h )
			self.frenchMusic:Stop()
			self.englishMusic:Stop()
		end
		bg.Paint = function( self, w, h )
			surface.SetDrawColor( 0, 0, 0, 240 )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( 0, 0, 0, 100 )
			surface.DrawRect( 0, 175, w, 225 )
			draw.SimpleText( GTS.Interface.GetText( "select_language" ), "Arial_GTS_50_Bold", w/2, 180, color_white, 1, 0 )
		end
	
		bg.frenchMusic = CreateSound( LocalPlayer(), "gts/french_a.mp3" )
		bg.frenchMusic:ChangeVolume( 0 )
		bg.frenchMusicVolume = 0
		bg.englishMusic = CreateSound( LocalPlayer(), "gts/english_a.mp3" )
		bg.englishVolume = 0
	
		-- RORORO DO YOU WANT BAGUETTE DE PAIN AU CROISSANT ?
		local frenchBtn = vgui.Create( "DButton", bg )
		frenchBtn:SetPos( pW/2-260, 255 )
		frenchBtn:SetSize( 220, 120 )
		frenchBtn:NoClipping( true )
		frenchBtn.Think = function( self )
			if ( self:IsHovered() ) then
				if ( not bg.frenchMusic:IsPlaying() ) then
					bg.frenchMusic:Play()
				end
				if ( bg.frenchMusicVolume < 100 ) then
					bg.frenchMusicVolume = math.max( bg.frenchMusicVolume + ( 100*RealFrameTime() ), 1 )
				end
				bg.frenchMusic:ChangeVolume( bg.frenchMusicVolume/100 )
			else
				if ( bg.frenchMusicVolume > 0 ) then
					bg.frenchMusicVolume = math.max( bg.frenchMusicVolume - ( 100*RealFrameTime() ), 0 )
					bg.frenchMusic:ChangeVolume( math.max( 0.01, bg.frenchMusicVolume/100 ) )
				end
				-- if ( bg.frenchMusic:IsPlaying() and bg.frenchMusicVolume <= 0 ) then
					-- bg.frenchMusic:Stop()
				-- end
			end
		end
		frenchBtn.Paint = function( self, w, h )
			local zoom = outCirc( bg.frenchMusicVolume, 0, 1, 100 )
			local zX, zY, zW, zH = 0 - ( 15 * zoom ), 0 - ( 15 * zoom ), w + ( 30 * zoom ), h + ( 30 * zoom )
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( frenchFlag )
			surface.DrawTexturedRect( 0 - ( 15 * zoom ), 0 - ( 15 * zoom ), w + ( 30 * zoom ), h + ( 30 * zoom ) ) -- Yeah ik it's ugly but hey it's just for fun
			surface.SetDrawColor( 0, 0, 0, 200 - bg.frenchMusicVolume*2 )
			surface.DrawRect( zX, zY, zW, zH )
			return true
		end
		frenchBtn.DoClick = function( self )
			if ( GetConVar( "gts_language" ):GetString() ~= "french" ) then
				GetConVar( "gts_language" ):SetString( "french" )
				GTS.Interface.PSPnl.profilBtn:SetText( GTS.Interface.GetText( "show_profile" ) )
				GTS.Interface.PSPnl.requestBtn:SetText( GTS.Interface.GetText( "request_screen" ) )
				if ( not IsValid( GTS.Interface.PSPnl.selectedPlayer ) ) then
					GTS.Interface.PSPnl.nickLbl:SetText( GTS.Interface.GetText( "select_player" ) )
				end
			end
			bg:AlphaTo( 0, 0.5, 0, function( )
				if ( IsValid( bg ) ) then
					bg:Remove() 
				end
			end )
		end
		
		-- DO YOU WANT SOME TEA MY DUDE ?
		local englishBtn = vgui.Create( "DButton", bg )
		englishBtn:SetPos( pW/2+40, 255 )
		englishBtn:SetSize( 220, 120 )
		englishBtn:NoClipping( true )
		englishBtn.Paint = function( self, w, h )
			local zoom = outCirc( bg.englishVolume, 0, 1, 100 )
			local zX, zY, zW, zH = 0 - ( 15 * zoom ), 0 - ( 15 * zoom ), w + ( 30 * zoom ), h + ( 30 * zoom )
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( englishFlag )
			surface.DrawTexturedRect( zX, zY, zW, zH ) -- Yeah ik it's ugly but hey it's just for fun
			surface.SetDrawColor( 0, 0, 0, 200 - bg.englishVolume*2 )
			surface.DrawRect( zX, zY, zW, zH )
			return true
		end
		englishBtn.Think = function( self )
			if ( self:IsHovered() ) then
				if ( not bg.englishMusic:IsPlaying() ) then
					bg.englishMusic:Play()
				end
				if ( bg.englishVolume < 100 ) then
					bg.englishVolume = math.max( bg.englishVolume + ( 100*RealFrameTime() ), 1 )
				end
				bg.englishMusic:ChangeVolume( bg.englishVolume/100 )
			else
				if ( bg.englishVolume > 0 ) then
					bg.englishVolume = math.max( bg.englishVolume - ( 100*RealFrameTime() ), 0 )
					bg.englishMusic:ChangeVolume( math.max( 0.01, bg.englishVolume/100 ) )
				end
				-- if ( bg.englishMusic:IsPlaying() and bg.englishVolume <= 0 ) then
					-- bg.englishMusic:Stop()
				-- end
			end
		end
		englishBtn.DoClick = function( self )
			if ( GetConVar( "gts_language" ):GetString() ~= "english" ) then
				GetConVar( "gts_language" ):SetString( "english" )
				GTS.Interface.PSPnl.profilBtn:SetText( GTS.Interface.GetText( "show_profile" ) )
				GTS.Interface.PSPnl.requestBtn:SetText( GTS.Interface.GetText( "request_screen" ) )
				if ( not IsValid( GTS.Interface.PSPnl.selectedPlayer ) ) then
					GTS.Interface.PSPnl.nickLbl:SetText( GTS.Interface.GetText( "select_player" ) )
				end
			end
			bg:AlphaTo( 0, 0.5, 0, function( )
				if ( IsValid( bg ) ) then
					bg:Remove() 
				end
			end )
		end
		
		local cancelBtn = vgui.Create( "DButton_GTS", bg )
		cancelBtn:SetPos( pW/2-75, 580 )
		cancelBtn:SetSize( 150, 50 )
		cancelBtn:SetFont( "Arial_GTS_35_Bold" )
		cancelBtn:SetText( GTS.Interface.GetText( "cancel" ) )
		cancelBtn.DoClick = function( self )
			bg:AlphaTo( 0, 0.5, 0, function( )
				if ( IsValid( bg ) ) then
					bg:Remove() 
				end
			end )
		end
	end
end

concommand.Add( "gimmethatscreen", GTS.Interface.OpenPlayerSelection )
concommand.Add( "gts", GTS.Interface.OpenPlayerSelection )

gameevent.Listen( "player_disconnect" )
hook.Add( "player_disconnect", "GimmeThatScreen", function( data )
	local steamid = data.networkid
	if ( IsValid( GTS.Interface.PSPnl ) ) then
		local btn = GTS.Interface.PSPnl.scrollPnl.plySID[steamid]
		if ( IsValid( btn ) ) then
			btn:Remove()
			GTS.Interface.PSPnl.scrollPnl.plySID[steamid] = nil
			GTS.Interface.PSPnl.nickLbl:SetText( GTS.Interface.GetText( "select_player" ) )
			GTS.Interface.PSPnl.scrollPnl:RecalcBtn()
		end
	end
end )

gameevent.Listen( "player_spawn" )
hook.Add( "player_spawn", "GimmeThatScreen", function( data )
	timer.Simple( 1, function ()
		local ply = Player (data.userid)
		if not ply or not IsValid (ply) or type (ply) ~= "Player" then return end
		if ( not ply:IsBot() and IsValid( GTS.Interface.PSPnl ) and IsValid( GTS.Interface.PSPnl.scrollPnl ) and not IsValid( GTS.Interface.PSPnl.scrollPnl.plySID[ply:SteamID()] ) ) then
			GTS.Interface.PSPnl.scrollPnl:AddPlayer( ply )
		end
	end )
end )