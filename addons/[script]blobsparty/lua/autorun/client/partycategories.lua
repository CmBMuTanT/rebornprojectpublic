local PANEL = {}

surface.CreateFont("roboto16",{
	size = 16,
	font = "Roboto",
})

function PANEL:Paint()
	surface.SetDrawColor(Color(26,26,26))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end

function PANEL:Init()
	self.VBar.btnUp:SetText("-")
	self.VBar.btnUp:SetFont("roboto16")
	self.VBar.btnUp:SetTextColor(Color(255,255,255))
	self.VBar.btnUp.Paint = function(self)
		surface.SetDrawColor(Color(0,0,0))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end

	self.VBar.btnDown:SetText("-")
	self.VBar.btnDown:SetFont("roboto16")
	self.VBar.btnDown:SetTextColor(Color(255,255,255))
	self.VBar.btnDown.Paint = function(self)
		surface.SetDrawColor(Color(0,0,0))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end

	self.VBar.btnGrip:SetCursor("hand")
	self.VBar.btnGrip.Paint = function(self)
		surface.SetDrawColor(Color(50,50,50))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end

	self.VBar.Paint = function(self)
		surface.SetDrawColor(Color(0,0,0))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end

	self.Container = vgui.Create("DPanel",self)
	self.Container.Paint = function() end

	self.Items = {}
end

function PANEL:NewItem(name,color,f,force_toggle)

	local this = self

	local new = vgui.Create("DPanel",self.Container)
	new:SetCursor("hand")
	new:SetSize(self.Container:GetWide(),30)
	table.insert(self.Items,new)
	new:AlignLeft(0)
	new.Paint = function() end

	new.borderLeft = vgui.Create("DPanel",new)
	new.borderLeft:SetSize(5,new:GetTall())
	new.borderLeft:AlignTop(0)
	new.borderLeft:AlignLeft(0)
	new.borderLeft.Paint = function()
		surface.SetDrawColor(color or Color(26,26,26))
		surface.DrawRect(0,0,new.borderLeft:GetWide(),new.borderLeft:GetTall())
	end

	new.text = vgui.Create("DLabel",new)
	new.text:SetTextColor(Color(255,255,255))
	new.text:SetFont("roboto16")
	new.text:SetText(name)
	new.text:SizeToContents()
	new.text:AlignLeft(10)
	new.text:CenterVertical()

	function new:OnCursorEntered()
		if (new.Toggled) then return end
		new.borderLeft:SetWide(7)
		new.text:AlignLeft(13)
	end

	function new:OnCursorExited()
		if (new.Toggled) then return end
		new.borderLeft:SetWide(5)
		new.text:AlignLeft(10)
	end

	function new:OnMousePressed()
		f(name,color,new)
		if (force_toggle) then
			for _,v in pairs(this.Items) do
				if (v.borderLeft and v.Toggled) then
					v.Toggled = false
					v.borderLeft:Stop()
					v.borderLeft:SizeTo(5,v.borderLeft:GetTall(),0.25)
					v.text:AlignLeft(10)
				end
			end
			new.Toggled = true
			new.borderLeft:Stop()
			new.borderLeft:SizeTo(new:GetWide(),new.borderLeft:GetTall(),0.25)
			new.text:AlignLeft(13)
		end
	end
	function new.borderLeft:OnMousePressed() new:OnMousePressed() end
	function new.text:OnMousePressed() new:OnMousePressed() end

	self:FixLayout()

	return new
end

function PANEL:NewCategory(name,color)

	local new = vgui.Create("DPanel",self.Container)
	new:SetSize(self.Container:GetWide(),30)
	new:AlignTop(#self.Items * 30)
	table.insert(self.Items,new)
	new:AlignLeft(0)
	new.Paint = function()
		surface.SetDrawColor(color or Color(26,26,26))
		surface.DrawRect(0,0,new:GetWide(),new:GetTall())
	end

	new.text = vgui.Create("DLabel",new)
	if (color.r >= 160 and color.g >= 160 and color.b >= 160) then
		new.text:SetTextColor(Color(0,0,0))
	else
		new.text:SetTextColor(Color(255,255,255))
	end
	new.text:SetFont("roboto16")
	new.text:SetText(name)
	new.text:SizeToContents()
	new.text:Center()

	self:FixLayout()
end

function PANEL:FixLayout()
	self.Container:SetSize(self:GetWide(),0)
	local s = 0
	for i,v in pairs(self.Items) do
		local t = self.Container:GetTall()
		self.Container:SetSize(self:GetWide(),t + v:GetTall())
		if (i == 1) then
			v:AlignTop(0)
			s = v:GetTall()
		else
			v:AlignTop(t + v:GetTall() - s)
		end
		v:SetWide(self.Container:GetWide())
		v.text:SetWide(self.Container:GetWide() - 15)
		v.text:AlignLeft(10)
	end
end

function PANEL:Clear()
	for _,v in pairs(self.Items) do
		v:Remove()
	end
	self.Items = {}
end

derma.DefineControl("PartyCategories",nil,PANEL,"DScrollPanel")