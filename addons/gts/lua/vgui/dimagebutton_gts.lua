local function drawCircle( x, y, radius, quality )
	local circle = {}
	local tmp = 0
	for i=1,quality do
		tmp = math.rad(i*360)/quality
		circle[i] = {x = x + math.cos(tmp)*radius,y = y + math.sin(tmp)*radius}
	end
	surface.DrawPoly( circle )
	return circle
end	

local PANEL = {} 

function PANEL:Init() 
	self.circle = false
	self.primaryColor = Color( 175, 70, 175 )
	self.iconColor = Color( 255, 255, 255 )
	self.borderColor = Color( 255, 255, 255 )
	
	self.borderSize = 0
	
	self.zoomEnabled = true
	self.zoomVal = 0
	self.zoomMax = 10
	self.zoomStyle = 2 -- 1 = linear / 2 = smooth
	
	
	self.material = nil

	self.iconSize = 0
	self.iconZoomRatio = 1.5
	self.iconShadow = 0
	
	self.clickPos = 0
	
end 

function PANEL:SetMaterial( mat )
	if ( type( mat ) == "string" ) then
		self.material = Material( mat, "smooth" )
	else
		self.material = mat
	end
end

function PANEL:GetMaterial()
	return self.material
end

function PANEL:SetCircle( bool )
	self.circle = bool
end

function PANEL:SetColor( col )
	self.primaryColor = col
end

function PANEL:SetIconColor( col )
	self.iconColor = col
end

function PANEL:SetBorderColor( col )
	self.borderColor = col
end

function PANEL:SetIconSize( size )
	self.iconSize = size
end

function PANEL:SetBorderSize( num )
	self.borderSize = num
end

function PANEL:SetShadow( num )
	self.iconShadow = num
end

function PANEL:SetMaxZoom( num )
	self.zoomMax = num
end

function PANEL:EnableZoom( bool )
	self.zoomEnabled = bool
end

function PANEL:Think()

	if ( self:IsHovered() and self.zoomVal < self.zoomMax and self.zoomEnabled ) then
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
	
	
	if ( self.Depressed and self.clickPos < 5 ) then
		self.clickPos = 5
	elseif ( not self.Depressed and self.clickPos > 0 ) then
		self.clickPos = math.Clamp( self.clickPos - ( 5 * RealFrameTime() ), 0, 200 )
	end
	
	self:PostThink()
end
 
function PANEL:PostThink()

end
 
function PANEL:Paint( w, h )
	if ( self.circle ) then
		self:PaintCircle( w, h )
	else
		self:PaintRectangle( w, h )
	end
	return true
end

function PANEL:PaintCircle( w, h ) 
	DisableClipping(true)
	
	draw.NoTexture()
	if ( self.borderSize > 0 ) then
		surface.SetDrawColor( Color( 255, 255, 255 ) )
		drawCircle( w/2, h/2, w/2 + self.zoomVal + self.borderSize, 50 )
	end
	surface.SetDrawColor( self.primaryColor )
	drawCircle( w/2, h/2, w/2 + self.zoomVal, 50 )
	
	if ( self.material ) then
		surface.SetMaterial( self:GetMaterial() )
		local imgSize = math.cos( math.rad( 45 ) )
		local xyPos = ((w/2) - math.Round( imgSize*w )/2) - (self.zoomVal*1.3)
		
		if ( self.iconShadow > 0 ) then
			surface.SetDrawColor( Color( 150, 150, 150 ) )
			surface.DrawTexturedRect( xyPos + 3, xyPos + 3, imgSize*w + ( (self.zoomVal*1.3)*2 ), imgSize*h + ( (self.zoomVal*1.3)*2 ) )
		end
		surface.SetDrawColor( self.iconColor )
		surface.DrawTexturedRect( xyPos, xyPos, imgSize*w + ( (self.zoomVal*1.3)*2 ), imgSize*h + ( (self.zoomVal*1.3)*2 ) )
	end
	
	DisableClipping(false)
end

function PANEL:PaintRectangle( w, h ) 
	DisableClipping(true)
	
	local midW, midH 	= w/2, h/2
	local wExpnd 		= w + ( self.zoomVal*2 )
	local xExpngLogo	= self.zoomVal*self.iconZoomRatio
	local wExpndLogo 	= w + ( xExpngLogo*2 )
	
	if ( self.borderSize ) then
		local xBorderRectPos = -self.zoomVal - self.borderSize
		local wBorderRectPos = wExpnd + ( self.borderSize * 2 )
		
		surface.SetDrawColor( self.borderColor )
		surface.DrawRect( xBorderRectPos, xBorderRectPos, wBorderRectPos, wBorderRectPos )
	end
	-- surface.SetDrawColor( self.primaryColor )
	-- surface.DrawRect( -self.zoomVal, -self.zoomVal, w + ( self.zoomVal * 2 ), h + ( self.zoomVal * 2 ) )
	
	if ( self.material ) then
		local xIconPos, yIconPos, wIconSize, hIconSize
		local zoomIcon = self.zoomVal*self.iconZoomRatio
		if ( self.iconSize > 0 ) then
			xIconPos, yIconPos = (midW)-(self.iconSize/2) - (zoomIcon/2), (midH)-(self.iconSize/2) - (zoomIcon/2)
			wIconSize, hIconSize = self.iconSize + zoomIcon, self.iconSize + zoomIcon
		else
			xIconPos, yIconPos = -xExpngLogo, -xExpngLogo
			wIconSize, hIconSize = wExpndLogo , wExpndLogo
		end
	
		surface.SetMaterial( self:GetMaterial() ) 
		if ( self.iconShadow > 0 ) then
			surface.SetDrawColor( Color( 150, 150, 150 ) )
			surface.DrawTexturedRect( xIconPos + 3, yIconPos + 3, wIconSize, hIconSize)
		end
		surface.SetDrawColor( self.iconColor )
		surface.DrawTexturedRect( xIconPos, yIconPos, wIconSize, hIconSize )
	end 
	
	DisableClipping(false)
end
-- function PANEL:OnMousePressed( key ) end
function PANEL:PerformLayout( w, h ) end
 
derma.DefineControl( "DImageButton_GTS", "Derived DImageButton from FE for GTS", PANEL, "DButton" )
