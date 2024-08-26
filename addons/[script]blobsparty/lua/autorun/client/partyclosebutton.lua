local PANEL = {}

function PANEL:Init()
	self:GetParent().btnClose:SetVisible(false)
	self:GetParent().btnMaxim:SetVisible(false)
	self:GetParent().btnMinim:SetVisible(false)

	self.Paint = function() end
	self:SetSize(18,18)
	self:SetText("X")
	self:SetFont("roboto16")
	self:SetTextColor(Color(255,255,255))
	self:AlignRight(2)
	self:AlignTop(2)
	self.DoClick = function()
		self:GetParent():Close()
	end
end

function PANEL:ShowCloseButton(shouldshow)
	self:SetVisible(shouldshow)
end

derma.DefineControl("PartyCloseButton",nil,PANEL,"DButton")
