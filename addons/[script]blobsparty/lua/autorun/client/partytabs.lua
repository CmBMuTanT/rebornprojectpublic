--GUI base created by billy
--https://scriptfodder.com/users/view/76561198040894045/scripts

local PANEL = {}

function PANEL:Init()
	self.Tabs = {}
	self.CurrentlySelected = 1
end

function PANEL:Paint()
	surface.SetDrawColor(Color(26,26,26))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end

function PANEL:AddTab(tabname,tabpanel)
	local newTab = vgui.Create("PartyButton",self)
	table.insert(self.Tabs,newTab)
	newTab.OpenPanel = tabpanel
	if (IsValid(tabpanel)) then
		tabpanel:SetMouseInputEnabled(false)
		tabpanel.Paint = function() end
		local tll = 0
		if (IsValid(self:GetParent())) then
			tll = ((self:GetParent():GetTall() - 24) - 35)
			tabpanel:SetParent(self:GetParent())
		else
			tll = (ScrH() - 24 - 35)
			tabpanel:SetParent(NULL)
		end
		tabpanel:SetSize(self:GetWide(),tll)
		tabpanel:SetPos(-tabpanel:GetWide(),24 + 35)
	end

	newTab.myID = #self.Tabs
	newTab:SetText("")
	newTab.Paint = function() end
	newTab:SetSize(self:GetWide() / #self.Tabs,self:GetTall())
	newTab:SetPos((#self.Tabs - 1) * (self:GetWide() / #self.Tabs))
	newTab.DoClick = function()
		self:SelectTab(newTab.myID)
	end

	newTab.TextLbl = vgui.Create("DLabel",newTab)
	newTab.TextLbl:SetTextColor(Color(255,255,255))
	newTab.TextLbl:SetText(tabname)
	newTab.TextLbl:SetFont("roboto16")
	newTab.TextLbl:SizeToContents()
	newTab.TextLbl:Center()

	for i,v in pairs(self.Tabs) do
		v:SetSize(self:GetWide() / #self.Tabs,self:GetTall())
		v:SetPos((i - 1) * (self:GetWide() / #self.Tabs),0)
		v.TextLbl:Center()
	end

	if (not IsValid(self.TabBar)) then
		self.TabBar = vgui.Create("DPanel",self)
		self.TabBar.Paint = function(self)
			surface.SetDrawColor(Color(102,204,179))
			surface.DrawRect(0,0,self:GetWide(),self:GetTall())
		end
		self.TabBar:SetSize(self:GetWide() / #self.Tabs,3)
		self.TabBar:SetPos(0,newTab:GetTall() - 3)
	else
		self.TabBar:SetSize(self:GetWide() / #self.Tabs,3)
		self.TabBar:SetPos(0,newTab:GetTall() - 3)
	end

	if (IsValid(tabpanel)) then
		local x,y = tabpanel:GetPos()
		tabpanel:SetPos((#self.Tabs - 1) * tabpanel:GetWide(),y)
	end

	if (IsValid(tabpanel)) then
		if (tabpanel.onbLogsSetup ~= nil) then
			tabpanel.onbLogsSetup()
		end
	end

	return newTab
end

function PANEL:GetSelectedTabID()
	return self.CurrentlySelected or -1
end
function PANEL:GetTabFromID(id)
	return self.Tabs[id] or NULL
end

function PANEL:SelectTab(id)
	local theTab = self.Tabs[id]
	if (self:GetSelectedTabID() ~= id) then
		for i,v in pairs(self.Tabs) do
			if (IsValid(v.OpenPanel)) then
				v.OpenPanel:Stop()
				local _,y = v.OpenPanel:GetPos()
				v.OpenPanel:MoveTo((i - id) * v.OpenPanel:GetWide(),y,0.5)
			end
		end

		self.TabBar:Stop()
		local x,y = self.TabBar:GetPos()
		self.TabBar:MoveTo((id - 1) * (self:GetWide() / #self.Tabs),y,0.5)
	end
	self.CurrentlySelected = id

	return theTab.OpenPanel
end

derma.DefineControl("PartyTabs",nil,PANEL,"DPanel")