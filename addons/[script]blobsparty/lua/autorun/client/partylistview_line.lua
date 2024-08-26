--GUI base created by billy
--https://scriptfodder.com/users/view/76561198040894045/scripts

local PANEL = {}

function PANEL:Init()
	for _,v in pairs(self.Columns) do
		v:SetTextColor(Color(0,0,0))
		v:SetFont("roboto16")

		v.PaintOver = function(self)
			surface.SetDrawColor(Color(219,219,219))
			surface.DrawRect(0,0,1,self:GetTall())
		end
	end
	if (self.ColorMode == false) then
		self.Paint = function(self)
			if (self:IsLineSelected()) then
				surface.SetDrawColor(Color(26,26,26))
				surface.DrawRect(0,0,self:GetWide(),self:GetTall())
				return
			end

			local bg = Color(255,255,255)

			if (self:IsHovered()) then
				bg = Color(245,245,245)
			end

			surface.SetDrawColor(bg)
			surface.DrawRect(0,0,self:GetWide(),self:GetTall())

			surface.SetDrawColor(Color(219,219,219))
			surface.DrawRect(1,self:GetTall() - 1,self:GetWide() - 2,1)
		end
	else
		self.Paint = function(self)
			if (self:IsLineSelected()) then
				surface.SetDrawColor(Color(26,26,26))
				surface.DrawRect(0,0,self:GetWide(),self:GetTall())
				return
			end

			local bg = Color(245,245,245)

			if (self:IsHovered()) then
				bg = Color(235,235,235)
			end

			surface.SetDrawColor(bg)
			surface.DrawRect(0,0,self:GetWide(),self:GetTall())

			surface.SetDrawColor(Color(219,219,219))
			surface.DrawRect(1,self:GetTall() - 1,self:GetWide() - 2,1)
		end
	end
	self.ColorMode = not self.ColorMode
end
function PANEL:OnMousePressed(mcode)
	if (mcode == MOUSE_RIGHT) then
		self:GetListView():OnRowRightClick(self:GetID(),self)
		self:OnRightClick()
		return
	end
	self:GetListView():OnClickLine(self,true)
	self:OnSelect()
end

derma.DefineControl("PartyListView_Line",nil,PANEL,"DListView_Line")