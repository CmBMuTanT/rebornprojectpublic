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
	local childrens = self:GetChildren()
	
	self.TextArea:SetTextColor( color_white )
	self.TextArea:SetFont( "Trebuchet24" )
	
	self.Slider:SetWide( self:GetWide()*0.9 )
	self.Slider.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 0, h/2, w, 2 )
	end
	local sliderBtn = self.Slider:GetChildren()[1]
	
	sliderBtn.Paint = function( self, w, h )
		if ( facialEmote.interface.isMaterialValid( "circle" ) ) then
			surface.SetDrawColor( color_white )
			surface.SetMaterial( facialEmote.interface.getMaterial( "circle" ) )
			surface.DrawTexturedRect( 0, 0, w, h )
		else
			surface.SetDrawColor( color_white )
			draw.NoTexture()
			drawCircle( w/2, h/2 + 1, h/2, 20 )
		end
	end    

	self.Label:SetFont( "Trebuchet18" )
	self.Label:SetContentAlignment( 5 )
	self.Label:SetTextColor( color_white )
end 

function PANEL:Paint( w, h )
	surface.SetDrawColor( 80, 80, 80, 100 )
	surface.DrawRect( self:GetWide() * 0.4 - 5, 0, w, h )
end
   
function PANEL:PerformLayout()
	self.Label:SetWide( self:GetWide() * 0.4 ) 
end

derma.DefineControl( "DNumSlider_GTS", "Derived DNumSlier from FE for GTS", PANEL, "DNumSlider" )