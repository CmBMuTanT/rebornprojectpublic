local PANEL = {}

function PANEL:Init()
	self.Paint = function(self)
		surface.SetDrawColor(Color(255,255,255))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end
	self:SetHeaderHeight(35)
	self:SetDataHeight(25)
	self.ColorMode = false

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
end

function PANEL:Clear()
	self.ColorMode = false

	for a,b in pairs(self.Lines)do b:Remove()end;self.Lines={}self.Sorted={}self:SetDirty(true)
end

function PANEL:AddColumn(a,b)local c=nil;if self.m_bSortable then c=vgui.Create("PartyListView_Column",self)else c=vgui.Create("DListView_ColumnPlain",self)end;c:SetName(a)c:SetZPos(10)if b then table.insert(self.Columns,b,c)for d=1,#self.Columns do self.Columns[d]:SetColumnID(d)end else local e=table.insert(self.Columns,c)c:SetColumnID(e)end;self:InvalidateLayout()return c end
function PANEL:AddLine(...)self:SetDirty(true)self:InvalidateLayout()local a=vgui.Create("PartyListView_Line",self.pnlCanvas)local b=table.insert(self.Lines,a)a:SetListView(self)a:SetID(b)for c,d in pairs(self.Columns)do a:SetColumnText(c,"")end;for c,d in pairs({...})do a:SetColumnText(c,d)end;local e=table.insert(self.Sorted,a)if e%2==1 then a:SetAltLine(true)end;for f,g in pairs(a.Columns)do g:SetFont("roboto16")end;return a end

function PANEL:RemoveLine(LineID)
	local a=self:GetLine(LineID)local b=self:GetSortedID(LineID)self.Lines[LineID]=nil;table.remove(self.Sorted,b)self:SetDirty(true)self:InvalidateLayout()a:Remove()

	local newlines = {}
	local i = 0
	for _i,v in pairs(self:GetLines()) do
		if (not IsValid(v)) then continue end
		i = i + 1
		newlines[i] = v
		v:SetID(i)
	end
	self.Lines = newlines
end

derma.DefineControl("PartyListView",nil,PANEL,"DListView")