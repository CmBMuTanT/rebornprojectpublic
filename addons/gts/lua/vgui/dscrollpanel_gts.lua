local PANEL = {}

function PANEL:Init()
	local sbar = self:GetVBar()
	sbar:SetHideButtons( true )
	
	function sbar:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0, 180 )
		surface.DrawRect( 0, 0, w, h )
	end
	function sbar.btnGrip:Paint( w, h )
		local wVal = 180 + math.sin( CurTime() * 3 ) * 40
		surface.SetDrawColor( wVal, wVal, wVal, 255 )
		surface.DrawRect( 0, 0, w, h )
	end
end 

function PANEL:SetGripSize( w )
	self:GetVBar():SetWide( w )
end

function PANEL:Paint( w, h )
	surface.SetDrawColor( 0, 0, 0, 50 )
	surface.DrawRect( 0, 0, w, h )
end 
 
derma.DefineControl( "DScrollPanel_GTS", "Derived DScrollPanel from FE for GTS", PANEL, "DScrollPanel" )