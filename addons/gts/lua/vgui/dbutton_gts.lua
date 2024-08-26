local PANEL = {} 

function PANEL:Init() 
	self.primaryColor = Color( 70, 70, 80 )
	self.iconBackgroundColor = Color( 60, 60, 75 )
	self.iconColor = Color( 255, 255, 255 )
	self.borderColor = Color( 150, 255, 255 )
	self.textColor = Color( 255, 255, 255 )
	
	self.borderSize = 2
	self.borderOnHovered = true
	
	self.zoomEnabled = true
	self.zoomVal = 0
	self.zoomMax = 5
	self.zoomStyle = 2
	
	self.matrix = Matrix()
	
	self.iconMat = nil
	self.iconSize = 0
	self.iconZoomRatio = 1.5
	self.iconPadding = 10
	self.iconShadow = 0
	
	self.clickPos = 0 
end 

function PANEL:SetIcon( mat )
	local matType = type( mat )
	if ( matType == "string" ) then
		self.iconMat = Material( mat )
	elseif ( matType == "Player" ) then
		if ( not self.iconMat ) then
			self.iconMat = vgui.Create( "AvatarImage", self )
			self.iconMat:SetPaintedManually( true )
			self.iconMat:SetPlayer( mat, 256 )
		end
	else
		self.iconMat = mat
	end
end

function PANEL:SetColor( col )
	self.primaryColor = ( col or Color( 255, 0, 0 ) )
end

function PANEL:SetTextColor( col )
	self.textColor = ( col or Color( 255, 0, 0 ) )
end

function PANEL:SetIconColor( col )
	self.iconColor = ( col or Color( 0, 255, 0 ) )
end

function PANEL:SetBorderColor( col )
	self.borderColor = ( col or Color( 0, 0, 255 ) )
end

function PANEL:SetIconBackgroundColor( col )
	self.iconBackgroundColor = ( col or Color( 255, 255, 0 ) )
end

function PANEL:SetBorderSize( num )
	self.borderSize = num
end
 
function PANEL:SetBorderOnHovered( bool )
	self.borderOnHovered = bool
end

function PANEL:EnableZoom( bool )
	self.zoomEnabled = bool
end

function PANEL:SetMaxZoom( num )
	self.zoomMax = num
end

function PANEL:Think( w, h )
	if ( self:IsHovered() and self:GetZPos() ~= 1 ) then
		self:SetZPos( 1 )
	elseif ( not self:IsHovered() and self:GetZPos() ~= 0 ) then
		self:SetZPos( 0 )
	end
	
	if (  self.zoomEnabled ) then		
		if ( self:IsHovered() and self.zoomVal < self.zoomMax and self:IsEnabled() ) then
			if ( self.zoomStyle == 1 ) then
				self.zoomVal = math.Clamp( self.zoomVal + ( 20 * RealFrameTime() ), 0, self.zoomMax )
			else
				self.zoomVal = self.zoomVal + ( self.zoomMax - self.zoomVal ) * ( RealFrameTime() * 5 )
			end
		elseif ( not self:IsHovered() and self.zoomVal > 0 ) then
			if ( self.zoomStyle == 1 ) then
				self.zoomVal = math.Clamp( self.zoomVal - ( 30 * RealFrameTime() ), 0, self.zoomMax )
			else
				self.zoomVal = self.zoomVal + ( 0 - self.zoomVal ) * ( RealFrameTime() * 5 )
			end
		end
		
		if ( self:IsHovered() and input.IsMouseDown( MOUSE_FIRST ) ) then
			self.zoomVal = 0
		end
	end

	self:PostThink()
end

function PANEL:PostThink() end

function PANEL:OnCursorEntered()
	surface.PlaySound( "gts/button_hovered.wav" )
end

function PANEL:ResetMat()
	local mat = Matrix()
	mat:Scale( Vector( 1, 1, 1 ) )
	mat:SetAngles( Angle( 0, 0, 0 ) )
	mat:SetTranslation( Vector( 0, 0, 0 ) )
	cam.PushModelMatrix( mat )
end

function PANEL:SetParentScissor( pnl )
	self.parentScissor = pnl
end

function PANEL:Paint( w, h )
	if ( self.parentScissor ) then
		DisableClipping(true) 
		local pPosX, pPosY = self.parentScissor:LocalToScreen( 0, 0 )
		local pSizeW, pSizeH = self.parentScissor:GetSize()
		local zoomVal = self.zoomVal
		
		render.SetScissorRect( pPosX - zoomVal, pPosY - zoomVal, pPosX + pSizeW + zoomVal*2, pPosY + pSizeH + zoomVal*2, true )
	else
		DisableClipping(true) 
	end
	
	surface.SetDrawColor( self.primaryColor )
	surface.DrawRect( -self.zoomVal, -self.zoomVal, w + ( self.zoomVal * 2 ), h + ( self.zoomVal * 2 ) )
	
	if ( self.borderOnHovered and self:IsHovered() and self.borderSize > 0 and self:IsEnabled() ) then
		surface.SetDrawColor( self.borderColor )
		for i = 1, self.borderSize do
			surface.DrawOutlinedRect( -i - self.zoomVal, -i - self.zoomVal, w+i*2 + self.zoomVal*2, h+i*2 + self.zoomVal*2)
		end
	elseif ( not self.borderOnHovered and self.borderSize > 0 ) then
		surface.SetDrawColor( self.borderColor )
		for i = 1, self.borderSize do
			surface.DrawOutlinedRect( -i - self.zoomVal, -i - self.zoomVal, w+i*2 + self.zoomVal*2, h+i*2 + self.zoomVal*2)
		end
	end
	
	local textPosX, textPosY
	if ( self.iconMat ) then
		local wh = h - ( self.iconPadding * 2 ) + ( (self.zoomVal*self.iconZoomRatio) * 2 )
		local xyPos = self.iconPadding - (self.zoomVal*self.iconZoomRatio)
		local whRect = h + ( self.zoomVal * 2 )
		surface.SetDrawColor( self.iconBackgroundColor )
		surface.DrawRect( -self.zoomVal, -self.zoomVal, whRect, whRect )
		if ( type( self.iconMat ) == "Panel" ) then
			self.iconMat:SetPos( xyPos, xyPos )
			self.iconMat:SetSize( wh, wh )
			self.iconMat:PaintManual()
		else
			surface.SetMaterial( self.iconMat )
			surface.SetDrawColor( self.iconColor )
			surface.DrawTexturedRect( xyPos, xyPos, wh, wh )	
		end
		textPosX, textPosY = whRect + (w-whRect)/2 , h/2
	else
		textPosX, textPosY = w/2 , h/2
	end
	
	if ( self.zoomEnabled ) then
		local localX, localY = self:LocalToScreen( 0, 0 )
		surface.SetFont( self:GetFont() )
		local width, height = surface.GetTextSize( self:GetText() )
		local finalX, finalY = localX + textPosX, localY + textPosY
		self.matrix:SetTranslation( Vector( finalX, finalY ) )
		self.matrix:SetScale( Vector( 0.5 + math.Round( (self.zoomVal/self.zoomMax)*0.5, 2 ), 0.5 + math.Round( (self.zoomVal/self.zoomMax)*0.5, 2 ), 1 )  )
		self.matrix:Translate( -Vector( width/2, height/2 ) )
		cam.PushModelMatrix( self.matrix )
			draw.SimpleText( self:GetText(), self:GetFont(), -localX, -localY, self.textColor, 0, 0 )
		cam.PopModelMatrix()
	else
		draw.SimpleText( self:GetText(), self:GetFont(), textPosX, textPosY, self.textColor, 1, 1 )
	end
	
	if ( self:IsHovered() ) then
		surface.SetDrawColor( Color( 255, 255, 255, 30 ) )
		surface.DrawRect( -self.zoomVal, -self.zoomVal, w + ( self.zoomVal * 2 ), h + ( self.zoomVal * 2 ) )
	end
	
	if ( self.parentScissor ) then
		render.SetScissorRect( 0, 0, 0, 0, false ) 
		DisableClipping(false)
	else
		DisableClipping(false)
	end
	
	if ( not self:IsEnabled() ) then
		surface.SetDrawColor( Color( 0, 0, 0, 180 ) )
		surface.DrawRect( 0, 0, w, h )
	end
	
	return true
end
 
derma.DefineControl( "DButton_GTS", "Derived DButton from FE for GTS", PANEL, "DButton" )