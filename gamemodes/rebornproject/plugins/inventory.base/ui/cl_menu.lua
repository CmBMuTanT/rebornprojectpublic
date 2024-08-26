local Tabs = PLUGIN.Tabs
local Config = PLUGIN.Config
local DownloadIcon = PLUGIN.DownloadIcon

local textColor = Color(162, 71, 12)
local textColorBlur = Color(190, 81, 12, 150)

local function Scale(size)
	return ScrH() / 1080 * size
end

local smoke_mat
DownloadIcon("https://i.imgur.com/NSaLSm4.png", function(icon)
	smoke_mat = icon
end)

local money_mat
DownloadIcon("https://i.imgur.com/fA1trAA.png", function(icon)
	money_mat = icon
end)

surface.CreateFont("StalkerUI-400-27", {
	font = "Capture Smallz",
	size = ScreenScale(27 / 3),
	weight = 400,
	extended = true
})

surface.CreateFont("StalkerUI-400-27-blur", {
	font = "Capture Smallz",
	size = ScreenScale(27 / 3),
	weight = 500,
	extended = true,
	blursize = Scale(24 / 3),
	scanlines = 1
})

surface.CreateFont("StalkerUI-400-16", {
	font = "Capture Smallz",
	size = ScreenScale(16 / 3),
	weight = 400,
	extended = true
})

timer.Simple(0, function()

local animationTime = 0.65
local matrixZScale = Vector(1, 1, 0.0001)

DEFINE_BASECLASS("ixSubpanelParent")
local PANEL = {}

AccessorFunc(PANEL, "bCharacterOverview", "CharacterOverview", FORCE_BOOL)

function PANEL:Init()
	if (IsValid(ix.gui.menu)) then
		ix.gui.menu:Remove()
	end

	ix.gui.menu = self

	local ply = LocalPlayer()

	-- properties
	self.manualChildren = {}
	self.noAnchor = CurTime() + 0.4
	self.anchorMode = true
	self.rotationOffset = Angle(0, 180, 0)
	self.projectedTexturePosition = Vector(0, 0, 6)
	self.projectedTextureRotation = Angle(-45, 60, 0)

	self.bCharacterOverview = false
	self.bOverviewOut = false
	self.overviewFraction = 0

	self.currentAlpha = 0
	self.currentBlur = 0

	self:ShowBackground()

	local parallax = {x = 0, y = 0, speed = 3, range = -0.05}

	self.smoke = self:Add("EditablePanel")
	self.smoke:SetPaintedManually(true)
	self.smoke:Dock(FILL)
	self.smoke:DockPadding(195, 138, 195, 0) --138)
	self.smoke.Paint = function(me, w, h)
		local mX, mY = me:LocalCursorPos()
		mX = mX - w * 0.5
		mY = mY - h * 0.5

		parallax.x = Lerp(0.005 * parallax.speed, parallax.x, mX * parallax.range)
		parallax.y = Lerp(0.005 * parallax.speed, parallax.y, mY * parallax.range)

		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(smoke_mat)
		surface.DrawTexturedRect(parallax.x, parallax.y, w, h)
	end

	self.ammo = self.smoke:Add("DHorizontalScroller")
	self.ammo:SetTall(83)
	self.ammo:Dock(TOP)
	self.ammo:SetOverlap(-11)

	local iw, ih = 64, 64 --ico:Width(), ico:Height()
	local y = self.ammo:GetTall() * 0.5 - iw * 0.5

	for i, cfg in ipairs(Config.ammo) do
		local ico
		DownloadIcon(cfg.icon, function(icon)
			ico = icon
		end)

		local ammo = self.ammo:Add("EditablePanel")
		ammo:SetWide(162)
		--ammo:SetTooltip(cfg.name)
		ammo:SetHelixTooltip(function(tooltip)
			local title = tooltip:AddRow("name")
			title:SetImportant()
			title:SetText(cfg.name)
			title:SizeToContents()
			title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

			if cfg.desc == nil then return end

			local description = tooltip:AddRow("description")
			description:SetText(cfg.desc)
			description:SizeToContents()
		end)
		ammo.Paint = function(me, w, h)
			surface.SetDrawColor(0, 0, 0, me:IsHovered() and 150 or 102)
			surface.DrawRect(0, 0, w, h)

			if ico then
				surface.SetDrawColor(255, 255, 255)
				surface.SetMaterial(ico)
				surface.DrawTexturedRect(0, y, iw, ih)
			end

			draw.SimpleText(ply:GetAmmoCount(cfg.class), "StalkerUI-400-27", iw + 8, h * 0.5, textColor, nil, TEXT_ALIGN_CENTER)
		end

		self.ammo:AddPanel(ammo)
	end

	self.tabs = self.smoke:Add("EditablePanel")
	self.tabs:Dock(RIGHT)
	self.tabs:SetWide(0)
	self.tabs:DockMargin(0, 25, 0, 0)
	self.tabs.MakeOpenAnimation = function(me)
		local anim_child = vgui.Create("EditablePanel")
		local tabs = me:GetChildren()
		for _, child in ipairs(tabs) do
			child:SetParent(anim_child)
		end
		anim_child:SetParent(me)

		anim_child:SetSize(me:GetWide(), ScrH())
		anim_child.y = -24
		anim_child:SetAlpha(0)
		anim_child:AlphaTo(255, animationTime)
		anim_child:MoveTo(0, 0, animationTime * 0.75, 0, 0.5, function()
			for _, child in ipairs(tabs) do
				child:SetParent(me)
			end
			anim_child:Remove()
		end)
	end

	local activeTab
	for i, cfg in ipairs(Tabs) do
		if cfg.customCheck and cfg.customCheck(ply) == false then continue end

		local tab = self.tabs:Add("EditablePanel")
		tab:Dock(TOP)

		if cfg.spacer then
			tab:SetTall(cfg.spacer)
		else
			local ico
			DownloadIcon(cfg.icon, function(icon)
				ico = icon

				surface.SetFont("StalkerUI-400-27")
				local this_wide, this_tall = surface.GetTextSize(cfg.name)
				tab:SetTall(this_tall)
				self.tabs:SetWide(math.max(self.tabs:GetWide(), this_wide + this_tall + 4))
			end)

			tab:DockMargin(0, 0, 0, 4)
			tab:SetCursor("hand")
			tab.Paint = function(me, w, h)
				surface.SetAlphaMultiplier((me:IsHovered() and 0.65 or 1) * self.currentAlpha / 255)
					if activeTab == me then
						draw.SimpleText(cfg.name, "StalkerUI-400-27-blur", nil, nil, textColorBlur)
					end
					draw.SimpleText(cfg.name, "StalkerUI-400-27", nil, nil, textColor)

					if ico then
						surface.SetDrawColor(255, 255, 255)
						surface.SetMaterial(ico)
						surface.DrawTexturedRect(w - h, 0, h, h)
					end
				surface.SetAlphaMultiplier(1)
			end
			tab.OnMouseReleased = function(me, mcode)
				if mcode == MOUSE_LEFT then
					activeTab = me
					self.tab:Open(i)
				end
			end

			if activeTab == nil then
				activeTab = tab
			end
		end
	end

	timer.Simple(0, function()
		if IsValid(self) then
			self.tabs:MakeOpenAnimation()
		end
	end)

	self.tab = self.smoke:Add("EditablePanel")
	self.tab:Dock(FILL)
	self.tab:DockMargin(0, 0, 16, 0)
	self.tab.Open = function(me, index)
		--if self.ActiveTab == index then return end
		self.ActiveTab = index

		local tab = Tabs[index]

		for i, old_tab in ipairs(me:GetChildren()) do
			old_tab:MoveTo(-me:GetWide(), 31, 0.5)
			old_tab:AlphaTo(0, 0.5, 0, function()
				old_tab:Remove()
				in_anim = false
			end)
		end

		local new_tab = me:Add("EditablePanel")
		new_tab:SetSize(me:GetWide(), me:GetTall() - 31)
		new_tab.x = me:GetWide()
		new_tab.y = 31
		new_tab:MoveTo(0, 31, 0.5)

		if tab.build then
			tab.build(new_tab, self)
		else
			local test = math.random(0, 75)
			new_tab.Paint = function(me, w, h)
				surface.SetDrawColor(test, test, test, 100)
				surface.DrawRect(0, 0, w, h)
				draw.SimpleText("Мы разрабатываем это для вас, пожалуйста, ждите. | СОВСЕМ СКОРО!", "DermaLarge", w * 0.5, h * 0.5, Color(255, 0, 0, 200 + math.sin(CurTime() * 10) * 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
				draw.SimpleText(tab.name, "DermaLarge", w * 0.5, h * 0.5, nil, TEXT_ALIGN_CENTER)
			end
		end
	end
	self.tab.PerformLayout = function(me, w, h)
		for i, child in ipairs(me:GetChildren()) do
			child:SetSize(w, h - 31)
		end
	end

	self.tab:Open(1)

	for i, child in ipairs(self:GetChildren()) do
		child:SetPaintedManually(true)
	end

	self:SetSize(ScrW(), ScrH())
	self:MakePopup()
	self:OnOpened()
	self:ShowBackground()
--[[
	self.smoke_emitter = ParticleEmitter(Vector(128, 128), false)
	self.smoke_emitter:SetNoDraw(true)

	timer.Create("StalkerInventoryMenu/DrawSmoke", 0.5, 0, function()
		if IsValid(self) == false then
			timer.Remove("StalkerInventoryMenu/DrawSmoke")
			return
		end

		local particle = self.smoke_emitter:Add("effects/spark", vector_origin)
		if particle then
			particle:SetDieTime( 1 )

			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )

			particle:SetStartSize( 5 )
			particle:SetEndSize( 0 )

			particle:SetGravity( Vector( 0, 0, -250 ) )
			particle:SetVelocity( VectorRand() * 50 )
		end
	end)
]]
end

--function PANEL:OnRemove()
--	self.smoke_emitter:Finish()
--end

function PANEL:OnScreenSizeChanged()
	self:SetSize(ScrW(), ScrH())
end

function PANEL:OnOpened()
	self:SetAlpha(0)

	self:CreateAnimation(animationTime, {
		target = {currentAlpha = 255},
		easing = "outQuint",
		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end
	})
end

function PANEL:GetActiveTab() return self.ActiveTab end

function PANEL:HideBackground()
	self:CreateAnimation(animationTime, {
		index = 2,
		target = {currentBlur = 0},
		easing = "outQuint"
	})
end

function PANEL:ShowBackground()
	self:CreateAnimation(animationTime, {
		index = 2,
		target = {currentBlur = 1},
		easing = "outQuint"
	})
end

function PANEL:GetStandardSubpanelSize()
	return ScrW() * 0.75 - self:GetPadding() * 3, ScrH() - self:GetPadding() * 2
end

function PANEL:AddManuallyPaintedChild(panel)
	panel:SetParent(self)
	panel:SetPaintedManually(panel)

	self.manualChildren[#self.manualChildren + 1] = panel
end

function PANEL:OnKeyCodePressed(key)
	self.noAnchor = CurTime() + 0.5

	if (key == KEY_TAB) then
		self:Remove()
	end
end

function PANEL:Think()
	if (self.bClosing) then
		return
	end

	local bTabDown = input.IsKeyDown(KEY_TAB)

	if (bTabDown and (self.noAnchor or CurTime() + 0.4) < CurTime() and self.anchorMode) then
		self.anchorMode = false
		surface.PlaySound("buttons/lightswitch2.wav")
	end

	if ((!self.anchorMode and !bTabDown) or gui.IsGameUIVisible()) then
		self:Remove()
	end
end

function PANEL:PaintOver(w, h)
	surface.SetFont("StalkerUI-400-27")
	local money = string.Comma(LocalPlayer():GetCharacter():GetMoney())
	local money_wide = surface.GetTextSize(money)
	local w, h = money_wide + 48 + 28, 50
	local x, y = ScrW() * 0.5 - w * 0.5, 138 - 58
	-- money_mat
	surface.SetDrawColor(0, 0, 0, 150)
	draw.NoTexture()
	surface.DrawPoly({
		{x = x, y = y + h},
		{x = x + 8, y = y},
		{x = x + w - 8, y = y},
		{x = x + w, y = y + h}
	})

	local text_x = x + w * 0.5 - money_wide * 0.5 - 14
	draw.SimpleText(money, "StalkerUI-400-27", text_x, y + h * 0.5, textColor, nil, TEXT_ALIGN_CENTER)

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(money_mat)
	surface.DrawTexturedRect(text_x + money_wide, y + h * 0.5 - 14, 28, 28)
end

local gradient = surface.GetTextureID("vgui/gradient-d")
function PANEL:Paint(width, height)
	surface.SetDrawColor(0, 0, 0, self.currentBlur * 255)
	surface.SetTexture(gradient)
	surface.DrawTexturedRect(0, 0, width, height)

	ix.util.DrawBlur(self, self.currentBlur * 15, nil, 200)

	--self.smoke_emitter:Draw()

	local bShouldScale = self.currentAlpha != 255

	if (bShouldScale) then
		local currentScale = Lerp(self.currentAlpha / 255, 0.9, 1)
		local matrix = Matrix()

		matrix:Scale(matrixZScale * currentScale)
		matrix:Translate(Vector(
			ScrW() * 0.5 - (ScrW() * currentScale * 0.5),
			ScrH() * 0.5 - (ScrH() * currentScale * 0.5),
			1
		))

		cam.PushModelMatrix(matrix)
	end

	BaseClass.Paint(self, width, height)
	self:PaintSubpanels(width, height)
	--self.buttons:PaintManual()

	for i = 1, #self.manualChildren do
		self.manualChildren[i]:PaintManual()
	end

	if (IsValid(ix.gui.inv1) and ix.gui.inv1.childPanels) then
		for i = 1, #ix.gui.inv1.childPanels do
			local panel = ix.gui.inv1.childPanels[i]

			if (IsValid(panel)) then
				panel:PaintManual()
			end
		end
	end

	if (bShouldScale) then
		cam.PopModelMatrix()
	end
end

function PANEL:Remove()
	self.bClosing = true
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	--self:SetCharacterOverview(false, animationTime * 0.5)

	-- remove input from opened child panels since they grab focus
	if (IsValid(ix.gui.inv1) and ix.gui.inv1.childPanels) then
		for i = 1, #ix.gui.inv1.childPanels do
			local panel = ix.gui.inv1.childPanels[i]

			if (IsValid(panel)) then
				panel:SetMouseInputEnabled(false)
				panel:SetKeyboardInputEnabled(false)
			end
		end
	end

	CloseDermaMenus()
	gui.EnableScreenClicker(false)

	self:CreateAnimation(animationTime * 0.5, {
		index = 2,
		target = {currentBlur = 0},
		easing = "outQuint"
	})

	self:CreateAnimation(animationTime * 0.5, {
		target = {currentAlpha = 0},
		easing = "outQuint",

		-- we don't animate the blur because blurring doesn't draw things
		-- with amount < 1 very well, resulting in jarring transition
		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end,

		OnComplete = function(animation, panel)
			if (IsValid(panel.projectedTexture)) then
				panel.projectedTexture:Remove()
			end

			BaseClass.Remove(panel)
		end
	})
end

vgui.Register("ixMenu", PANEL, "ixSubpanelParent")

if (IsValid(ix.gui.menu)) then
	ix.gui.menu:Remove()
end

ix.gui.lastMenuTab = nil

end)