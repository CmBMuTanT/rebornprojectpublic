
PANEL = {}

local gradient = ix.util.GetMaterial("vgui/gradient-u")
function PANEL:Init()
    self:SetSize(ScrW(), ScrH())
    self:Center()
    self:MakePopup()
    self:SetCursor("blank")

    ix.gui.orbitable = self

    self.modelPanel = self:Add("ixOrbitableModelPanel")
    self.modelPanel:Dock(FILL)
    self.modelPanel.LayoutEntity = function(this, ent)
    end
    self.modelPanel:SetCursor("blank")
    self.modelPanel:SetFOV(70)

	self.name = self:Add("DLabel")
	self.name:SetSize(450, 50)
	self.name:SetContentAlignment(5)
	self.name:SetFont("ixMenuButtonFont")
	self.name:SetTextColor(color_white)
	self.name:SetText("Test name")
	self.name:SetPos(30, 30)
	self.name.Paint = function(this, w, h)
        surface.SetDrawColor(Color(44, 44, 44, 150))
        surface.DrawRect(0, 0, w, h)
	end

	self.descPanel = self:Add("DPanel")
	self.descPanel:SetSize(450, 250)
	self.descPanel:SetPos(30, 85)
	self.descPanel.Paint = function(this, w, h)
		-- derma.SkinFunc("DrawImportantBackground", 0, 0, w, h, Color(184, 121, 53, 255))
	end

	self.desc = self.descPanel:Add("DLabel")
	self.desc:Dock(FILL)
	self.desc:DockMargin(12, 12, 12, 12)
	self.desc:SetText("Test descasd fdas fdas fads fdsafdsafasdf descasd fdas fdas fads fdsafdsafasdf descasd fdas fdas fads fdsafdsafasdf")
	self.desc:SetFont("ixSmallFont")
	self.desc:SetWrap(true)
	self.desc:SetTextColor(color_white)
	self.desc:SetContentAlignment(7)

	self.spaceButton = self:Add("DLabel")
	self.spaceButton:SetPos(0, ScrH() - 100)
	self.spaceButton:DockMargin(10, 10, 10, 10)
	self.spaceButton:SetSize(ScrW(), 30)
	self.spaceButton:SetContentAlignment(5)
	self.spaceButton:SetText("TAB - Выйти из меню просмотра")
	self.spaceButton:SetFont("ixNoticeFont")
	self.spaceButton:SetTextColor(Color(207, 207, 207))

	self.rotateButton = self:Add("DLabel")
	self.rotateButton:SetPos(0, ScrH() - 130)
	self.rotateButton:DockMargin(10, 10, 10, 10)
	self.rotateButton:SetSize(ScrW(), 30)
	self.rotateButton:SetContentAlignment(5)
	self.rotateButton:SetText("КОЛЕСО МЫШИ - Приближать/отдалять объект")
	self.rotateButton:SetFont("ixNoticeFont")
	self.rotateButton:SetTextColor(Color(207, 207, 207))

	self.hideHUD = self:Add("DLabel")
	self.hideHUD:SetPos(0, ScrH() - 160)
	self.hideHUD:DockMargin(10, 10, 10, 10)
	self.hideHUD:SetSize(ScrW(), 30)
	self.hideHUD:SetContentAlignment(5)
	self.hideHUD:SetText("Е - Включить/выключить HUD")
	self.hideHUD:SetFont("ixNoticeFont")
	self.hideHUD:SetTextColor(Color(207, 207, 207))
end

function PANEL:Populate(itemID)
    local item = ix.item.list[itemID]

    local model = item.replacements or item:GetModel()
    self.modelPanel:SetModel(model)
    
    if item.color then
        self.modelPanel:SetColor(item.color)
    end
    
    local mins, maxs = self.modelPanel.Entity:GetModelBounds()
	local center = ( mins + maxs ) / 2

    self.modelPanel:SetCamPos(center - Vector(-50, 0, -15))
    self.modelPanel:SetLookAng((center - self.modelPanel:GetCamPos()):Angle())

    local bound1, bound2 = self.modelPanel.Entity:GetModelBounds()
    local distance = bound1:Distance(bound2)
    
    local fov = 60

    if distance > 70 then
        fov = 125
    end

    self.modelPanel:SetFOV(fov)

    self.name:SetText(item:GetName())
    self.desc:SetText(item:GetDescription())
end

function PANEL:OnKeyCodePressed(key)
    if key == KEY_E and self.name:IsVisible() then
        self.name:Hide()
        self.descPanel:Hide()
        self.desc:Hide()
        self.spaceButton:Hide()
        self.rotateButton:Hide()
        self.hideHUD:Hide()
    else
        self.name:Show()
        self.descPanel:Show()
        self.desc:Show()
        self.spaceButton:Show()
        self.rotateButton:Show()
        self.hideHUD:Show()
    end

    if key == KEY_TAB or key == KEY_SPACE or key == KEY_ENTER or key == KEY_ESCAPE then
        self:Remove()
    end
end

function PANEL:Paint(w, h)
    ix.util.DrawBlur(self, 5)
end

function PANEL:OnRemove()
    ix.gui.orbitable = nil
end

vgui.Register("ixREItemPopup", PANEL, "DPanel")