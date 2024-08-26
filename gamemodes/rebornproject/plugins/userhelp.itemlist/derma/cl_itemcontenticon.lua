
local PANEL = {}
DEFINE_BASECLASS("ContentIcon")

function PANEL:Init()
	self.icon = self:Add("SpawnIcon")
	self.icon:SetSize(92, 92)
	self.icon:SetPos(16, 4)
	self.icon.DoClick = function(panel)
		self:DoClick()
	end
	self.icon.OpenMenu = function(panel)
		self:OpenMenu()
	end

	self.icon.PaintOver = nil
end

function PANEL:SetItemTable(itemTable)
	self.itemTable = itemTable
end

function PANEL:SetModel(path)
	self.icon:SetModel(path)
end

function PANEL:DoClick()
	net.Start("MenuItemSpawn")
		net.WriteString(self.itemTable.uniqueID)
	net.SendToServer()

	surface.PlaySound("ui/buttonclickrelease.wav")
end

function PANEL:OpenMenu()
	local menu = DermaMenu()

	menu:AddOption("Скопировать в буфер обмена", function()
		SetClipboardText(self.itemTable.uniqueID)
	end)

	menu:AddOption("Выдать себе", function()
		net.Start("MenuItemGive")
			net.WriteString(self.itemTable.uniqueID)
		net.SendToServer()
	end)

	menu:Open()
end

vgui.Register("ixItemContentIcon", PANEL, "ContentIcon")