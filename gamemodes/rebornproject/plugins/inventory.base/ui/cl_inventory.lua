FLIP_ICON_RENDER_QUEUE = FLIP_ICON_RENDER_QUEUE or {}

local function GetIconCamFlipping(width, height, iconCam)
	local ang, fov = iconCam.ang, iconCam.fov
	ang = Angle(ang.p, ang.y, ang.r - 90)
	fov = fov * (width / height)

	return ang, fov
end

local function RenderNewIcon(panel, itemTable)
	local bFLip = itemTable.data["flip"]
	local model = itemTable:GetModel()
	model = string.lower(model)

	-- re-render icons
	if (itemTable.iconCam and
		((!ICON_RENDER_QUEUE[model] and !bFLip or
		!FLIP_ICON_RENDER_QUEUE[model] and bFLip) or
		itemTable.forceRender)
	) then
		local iconCam = itemTable.iconCam
		local ang, fov = iconCam.ang, iconCam.fov

		if (bFLip) then
			ang, fov = GetIconCamFlipping(itemTable.width, itemTable.height, iconCam)
		end

		iconCam = {
			cam_pos = iconCam.pos,
			cam_ang = ang,
			cam_fov = fov,
		}

		if (!bFLip) then
			ICON_RENDER_QUEUE[model] = true
		else
			FLIP_ICON_RENDER_QUEUE[model] = true
		end

		panel.Icon:RebuildSpawnIconEx(iconCam)
	end
end

local function Scale(size)
	return ScrH() / 1080 * size
end

local PANEL = vgui.GetControlTable("ixItemIcon")

function PANEL:Move(newX, newY, givenInventory, bNoSend)
	local iconSize = givenInventory.iconSize
	local oldX, oldY = self.gridX, self.gridY
	local oldParent = self:GetParent()

	if (givenInventory:OnTransfer(oldX, oldY, newX, newY, oldParent, bNoSend) == false) then
		return
	end

	self.gridX = newX
	self.gridY = newY

	self:SetParent(givenInventory)
	self:SetPos(givenInventory.slots[self.gridX][self.gridY]:GetPos())

	if (self.slots) then
		for _, v in ipairs(self.slots) do
			if (IsValid(v) and v.item == self) then
				v.item = nil
			end
		end
	end

	self.slots = {}

	for currentX = 1, self.gridW do
		for currentY = 1, self.gridH do
			local slot = givenInventory.slots[self.gridX + currentX - 1][self.gridY + currentY - 1]

			slot.item = self
			self.slots[#self.slots + 1] = slot
		end
	end
end

vgui.Register("ixItemIcon", PANEL, "SpawnIcon")

local PANEL = vgui.GetControlTable("ixInventoryOR")

function PANEL:Init()
	self:SetIconSize(Scale(64))


	self:Receiver("ixInventoryItem", self.ReceiveDrop)
	self:DockMargin(1, 1, 0, 0)

	self.panels = {}

	local parent = self

	while (true) do
		local nextParent = parent:GetParent()

		if (nextParent:GetName() == "GModBase") then
			break
		end

		parent = nextParent
	end

	function parent:OnKeyCodePressed(keyCode)
		local baseClass = baseclass.Get(self:GetName())

		if (baseClass.OnKeyCodePressed) then
			baseClass.OnKeyCodePressed(self, keyCode)
		end

		if (keyCode == KEY_SPACE) then
			local hoveredPanel = vgui.GetHoveredPanel()

			if (hoveredPanel.GetName and hoveredPanel:GetName() == "ixItemIcon") then
				local itemTable = hoveredPanel.itemTable

				if (itemTable.width != itemTable.height) then
					net.Start("ixInventoryFlipItem")
						net.WriteUInt(itemTable.id, 32)
						net.WriteUInt(hoveredPanel.inventoryID, 32)
					net.SendToServer()
				end
			end
		end
	end
end


function PANEL:AddIcon(model, x, y, w, h, skin)
	local iconSize = self.iconSize

	w = w or 1
	h = h or 1

	if (self.slots[x] and self.slots[x][y]) then
		local panel = self:Add("ixItemIcon")
		panel:SetSize(w * iconSize, h * iconSize)
		panel:SetZPos(999)
		panel:InvalidateLayout(true)
		panel:SetModel(model, skin)
		panel:SetPos(self.slots[x][y]:GetPos())
		panel.gridX = x
		panel.gridY = y
		panel.gridW = w
		panel.gridH = h

		local inventory = ix.item.inventories[self.invID]

		if (!inventory) then
			return
		end

		local itemTable = inventory:GetItemAt(panel.gridX, panel.gridY)

		if (!itemTable or !itemTable.GetID) then
			panel:Remove()

			return
		end

		panel:SetInventoryID(inventory:GetID())
		panel:SetItemTable(itemTable)

		if (self.panels[itemTable:GetID()]) then
			self.panels[itemTable:GetID()]:Remove()
		end

		if (itemTable.exRender) then
			local iconName = itemTable.uniqueID
			if (itemTable.data["flip"]) then
				iconName = iconName .. "_flipped"
			end

			panel.Icon:SetVisible(false)
			panel.ExtraPaint = function(this, panelX, panelY)
				local exIcon = ikon:GetIcon(iconName)

				if (exIcon) then
					surface.SetMaterial(exIcon)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(0, 0, panelX, panelY)
				else
					local iconCam = itemTable.iconCam

					if (itemTable.data["flip"]) then
						iconCam.ang, iconCam.fov = GetIconCamFlipping(itemTable.width, itemTable.height, iconCam)
					end

					ikon:renderIcon(
						iconName,
						itemTable.width,
						itemTable.height,
						itemTable:GetModel(),
						iconCam
					)
				end
			end
		else
			-- yeah..
			RenderNewIcon(panel, itemTable)
		end

		panel.slots = {}

		for i = 0, w - 1 do
			for i2 = 0, h - 1 do
				local slot = self.slots[x + i] and self.slots[x + i][y + i2]

				if (IsValid(slot)) then
					slot.item = panel
					panel.slots[#panel.slots + 1] = slot
				else
					for _, v in ipairs(panel.slots) do
						v.item = nil
					end

					panel:Remove()

					return
				end
			end
		end

		return panel
	end
end


function PANEL:PerformLayout(width, height)
	if (self.Sizing and self.gridW and self.gridH) then
		local newWidth = (width - Scale(8)) / self.gridW
		local newHeight = (height - Scale(self:GetPadding(2) + self:GetPadding(4))) / self.gridH

		self:SetIconSize((newWidth + newHeight) / 2)
		self:RebuildItems()
	end
end

function PANEL:SetGridSize(w, h)
	local iconSize = self.iconSize
	local newWidth = w * iconSize + Scale(8)
	local newHeight = h * iconSize + Scale(self:GetPadding(2) + self:GetPadding(4))

	self.gridW = w
	self.gridH = h

	self:SetSize(newWidth, newHeight)
	self:BuildSlots()
end

function PANEL:BuildSlots()
	local iconSize = self.iconSize

	self.slots = self.slots or {}

	for _, v in ipairs(self.slots) do
		for _, v2 in ipairs(v) do
			v2:Remove()
		end
	end

	self.slots = {}

	for x = 1, self.gridW do
		self.slots[x] = {}

		for y = 1, self.gridH do
			local slot = self:Add("DPanel")
			slot:SetZPos(-999)
			slot.gridX = x
			slot.gridY = y
			slot:SetPos((x - 1) * iconSize + Scale(self:GetDock(1)), (y - 1) * iconSize + Scale(self:GetDock(2)))
			slot:SetSize(iconSize, iconSize)
			slot.Paint = function(_, w, h)
				surface.SetDrawColor(53, 53, 53, 102)
				surface.DrawRect(1, 1, w - 2, h - 2)

				surface.SetDrawColor(0, 0, 0)
				surface.DrawOutlinedRect(1, 1, w - 2, h - 2, 1)
			end

			self.slots[x][y] = slot
		end
	end
end

function PANEL:OnTransfer(oldX, oldY, x, y, oldInventory, noSend)
	local inventories = ix.item.inventories
	local inventory = inventories[oldInventory.invID]
	local inventory2 = inventories[self.invID]
	local item

	if (inventory) then
		item = inventory:GetItemAt(oldX, oldY)

		if (!item) then
			return false
		end

		if (hook.Run("CanTransferItem", item, inventories[oldInventory.invID], inventories[self.invID]) == false) then
			return false, "notAllowed"
		end

		if (item.CanTransfer and
			item:CanTransfer(inventory, inventory != inventory2 and inventory2 or nil) == false) then
			return false
		end

		hook.Run("OnItemTransferred2", item, inventory, inventory2)
	end

	if (!noSend) then
		net.Start("ixInventoryMove")
			net.WriteUInt(oldX, 6)
			net.WriteUInt(oldY, 6)
			net.WriteUInt(x, 6)
			net.WriteUInt(y, 6)
			net.WriteUInt(oldInventory.invID, 32)
			net.WriteUInt(self != oldInventory and self.invID or oldInventory.invID, 32)
		net.SendToServer()
	end

	if (inventory) then
		inventory.slots[oldX][oldY] = nil
	end

	if (item and inventory2) then
		inventory2.slots[x] = inventory2.slots[x] or {}
		inventory2.slots[x][y] = item
	end
end

--PANEL.OldSetInventory = PANEL.OldSetInventory or PANEL.SetInventory
--
--function PANEL:SetInventory(inventory, bFitParent)
--	self:OldSetInventory(inventory, bFitParent)
--	if inventory.vars and inventory.vars.isBag then
--		hook.Run("BagOpened", self, inventory)
--	end
--end

vgui.Register("ixInventoryOR", PANEL, "EditablePanel")

local PANEL = {}

local invBars = {
	{
		icon = "https://i.imgur.com/qHyP0Y5.png",
		col = Color(39, 174, 96),
		get = function(ply)
			return (1 - ply:GetHungerPercent())
		end,
		iconW = 23,
		iconH = 23
	},
	{
		icon = "https://i.imgur.com/yOBKws2.png",
		col = Color(41, 128, 185),
		get = function(ply)
			return (1 - ply:GetThirstPercent())
		end,
		iconW = 31,
		iconH = 27
	}
}

local DownloadIcon = PLUGIN.DownloadIcon
local white = Color(255, 255, 255)

function PANEL:Init()
	local ply = LocalPlayer()
	self:Dock(FILL)

	local subinventory = setmetatable({}, {__call = function(self, name, parent)
		local inventory = rawget(self, name)
		if inventory == nil then return {Dock = function() end} end
		local inv = parent:Add("ixInventoryOR")
		inv.childPanels = {}
		inv:SetInventory(inventory)
		ix.gui["inv".. inventory:GetID()] = inv
		return inv, inventory
	end})

	for _, inventory in ipairs(ply:GetCharacter().vars.inv) do
		if inventory.vars.inventoryType then
			subinventory[inventory.vars.inventoryType] = inventory
		end
	end
--[[
	Panel:PaintAt(x, y)

	local matrix = Matrix()

	matrix:Scale(Vector(1, 1))
	matrix:Translate(Vector(
		0,
		0.2,
		1
	))

	cam.PushModelMatrix(matrix)
	cam.PopModelMatrix()
]]--
	local right = self:Add("EditablePanel")
	right:Dock(RIGHT)

	local invBackground = right:Add("EditablePanel")
	invBackground:SetSize(Scale(386), Scale(286))
	invBackground.Paint = function(me, w, h)
		surface.SetDrawColor(37, 37, 37, 153)
		surface.DrawRect(0, 0, w, h)
	end
	invBackground:Dock(TOP)
	invBackground:DockPadding(Scale(3), Scale(2), Scale(0), Scale(2))

	local inv = invBackground:Add("ixInventoryOR")
	inv.childPanels = {}

	local inventory = LocalPlayer():GetCharacter():GetInventory()

	if inventory then
		inv:SetInventory(inventory)
	end

	inv:Dock(TOP)
	ix.gui.inv1 = inv

	right:SetWide(inv:GetWide())

	local extra_inv = invBackground:Add("EditablePanel")
	extra_inv:Dock(TOP)
	extra_inv:SetTall(0)
	-- extra_inv.Paint = function(me, w, h)
	-- 	surface.SetDrawColor(255, 0, 0, 50)
	-- 	surface.DrawRect(0, 0, w, h)
	-- end
	extra_inv.OnChildAdded = function(this, inv)
		local old = inv.PerformLayout
		inv.PerformLayout = function(me, w, h)
			old(me, w, h)
			if IsValid(this) == false then return end

			local h = 0
			for _, inv in ipairs(this:GetChildren()) do
				h = h + inv:GetTall()
			end

			this:SetTall(h)
			invBackground:SetTall(Scale(286) + h)
		end
		inv:InvalidateLayout(true)
		inv.OnRemove = function(me)
			if IsValid(this) == false then return end

			local h = 0
			for _, inv in ipairs(this:GetChildren()) do
				if me ~= inv then
					h = h + inv:GetTall()
				end
			end

			this:SetTall(h)
			invBackground:SetTall(Scale(286) + h)
		end
	end

	hook.Add("BagOpened", self, function(_, inv, inventory, bag)
		
		local is_bag = ix.item.inventories[(bag or inv).invID].vars.inventoryType == "bag"
		inv:SetParent(extra_inv)
		inv:Dock(TOP)
		inv:SetZPos(is_bag and 1 or 2)
		inv:SetPaintedManually(true)

		local slots_col = is_bag and Color(85, 141, 0, 30) or Color(141, 85, 0, 30)

		for x = 1, inv.gridW do
			for y = 1, inv.gridH do
				inv.slots[x][y].Paint = function(_, w, h)
					surface.SetDrawColor(slots_col)
					surface.DrawRect(1, 1, w - 2, h - 2)

					surface.SetDrawColor(0, 0, 0)
					surface.DrawOutlinedRect(1, 1, w - 2, h - 2, 1)
				end
			end
		end

		timer.Simple(0, function()
			if IsValid(inv) then
				inv:SetParent(extra_inv)
			end
		end)
	end)

	local inv_bar = invBackground:Add("EditablePanel")
	inv_bar:Dock(TOP)
	inv_bar:SetTall(Scale(24))
	inv_bar:DockMargin(Scale(2), 0, Scale(5), 0)
	inv_bar.Paint = function(me, w, h)
		local weight = LocalPlayer():GetWeight()
		local maxWeight = ix.config.Get("maxWeight") + LocalPlayer():GetWeightAddition()
		local weightPercentage = math.Clamp(weight / maxWeight, 0, 1)

		draw.RoundedBox(0, 0, 0, w * weightPercentage, h, Color(255 * weightPercentage, 255 * (1 - weightPercentage), 0, 255))


		draw.SimpleText("Общий вес: "..weight.." (max: "..maxWeight..")", "StalkerUI-400-16", w * .28, h * .1, Color(180, 180, 180, 255), TEXT_ALIGN_LEFT)
		surface.SetDrawColor(53, 53, 53, 102)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local bars = right:Add("EditablePanel")
	bars:Dock(TOP)
	bars:SetTall(Scale(12) + #invBars * Scale(28))
	bars.Paint = function(me, w, h)
		surface.SetDrawColor(37, 37, 37, 153)
		surface.DrawRect(0, 0, w, h)
	end
	bars:DockPadding(Scale(5), Scale(6), Scale(5), Scale(6))

	for i, cfg in ipairs(invBars) do
		local bar = bars:Add("EditablePanel")
		bar:SetTall(Scale(28))
		bar:Dock(TOP)

		bar.icon = bar:Add("EditablePanel")
		bar.icon:Dock(LEFT)
		bar.icon:SetWide(Scale(28))
		DownloadIcon(cfg.icon, function(ico)
			bar.icon.Paint = function(_, w, h)
				surface.SetDrawColor(255, 255, 255)
				surface.SetMaterial(ico)
				surface.DrawTexturedRect(w * 0.5 - cfg.iconW * 0.5, h * 0.5 - cfg.iconH * 0.5, cfg.iconW, cfg.iconH)
			end
		end)

		bar.bar = bar:Add("EditablePanel")
		bar.bar:Dock(FILL)
		bar.bar:DockMargin(8, 6, 0, 6)
		bar.bar.Paint = function(_, w, h)
			surface.SetDrawColor(30, 30, 30, 120)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(cfg.col)
			surface.DrawRect(0, 0, w * cfg.get(ply), h)
		end
	end

	local equip = right:Add("EditablePanel")
	equip:Dock(TOP)
	equip:SetTall(Scale(158))
	equip.Paint = function(_, w, h)
		surface.SetDrawColor(37, 37, 37, 153)
		surface.DrawRect(0, 0, w, h)
	end

	local function MakeTitle(text, x)
		local title = equip:Add("EditablePanel")
		title:SetPos(x, Scale(2))
		title:SetSize(Scale(126), Scale(24))
		title.Paint = function(_, w, h)
			surface.SetDrawColor(53, 53, 53, 102)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 0)
			surface.DrawOutlinedRect(0, 0, w, h, 1)

			draw.SimpleText(text, "StalkerUI-400-16", w * 0.5, h * 0.5, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	local function MakeWeaponSlot(slot_name, icon, x, y, h, iconAspectRatio, icoH)
		local slot = equip:Add("EditablePanel")
		slot:SetPos(x, Scale(30) + (y or 0))
		slot:SetSize(Scale(126), h or Scale(126))
		DownloadIcon(icon, function(ico)
			slot.Paint = function(_, w, h)
				surface.SetDrawColor(53, 53, 53, 102)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(0, 0, 0)
				surface.DrawOutlinedRect(0, 0, w, h, 1)

				surface.SetDrawColor(255, 255, 255)
				surface.SetMaterial(ico)
				if iconAspectRatio then
					local iW = (icoH or h) * iconAspectRatio
					surface.DrawTexturedRect(w * 0.5 - iW * 0.5, 0, iW, h)
				else
					surface.DrawTexturedRect(0, 0, w, h)
				end
			end
		end)

		local inv = subinventory(slot_name, slot)
		inv:Dock(FILL)

		if inv.gridW == nil then return end

		for x = 1, inv.gridW do
			for y = 1, inv.gridH do
				inv.slots[x][y].Paint = function(_, w, h)

				end
			end
		end
	end

	MakeTitle("Основное", Scale(4))
	MakeWeaponSlot("weapon_primary", "https://i.imgur.com/918RMoS.png", Scale(4))

	MakeTitle("Дополнительное", Scale(132))
	MakeWeaponSlot("weapon_secondary", "https://i.imgur.com/mb8wUXD.png", Scale(132))

	MakeTitle("Вторичное", Scale(260))
	MakeWeaponSlot("weapon_pistol", "https://i.imgur.com/2Z0MQcD.png", Scale(260), Scale(0), Scale(62), Scale(85 / 62))
	MakeWeaponSlot("weapon_knife", "https://i.imgur.com/fmLrHI0.png", Scale(260), Scale(64), Scale(62), Scale(119 / 115), Scale(120))

	local equip = self:Add("EditablePanel")
	equip:Dock(FILL)
	equip:DockMargin(0, 0, Scale(42), 0)
	DownloadIcon("https://i.imgur.com/XNPLzLL.png", function(person)
		equip.Paint = function(me, w, h)
			surface.SetDrawColor(255, 255, 255)
			surface.SetMaterial(person)
			surface.DrawTexturedRect(me:ScreenToLocal(me.top:LocalToScreen(me.top:GetWide() * 0.5, 0), 0) - Scale(111), 0, Scale(222), Scale(611))
		end
	end)

	local equip_head = equip:Add("EditablePanel")
	equip_head:Dock(TOP)
	equip_head:SetTall(Scale(66))
	equip_head:DockMargin(0, 0, Scale(20), 0)

	local equip_top_slots = equip_head:Add("EditablePanel")
	equip.top = equip_top_slots
	equip_top_slots:Dock(RIGHT)
	equip_top_slots:SetWide(Scale(326))
	local mask_ico, gasmask_ico, head_balaclava, head_glasses
	DownloadIcon("https://i.imgur.com/PzqZPwg.png", function(ico)
		mask_ico = ico
	end)

	DownloadIcon("https://i.imgur.com/e4gPbqP.png", function(ico)
		gasmask_ico = ico
	end)
	DownloadIcon("https://i.imgur.com/ofVwndD.png", function(ico)
		head_balaclava = ico
	end)
	DownloadIcon("https://i.imgur.com/GUkr28Q.png", function(ico)
		head_glasses = ico
	end)
	equip_top_slots.Paint = function(me, w, h)
		surface.SetDrawColor(37, 37, 37, 76)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(255, 255, 255)
		if head_balaclava then
			surface.SetMaterial(head_balaclava)
			surface.DrawTexturedRect(Scale(8), 0, Scale(47), Scale(62))
		end
		if mask_ico then
			surface.SetMaterial(mask_ico)
			surface.DrawTexturedRect(Scale(68), Scale(2), Scale(63), Scale(58))
		end
		if gasmask_ico then
			surface.SetMaterial(gasmask_ico)
			surface.DrawTexturedRect(Scale(200), Scale(6), Scale(56), Scale(54))
		end
		if head_glasses then
			surface.SetMaterial(head_glasses)
			surface.DrawTexturedRect(Scale(268), Scale(23), Scale(50), Scale(19))
		end

		surface.SetDrawColor(141, 85, 0)
		local size = Scale(66)
		for x = 0, w, size - 1 do
			surface.DrawOutlinedRect(x, 0, size, size)
		end
	end
	equip_top_slots.AddInv = function(me, name)
		local inv = subinventory(name, me)
		inv:Dock(LEFT)
		timer.Simple(0, function()
			if IsValid(inv) then
				inv:SetWide(Scale(64))
			end
		end)
		--inv.Paint = function(me, w, h)
		--	surface.SetDrawColor(255, 0, 0, 50)
		--	surface.DrawOutlinedRect(0, 0, w, h)
		--end
	end

	equip_top_slots:AddInv("head_balaclava")
	equip_top_slots:AddInv("head_mask")
		--local spacer = equip_top_slots:Add("DPanel")
		--spacer:SetWide(Scale(66))
		--spacer:Dock(LEFT)
		equip_top_slots:AddInv("helmet")
	equip_top_slots:AddInv("head_gasmask")
	equip_top_slots:AddInv("head_glasses")

	local parent = equip:Add("EditablePanel")
	parent:Dock(TOP)
	parent:SetTall(ScrH())

	local equip_right = parent:Add("EditablePanel")
	equip_right:Dock(RIGHT)
	equip_right:DockMargin(0, Scale(40), 0, 0)
	equip_right:SetWide(Scale(67))

	equip_right_slots = equip_right:Add("EditablePanel")
	equip_right_slots:Dock(TOP)
	equip_right_slots:SetTall(Scale(325)) --325 old
--	local radio_ico, pda_ico, pnv_ico, dynamo_ico, armband_ico
	local radio_ico, armband_ico, pnv_ico, dynamo_ico, patch_ico
	DownloadIcon("https://i.imgur.com/AwIrCiy.png", function(ico)
		radio_ico = ico
	end)

	-- DownloadIcon("https://i.imgur.com/F7ETJ1F.png", function(ico)
	-- 	pda_ico = ico
	-- end)

	DownloadIcon("https://i.imgur.com/F7ETJ1F.png", function(ico)
		armband_ico = ico
	end)

	DownloadIcon("https://i.imgur.com/pIU1R8d.png", function(ico)
		pnv_ico = ico
	end)

	DownloadIcon("https://i.imgur.com/eIolSVu.png", function(ico)
		dynamo_ico = ico
	end)

	DownloadIcon("https://i.imgur.com/bz85yzz.png", function(ico)
		patch_ico = ico
	end)

	equip_right_slots.Paint = function(me, w, h)
		surface.SetDrawColor(37, 37, 37, 76)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(255, 255, 255)
		if radio_ico then
			surface.SetMaterial(radio_ico)
			surface.DrawTexturedRect(Scale(2), Scale(2), Scale(62), Scale(62))
		end
		if armband_ico then
			surface.SetMaterial(armband_ico)
			surface.DrawTexturedRect(w * 0.5 - Scale(49 * 0.5), Scale(63 + 66 * 0.5 - 39 * 0.5), Scale(50), Scale(50))
		end
		-- if pda_ico then
		-- 	surface.SetMaterial(pda_ico)
		-- 	surface.DrawTexturedRect(w * 0.5 - Scale(49 * 0.5), Scale(63 + 66 * 0.5 - 39 * 0.5), Scale(49), Scale(39))
		-- end
		if pnv_ico then
			surface.SetMaterial(pnv_ico)
			surface.DrawTexturedRect(w * 0.5 - Scale(58 * 0.5), Scale(130 + 66 * 0.5 - 45 * 0.5), Scale(58), Scale(45))
		end
		if dynamo_ico then
			surface.SetMaterial(dynamo_ico)
			surface.DrawTexturedRect(w * 0.5 - Scale(46 * 0.5), Scale(196 + 66 * 0.5 - 51 * 0.5), Scale(46), Scale(51))
		end
		if patch_ico then
			surface.SetMaterial(patch_ico)
			surface.DrawTexturedRect(w * 0.5 - Scale(54 * 0.5), Scale(256 + 66 * 0.5 - 51 * 0.5), Scale(56), Scale(51))
		end

		surface.SetDrawColor(141, 85, 0)
		surface.DrawOutlinedRect(0, 0, w, Scale(130))
		surface.DrawOutlinedRect(0, Scale(130), w, Scale(129))
		surface.DrawOutlinedRect(0, Scale(190), w, Scale(192))
	end
	subinventory("radio", equip_right_slots):Dock(TOP)
	subinventory("armband", equip_right_slots):Dock(TOP)
	--subinventory("pda", equip_right_slots):Dock(TOP)
	subinventory("pnv", equip_right_slots):Dock(TOP)
	subinventory("dynamo", equip_right_slots):Dock(TOP)
	subinventory("patch", equip_right_slots):Dock(TOP)

	local equip_center = parent:Add("EditablePanel")
	equip_center:Dock(RIGHT)
	equip_center:SetWide(Scale(235))
	equip_center:DockMargin(0, 0, 0, 0)


	local equip_center_body = equip_center:Add("EditablePanel")
	equip_center_body:Dock(TOP)
	--local margin = (equip_center:GetWide() - Scale(130)) / 2
	--equip_center_body:DockMargin(Scale(53), Scale(40), Scale(50), 0)
	equip_center_body:DockMargin(0, Scale(40), 0, 0)
	equip_center_body:SetTall(194)

	local equip_armor = equip_center_body:Add("EditablePanel")
	equip_armor:SetWide(Scale(130))
	equip_armor:Dock(RIGHT)
	equip_armor:DockMargin(0, 0, Scale(50), 0)

	local equip_armor_2 = equip_armor:Add("EditablePanel")
	--equip_armor_2:DockPadding(Scale(2), Scale(2), Scale(2), Scale(2))
	equip_armor_2.Paint = function(me, w, h)
		surface.SetDrawColor(37, 37, 37, 76)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(141, 85, 0)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local armor_inv = subinventory("armor", equip_armor_2)
	if IsValid(armor_inv) then
		armor_inv.x = Scale(8)
		equip_armor_2:SetSize(armor_inv:GetWide(), armor_inv:GetTall())
		equip_armor_2.x = equip_armor:GetWide() - equip_armor_2:GetWide()
	end

	local equip_legs = equip_center:Add("EditablePanel")
	equip_legs:Dock(TOP)
	equip_legs:DockMargin(0, Scale(231), 0, 0)
	equip_legs:SetTall(Scale(66))

	local equip_legs2 = equip_legs:Add("EditablePanel")
	equip_legs2:SetSize(Scale(66), Scale(66))
	equip_legs2.x = equip_center:GetWide() * 0.5 - equip_legs2:GetWide() * 0.5
	equip_legs2.Paint = function(me, w, h)
		surface.SetDrawColor(37, 37, 37, 76)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(141, 85, 0)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	subinventory("legs", equip_legs2):Dock(FILL)

	local equip_left = parent:Add("EditablePanel")
	equip_left:Dock(RIGHT)
	equip_left:SetWide(Scale(130))
	equip_left:DockMargin(0, Scale(40), 0, 0)

	equip_left_slots = equip_left:Add("EditablePanel")
	equip_left_slots:Dock(TOP)
	equip_left_slots:SetTall(Scale(264))
	local bag_ico, unload_ico
	DownloadIcon("https://i.imgur.com/Y5MTECt.png", function(ico)
		bag_ico = ico
	end)
	DownloadIcon("https://i.imgur.com/R0PMtaY.png", function(ico)
		unload_ico = ico
	end)
	equip_left_slots.Paint = function(me, w, h)
		surface.SetDrawColor(37, 37, 37, 76)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(255, 255, 255)
		if bag_ico then
			surface.SetMaterial(bag_ico)
			surface.DrawTexturedRect(w * 0.5 - Scale(53.5), Scale(11.5), Scale(107), Scale(107))
		end
		if unload_ico then
			surface.SetMaterial(unload_ico)
			surface.DrawTexturedRect(w * 0.5 - Scale(53.5), Scale(141.5), Scale(107), Scale(107))
		end

		surface.SetDrawColor(141, 85, 0)
		surface.DrawOutlinedRect(0, 0, Scale(130), Scale(130))
		surface.DrawOutlinedRect(0, Scale(129), Scale(130), Scale(130))
	end
	equip_left_slots.OpenBag = function(me, inv)
		local items = inv.slots
		if items[1] and items[1][1] then
			local item = items[1][1]
			local base = ix.item.base[item.base]
			if base.isBag then
				base.functions.View.OnClick(item)
			end
			return true
		end
	end
	equip_left_slots.AddInv = function(me, name)
		local pnl, inv = subinventory(name, me)
		pnl:Dock(TOP)
		if inv then
			me:OpenBag(inv)
		end
		return pnl
	end

	hook.Add("OnItemTransferred2", equip_left_slots, function(me, item, curInv, inventory)
		if inventory.vars and inventory.vars.inventoryType then
			--me:OpenBag(inventory)
			timer.Simple(0, function()
				local base = ix.item.base[item.base]
				if base and base.isBag then
					base.functions.View.OnClick(item)
				end
			end)
		end
	end)

	equip_left_slots:AddInv("bag")
	equip_left_slots:AddInv("unloading")

	
	---QUICK SLOTS---
	local quickslotspanel = self:Add("EditablePanel")
	quickslotspanel:SetPos(Scale(110), Scale(365))
	quickslotspanel:SetSize(Scale(285), Scale(65))

	local htf1, htf2, htf3, htf4

	DownloadIcon("https://i.imgur.com/52XdMO7.png", function(ico)
		htf1 = ico
	end)
	DownloadIcon("https://i.imgur.com/Eqqzfcg.png", function(ico)
		htf2 = ico
	end)
	DownloadIcon("https://i.imgur.com/VpbXQVQ.png", function(ico)
		htf3 = ico
	end)
	DownloadIcon("https://i.imgur.com/ZckU4RX.png", function(ico)
		htf4 = ico
	end)

	quickslotspanel.Paint = function(this, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(37, 37, 37, 0))

		surface.SetDrawColor(141, 85, 0)
		if htf1 then
			surface.SetMaterial(htf1)
			surface.DrawTexturedRect(w * .01, h *.05, Scale(60), Scale(60))
		end

		if htf2 then
			surface.SetMaterial(htf2)
			surface.DrawTexturedRect(w * .27, h *.05, Scale(60), Scale(60))
		end

		if htf3 then
			surface.SetMaterial(htf3)
			surface.DrawTexturedRect(w * .52, h *.05, Scale(60), Scale(60))
		end

		if htf4 then
			surface.SetMaterial(htf4)
			surface.DrawTexturedRect(w * .78, h *.05, Scale(60), Scale(60))
		end

		surface.SetDrawColor(141, 85, 0)
		surface.DrawOutlinedRect(0, 0, w, Scale(65))
	end

	subinventory("hotkey_f1", quickslotspanel):Dock(LEFT)
	subinventory("hotkey_f2", quickslotspanel):Dock(LEFT)
	subinventory("hotkey_f3", quickslotspanel):Dock(LEFT)
	subinventory("hotkey_f4", quickslotspanel):Dock(LEFT)
end

vgui.Register("StalkerInventory", PANEL, "EditablePanel")