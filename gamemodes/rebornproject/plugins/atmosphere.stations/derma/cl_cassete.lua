
local PLUGIN = PLUGIN

local PANEL = {}

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

    local items = LocalPlayer():GetCharacter():GetInventory():GetItems()

	self:SetSize(512, 512)
	self:Center()
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)
	self:SetTitle("Список кассет")

    for k, v in pairs(items) do
        if v.cassete then
            self.list = self:Add("DButton")
            self.list:Dock(TOP)
            self.list:DockMargin(0, 4, 0, 0)
            self.list:SetSize( 36, 50 )
            self.list:SetText(v.name)
            self.list.DoClick = function(this)
                netstream.Start("ixMusicPlay", self.ent, v.music, v.uniqueID, 0)
                this:Remove()
            end
        end
    end

	self:MakePopup()

	PLUGIN.panel = self
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
end

vgui.Register("ixCassete", PANEL, "DFrame")
