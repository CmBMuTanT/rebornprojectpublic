--GUI base created by billy
--https://scriptfodder.com/users/view/76561198040894045/scripts

local PANEL = {}

function PANEL:SetTabs(tabs)
	tabs:InvalidateParent(true)
	local x,y = tabs:GetPos()
	self:SetPos(x,y + tabs:GetTall())
end

function PANEL:Paint()
	surface.SetDrawColor(Color(255,0,0))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end

derma.DefineControl("PartyTabs_Panel",nil,PANEL,"DPanel")