local PANEL = {}

function PANEL:Init()
	self:SetTextColor(Color(0,0,0))
	self:SetFont("roboto16")
end

derma.DefineControl("PartyLabel",nil,PANEL,"DLabel")