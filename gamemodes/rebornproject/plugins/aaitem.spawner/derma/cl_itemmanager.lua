
local PLUGIN = PLUGIN

local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrH() * .5, ScrH() * .5)
	self:Center()
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)
	self:MakePopup()
	self:SetTitle("Item Spawn Manager")

	self.container = vgui.Create("DScrollPanel", self)
	self.container:Dock(FILL)

end

function PANEL:Populate(items)
	self.index = {}

	for index, item in ipairs(items) do
		self.index = self.container:Add("DPanel")
		self.index:Dock(TOP)
		self.index:SetHeight(64)
		self.index:DockMargin(20, 20, 20, 0)

		self.index.leftPanel = self.index:Add("DPanel")
		self.index.leftPanel:Dock(LEFT)
		self.index.leftPanel:SetSize(300, 0)

		self.index.title = self.index.leftPanel:Add("DLabel")
		self.index.title:SetText(item.category)
		self.index.title:Dock(TOP)
		self.index.title:DockMargin(10, 10, 0, 0)
		self.index.title:SetFont("ixMediumFont")
		self.index.title:SetColor(ix.config.Get("color", Color(255,255,255)))

		self.index.update = self.index.leftPanel:Add("DLabel")
		self.index.update:SetText("Delay: "..item.delay)
		self.index.update:Dock(TOP)
		self.index.update:SetFont("ixGenericFont")
		self.index.update:DockMargin(10, 10, 0, 0)

		self.index.avatar = vgui.Create("AvatarImage", self.index)
		self.index.avatar:SetSize(64, 64)
		self.index.avatar:Dock(RIGHT)
		self.index.avatar:SetSteamID(item.author, 64)

		self.index.delete = vgui.Create("DButton", self.index)
		self.index.delete:Dock(RIGHT)
		self.index.delete:SetText("Delete")
		self.index.delete.DoClick = function()
			net.Start("ixItemSpawnerDelete")
				net.WriteString(item.category)
			net.SendToServer()
			
			table.RemoveByValue(items, item) -- HARDCOOOOOOOOOOOOOOOOOOODE
			--self.index:Remove()
			timer.Simple(0.1, function()
				self.container:Clear()
				self:Populate(items)
			end)
		end
		self.index.delete.Paint = function(self, w, h)
		end

		self.index.teleport = vgui.Create("DButton", self.index)
		self.index.teleport:Dock(RIGHT)
		self.index.teleport:SetText("Goto")
		self.index.teleport.DoClick = function()
			net.Start("ixItemSpawnerGoto")
				net.WriteVector(item.position)
			net.SendToServer()
		end
		self.index.teleport.Paint = function(self, w, h)
		end

		self.index.spawn = vgui.Create("DButton", self.index)
		self.index.spawn:Dock(RIGHT)
		self.index.spawn:SetText("Spawn")
		self.index.spawn.DoClick = function()
			net.Start("ixItemSpawnerSpawn")
				net.WriteTable(item)
			net.SendToServer()
		end
		self.index.spawn.Paint = function(self, w, h)
		end
	end
end

vgui.Register("ixItemSpawnerManager", PANEL, "DFrame")