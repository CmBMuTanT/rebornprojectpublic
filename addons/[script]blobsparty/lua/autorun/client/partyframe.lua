local PANEL = {}

surface.CreateFont("roboto16",{
	font = "Roboto",
	size = 16,
})

function PANEL:Init()
	self.ShowTitleBar = true
	self.BackgroundColor = Color(255,255,255)

	self:DockPadding(1,24,1,1)

	self.lblTitle:SetTextColor(Color(255,255,255))
	self.lblTitle:SetFont("roboto16")
	self.lblTitle:SetPos(5,5)

	self.Paint = function(self)
		surface.SetDrawColor(self.BackgroundColor)
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())

		if (self.ShowTitleBar ~= false) then
			surface.SetDrawColor(Color(26,26,26))
			surface.DrawRect(0,0,self:GetWide(),24)

			surface.SetDrawColor(Color(26,26,26))
			surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
		end
	end
end

function PANEL:ShowCloseButton(shouldshow)
	self.CloseButton:ShowCloseButton(shouldshow)
end

function PANEL:Configured()
	self.CloseButton = vgui.Create("PartyCloseButton",self)
end

function PANEL:Paint()
	surface.SetDrawColor(Color(26,26,26))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end

function PANEL:Close()
	self:Remove()

	if (self.OnClose ~= nil) then
		self.OnClose()
	end
end

function PANEL:ShouldShowTitleBar(shouldshow)
	PANEL.ShowTitleBar = tobool(shouldshow) or true
end
function PANEL:SetBackgroundColor(bgcolor)
	PANEL.ShowTitleBar = tobool(shouldshow) or true
end

derma.DefineControl("PartyFrame",nil,PANEL,"DFrame")
