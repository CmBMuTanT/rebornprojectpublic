local PANEL = {}

function PANEL:Init()
	self:SetTextColor(Color(255,255,255))
	self:SetFont("roboto16")
end

function PANEL:Paint()
	if (self:GetDisabled() ~= false) then
		surface.SetDrawColor(Color(26,26,26))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	else
		if (self:IsHovered() and input.IsMouseDown(MOUSE_LEFT)) then
			surface.SetDrawColor(Color(0,100,0))
		elseif (self:IsHovered()) then
			surface.SetDrawColor(Color(0,165,0))
		else
			surface.SetDrawColor(Color(0,150,0))
		end
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
		surface.SetDrawColor(Color(26,26,26))
		surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
	end
end

derma.DefineControl("PartyButton",nil,PANEL,"DButton")