
local PANEL = {}

AccessorFunc( PANEL, "m_bFirstPerson", "FirstPerson" )

function PANEL:Init()
	self.mx = 0
	self.my = 0
	self.aLookAngle = angle_zero

    self:MouseCapture( true )
end

function PANEL:Populate()
    if IsValid(self.Entity) then
        local mins, maxs = self.Entity:GetModelBounds()
        local center = ( mins + maxs ) / 2

        self.OrbitPoint = center
        self.OrbitDistance = ( self.OrbitPoint - self.vCamPos ):Length()
    end
end

function PANEL:OnMousePressed( mousecode )

	self:MouseCapture( true )
	self.Capturing = true
	self.MouseKey = mousecode

	self:SetFirstPerson( true )

	self:CaptureMouse()

	-- Helpers for the orbit movement
end

function PANEL:Think()
    if not self.OrbitPoint then
        self:Populate()
    end

	return self:FirstPersonControls()
end

function PANEL:CaptureMouse()

	local x, y = input.GetCursorPos()

	local dx = x - self.mx
	local dy = y - self.my

	local centerx, centery = self:LocalToScreen( self:GetWide() * 0.5, self:GetTall() * 0.5 )
	input.SetCursorPos( centerx, centery )
	self.mx = centerx
	self.my = centery

	return dx, dy

end

function PANEL:FirstPersonControls()

	local x, y = self:CaptureMouse()

	local scale = self:GetFOV() / 225
	x = x * -0.5 * scale
	y = y * 0.5 * scale


    if ( input.IsShiftDown() ) then y = 0 end

    self.aLookAngle = self.aLookAngle + Angle( y / 2, x / 2, 0 )

    self.vCamPos = self.OrbitPoint - self.aLookAngle:Forward() * self.OrbitDistance

    return
end

function PANEL:OnMouseWheeled( dlta )

	local scale = self:GetFOV() / 180
	self.fFOV = math.Clamp(self.fFOV + dlta * -10.0 * scale, 15, 125)

end

function PANEL:OnMouseReleased( mousecode )

	self:MouseCapture( false )
	self.Capturing = false

end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
	ctrl:SetSize( 300, 300 )
	ctrl:SetModel( "models/props_junk/PlasticCrate01a.mdl" )
	ctrl:GetEntity():SetSkin( 2 )
	ctrl:SetLookAng( Angle( 45, 0, 0 ) )
	ctrl:SetCamPos( Vector( -20, 0, 20 ) )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "ixOrbitableModelPanel", "A panel containing a model", PANEL, "DModelPanel" )