-- Original : https://github.com/EmmanuelOga/easing
local function outBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end

local PANEL = {}

AccessorFunc( PANEL, "_min", "Min", FORCE_NUMBER )
AccessorFunc( PANEL, "_max", "Max", FORCE_NUMBER )
AccessorFunc( PANEL, "_numFont", "Font", FORCE_STRING )
AccessorFunc( PANEL, "_drawKnob", "DrawKnob", FORCE_BOOL )
AccessorFunc( PANEL, "_drawNumbers", "DrawNumbers", FORCE_BOOL )

local blackColor = Color( 0, 0, 0 )
local mat = Material( "gts/c_2.png" )
local pnlMat = Material( "gts/pnl_2.png" )
 
function PANEL:DrawLine( w, h )
	draw.RoundedBox( 6, 0, h/2 - 4, w, 8, blackColor )
	draw.RoundedBox( 6, 0, h/2 - 4, self.m_fSlideX * w, 8, Color( 20, 255, 255 ) )
end  

function PANEL:Init() 
	self:SetMin( 0 )
	self:SetMax( 100 )
	self:SetFont( "DermaDefault" )

	self:SetDrawKnob( true )
	self:SetDrawNumbers( true )
	
	self.primaryColor = Color( math.random( 100, 255 ), math.random( 100, 255 ), math.random( 100, 255 ) )
	self.secondaryColor = Color( math.random( 100, 255 ), math.random( 100, 255 ), math.random( 100, 255 ) )
	self.backgroundColor = Color( math.random( 30, 60 ), math.random( 30, 60 ), math.random( 30, 60 ) )
	
	self:SetupKnob()
end

function PANEL:SetupKnob()
	local knob = self.Knob
	local parent = knob:GetParent()
	knob.hoverF = 0
	
	knob.Paint = function( self, w, h )
		if ( parent:GetDrawKnob() ) then
			local hoverF = knob.hoverF
			if ( self:IsHovered() or parent:IsEditing() ) then
				-- if ( slider:GetDragging() ) then
					-- if ( self.hoverF > 0.5 ) then
						-- self.hoverF = math.max( self.hoverF - 8 * RealFrameTime(), 0.5 )
					-- else
						-- self.hoverF = math.max( self.hoverF + 1 * RealFrameTime(), 0.5 )
					-- end
				-- else
					self.hoverF = math.min( self.hoverF + 1 * RealFrameTime(), 1 )
				-- end
			else
				if ( self.hoverF > 0 ) then
					self.hoverF = math.max( self.hoverF - 3 * RealFrameTime(), 0 )
				end
			end
			
			local finalSize = outBack( self.hoverF, 0, 1, 1, 2 )
			surface.SetDrawColor( parent.primaryColor.r, parent.primaryColor.g, parent.primaryColor.b, 90 )
			surface.SetMaterial( mat )
			surface.DrawTexturedRectRotated( w/2, h/2+1, (w*( 3.5))*finalSize, (h*3.5)*finalSize, 0 )
			
			surface.SetDrawColor( parent.primaryColor )
			surface.SetMaterial( mat )
			surface.DrawTexturedRectRotated( w/2, h/2+1, w*1.5, h*1.5, 0 )
			
			local x, y = self:LocalToScreen( 0, 0 )
			local ease = outBack( self.hoverF, 0, 1 , 1)
			local pnlW = 40 * ease
			
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( pnlMat )
			surface.DrawTexturedRectRotated( w/2, -20, pnlW, 35, 0 )
			
			render.SetScissorRect( x + ( w/2 ) - ( pnlW )/2, y-200, x+(w/2) + pnlW/2, y+500, true ) 
				draw.SimpleText( math.Round( Lerp( parent:GetSlideX() , parent:GetMin(), parent:GetMax() ) ), "Trebuchet18", w/2, -23, Color( 0, 0, 0 ), 1, 1 )
			render.SetScissorRect( 0, 0, 0, 0, false )
		end
	end
end

function PANEL:PerformLayout()
	local w, h = self:GetSize()
	local iw, ih = self.Knob:GetSize()
	if ( self.m_bTrappedInside ) then
		w = w - iw
		h = h - ih
		self.Knob:SetPos( ( self.m_fSlideX || 0 ) * w, ( self.m_fSlideY || 0 ) * h )
	else
		self.Knob:SetPos( ( self.m_fSlideX || 0 ) * w - iw * 0.5, ( self.m_fSlideY || 0 ) * h - ih * 0.5 )
	end


end

function PANEL:CalcNums()
	
end

function PANEL:Paint( w, h )
	draw.RoundedBox( 6, 0, h/2 - 4, w, 8, self.backgroundColor )
	draw.RoundedBox( 6, 0, h/2 - 4, self.m_fSlideX * w, 8, self.primaryColor )
	
	if ( self:GetDrawNumbers() ) then
		local font = self:GetFont()
		DisableClipping(true)
			surface.SetDrawColor( self.backgroundColor )
			for i = 0, 10 do
				surface.DrawRect( Lerp( i/10, 2, w - 2 ), h/2 + 8, 1, 10)
				draw.SimpleText( math.Round( Lerp( i/10, self:GetMin(), self:GetMax() ) ), font, ( i/10 )*w, h/2 + 18, color_white, TEXT_ALIGN_CENTER, 0 )
			end
		DisableClipping(false)
	end
end

function PANEL:TranslateValues( x, y )
	self:OnValueChanged( Lerp( x, self:GetMin(), self:GetMax() ) )
	return x, y
end

function PANEL:OnValueChanged( val ) 
	-- ...
end

function PANEL:SetValue( val )
	local val = tonumber( val or 0 )
	self:SetSlideX( math.min( math.max( val - self:GetMin(), 0 )/self:GetMax(), 1 ) )
	
	OnValueChanged( val )
end

function PANEL:GetValue()
	return Lerp( self:GetSlideX() , self:GetMin(), self:GetMax() )
end

-- function PANEL:PerformLayout()
	-- self.Label:SetWide( self:GetWide() * 0.4 ) 
-- end
 
 
derma.DefineControl( "DSlider_GTS", "Derived DSlider for GTS", PANEL, "DSlider" ) 