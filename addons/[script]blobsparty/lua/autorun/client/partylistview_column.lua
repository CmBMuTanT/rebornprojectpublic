local PANEL = {}

function PANEL:Init()
	self.DrawOutline = false

	self.Header:SetFont("roboto16")
	self.Header:SetTextColor(Color(0,0,0))
	function self.Header:OnMousePressed() end
	
	if (IsValid(self.DraggerBar)) then
		self.DraggerBar:SetText("")
		self.DraggerBar.Paint = function(self)
			surface.SetDrawColor(Color(206,206,206))
			surface.DrawRect(3,0,1,self:GetTall())
		end
	end

	self.Header.Paint = function(self)
		local bg = Color(242,242,242)

		if (self:IsHovered()) then
			bg = Color(232,232,232)
		end

		surface.SetDrawColor(bg)
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())

		surface.SetDrawColor(Color(206,206,206))
		surface.DrawRect(0,self:GetTall() - 1,self:GetWide(),1)
	end
end

function PANEL:DrawOutline(shoulddraw)
	self.DrawOutline = shoulddraw
end

derma.DefineControl("PartyListView_Column",nil,PANEL,"DListView_Column")