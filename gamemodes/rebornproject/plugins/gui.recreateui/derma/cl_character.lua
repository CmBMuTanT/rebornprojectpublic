
local gradient = surface.GetTextureID("vgui/gradient-d")
local audioFadeInTime = 2
local animationTime = 0.5
local matrixZScale = Vector(1, 1, 0.0001)

local logoimgURL = "https://i.imgur.com/OgxbirY.png"

-- character menu panel
DEFINE_BASECLASS("ixSubpanelParent")
local PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetSize())
	self:SetPos(0, 0)

	self.childPanels = {}
	self.subpanels = {}
	self.activeSubpanel = ""

	self.currentDimAmount = 0
	self.currentY = 0
	self.currentScale = 1
	self.currentAlpha = 255
	self.targetDimAmount = 255
	self.targetScale = 0.9
end

function PANEL:Dim(length, callback)
	length = length or animationTime
	self.currentDimAmount = 0

	self:CreateAnimation(length, {
		target = {
			currentDimAmount = self.targetDimAmount,
			currentScale = self.targetScale
		},
		easing = "outCubic",
		OnComplete = callback
	})

	self:OnDim()
end

function PANEL:Undim(length, callback)
	length = length or animationTime
	self.currentDimAmount = self.targetDimAmount

	self:CreateAnimation(length, {
		target = {
			currentDimAmount = 0,
			currentScale = 1
		},
		easing = "outCubic",
		OnComplete = callback
	})

	self:OnUndim()
end

function PANEL:OnDim()
end

function PANEL:OnUndim()
end

function PANEL:Paint(width, height)
	local amount = self.currentDimAmount
	local bShouldScale = self.currentScale != 1
	local matrix

	-- draw child panels with scaling if needed
	if (bShouldScale) then
		matrix = Matrix()
		matrix:Scale(matrixZScale * self.currentScale)
		matrix:Translate(Vector(
			ScrW() * 0.5 - (ScrW() * self.currentScale * 0.5),
			ScrH() * 0.5 - (ScrH() * self.currentScale * 0.5),
			1
		))

		cam.PushModelMatrix(matrix)
		self.currentMatrix = matrix
	end

	BaseClass.Paint(self, width, height)

	if (bShouldScale) then
		cam.PopModelMatrix()
		self.currentMatrix = nil
	end

	if (amount > 0) then
		local color = Color(0, 0, 0, amount)

		surface.SetDrawColor(color)
		surface.DrawRect(0, 0, width, height)
	end

end

vgui.Register("ixCharMenuPanel", PANEL, "ixSubpanelParent")

-- character menu main button list
PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	self:SetSize(parent:GetWide() * 0.25, parent:GetTall())

	self:GetVBar():SetWide(0)
	self:GetVBar():SetVisible(false)
end

function PANEL:Add(name)
	local panel = vgui.Create(name, self)
	panel:Dock(TOP)

	return panel
end

function PANEL:SizeToContents()
	self:GetCanvas():InvalidateLayout(true)

	-- if the canvas has extra space, forcefully dock to the bottom so it doesn't anchor to the top
	if (self:GetTall() > self:GetCanvas():GetTall()) then
		self:GetCanvas():Dock(BOTTOM)
	else
		self:GetCanvas():Dock(NODOCK)
	end
end

vgui.Register("ixCharMenuButtonList", PANEL, "DScrollPanel")

-- main character menu panel
PANEL = {}

AccessorFunc(PANEL, "bUsingCharacter", "UsingCharacter", FORCE_BOOL)

local padding = ScreenScale(32)

function PANEL:Init()
	local parent = self:GetParent()
	local halfWidth = parent:GetWide() * 0.5 - (padding * 2)
	local halfHeight = parent:GetTall() * 0.5 - (padding * 2)
	local bHasCharacter = #ix.characters > 0

	self.bUsingCharacter = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0,0)

	self.mainframe = self:Add("Panel")
	self.mainframe:Dock(FILL)

	self.logoframe = self:Add("Panel")
	self.logoframe:Dock(TOP)
	self.logoframe:SetTall(halfHeight * 1.3)
	self.logoframe.Paint = function(this, w, h)
	end

	local logopng = self.logoframe:Add("Panel")
	logopng:Dock(TOP)
	logopng:DockMargin(0,halfHeight * .2,0,0)

	logopng.Paint = function(this, w, h)
		DownloadIconFromURL(logoimgURL, function(person)
			surface.SetDrawColor(Color(255,255,255))
			surface.SetMaterial(person or Material("models/wireframe"))
			surface.DrawTexturedRect(w*0.42,0,w/6.4,h)
		end)

	end
	logopng:SetTall(halfHeight * .75)

	local logotext = self.logoframe:Add("Panel")
	logotext:Dock(TOP)
	logotext.Paint = function(panel, w, h)
		draw.DrawText(L2("schemaName") or Schema.name or L"Научись ставить моды дебил...", "ixTitleFont", w/2, 0, Color(255,255,255), TEXT_ALIGN_CENTER)
	end
	logotext:SetTall(halfHeight * 2)

	-----------
	local buttonsframe = self.mainframe:Add("Panel")
	buttonsframe:Dock(TOP)
	buttonsframe:SetTall(halfHeight * 2)
	buttonsframe:DockMargin(halfWidth * .85, 0, halfWidth * .85, 0)
	buttonsframe.Paint = function(this, w, h)
		draw.RoundedBox(10,0,0,w,h * .43,Color(20, 20, 20, 200))
	end

	local barstat1,barstat2,barstat3,barstat4 = 0,0,0,0
	local col1,col2,col3,col4 = Color(255, 255, 255),Color(255, 255, 255),Color(255, 255, 255),Color(255, 255, 255)
	local sp = 3

	local createButton = buttonsframe:Add("DButton")
	createButton:SetText("")
	createButton:SizeToContents()
	createButton:Dock(TOP)
	createButton:SetTall(halfHeight * .2)
	createButton.Paint = function(panel, w, h)
		panel:SetText("СОЗДАТЬ")
		panel:SetFont("DermaLarge")

		if panel:IsHovered() then
			barstat1 = math.Clamp(barstat1 + sp * FrameTime(), 0, 1)
			col1 = Color(20, 20, 20)
			draw.RoundedBox( 10, 0, 0, w, h, Color(20, 20, 20, 240) )
			panel:SetTextColor(Color(20, 20, 20))
		else
			barstat1 = math.Clamp(barstat1 - sp * FrameTime(), 0, 1)
			col1 = Color(255, 255, 255)
			draw.RoundedBox( 10, 0, 0, w, h, Color(20, 20, 20, 240) )
			panel:SetTextColor(Color(230, 230, 230))
		end

		draw.RoundedBox(10, 0, 0, w * barstat1, h, ix.config.Get("color") or COLOR_WHITE)

		DownloadIconFromURL("https://i.imgur.com/kXn6lvu.png", function(person)
			surface.SetDrawColor(col1)
			surface.SetMaterial(person or Material("models/wireframe"))
			surface.DrawTexturedRect(5, h * 0.25, w*.05,h*0.5)
		end)
	end

	createButton.DoClick = function()
		local maximum = hook.Run("GetMaxPlayerCharacter", LocalPlayer()) or ix.config.Get("maxCharacters", 5)
		-- don't allow creation if we've hit the character limit
		if (#ix.characters >= maximum) then
			self:GetParent():ShowNotice(3, L("maxCharacters"))
			return
		end

		self:Dim()
		parent.newCharacterPanel:SetActiveSubpanel("faction", 0)
		parent.newCharacterPanel:SlideUp()
	end

	local tab = buttonsframe:Add("EditablePanel")
	tab:Dock(TOP)
	tab:SetTall(5)
	tab:DockMargin(0, 0, 0, 4)

	-- load character button
	self.loadButton = buttonsframe:Add("DButton")
	self.loadButton:SetText("")
	self.loadButton:Dock(TOP)
	self.loadButton:SizeToContents()
	self.loadButton:SetTall(halfHeight * .2)
	self.loadButton.Paint = function(panel, w, h)
		panel:SetText("ПЕРСОНАЖИ")
		panel:SetFont("DermaLarge")

		if panel:IsHovered() then
			barstat2 = math.Clamp(barstat2 + sp * FrameTime(), 0, 1)
			col2 = Color(20, 20, 20)
			draw.RoundedBox( 10, 0, 0, w, h, Color(20, 20, 20, 240) )
			panel:SetTextColor(Color(20, 20, 20))
		else
			barstat2 = math.Clamp(barstat2 - sp * FrameTime(), 0, 1)
			col2 = Color(255, 255, 255)
			draw.RoundedBox( 10, 0, 0, w, h, Color(20, 20, 20, 240) )
			panel:SetTextColor(Color(230, 230, 230))
		end

		draw.RoundedBox(10, 0, 0, w * barstat2, h, ix.config.Get("color") or COLOR_WHITE)

		DownloadIconFromURL("https://i.imgur.com/LtKwXeY.png", function(person)
			surface.SetDrawColor(col2)
			surface.SetMaterial(person or Material("models/wireframe"))
			surface.DrawTexturedRect(5, h * 0.25, w*.06,h*0.5)
		end)

	end
	self.loadButton.DoClick = function()
		self:Dim()
		parent.loadCharacterPanel:SlideUp()
	end

	if (!bHasCharacter) then
		self.loadButton:SetDisabled(true)
	end

	local tab = buttonsframe:Add("EditablePanel")
	tab:Dock(TOP)
	tab:SetTall(5)
	tab:DockMargin(0, 0, 0, 4)

	-- community button
	local extraURL = ix.config.Get("communityURL", "")
	local extraText = ix.config.Get("communityText", "@community")

	if (extraURL != "" and extraText != "") then
		if (extraText:sub(1, 1) == "@") then
			extraText = L(extraText:sub(2))
		end

		local extraButton = buttonsframe:Add("DButton")
		extraButton:SetText("DISCORD", true)
		extraButton:SizeToContents()
		extraButton:Dock(TOP)
		extraButton:SetTall(halfHeight * .2)
		extraButton.Paint = function(panel, w, h)
			panel:SetText("DISCORD")
			panel:SetFont("DermaLarge")
	
			if panel:IsHovered() then
				barstat3 = math.Clamp(barstat3 + sp * FrameTime(), 0, 1)
				col3 = Color(20, 20, 20)
				draw.RoundedBox( 10, 0, 0, w, h, Color(20, 20, 20, 240) )
				panel:SetTextColor(Color(20, 20, 20))
			else
				barstat3 = math.Clamp(barstat3 - sp * FrameTime(), 0, 1)
				col3 = Color(255, 255, 2550)
				draw.RoundedBox( 10, 0, 0, w, h, Color(20, 20, 20, 240) )
				panel:SetTextColor(Color(230, 230, 230))
			end
	
			draw.RoundedBox(10, 0, 0, w * barstat3, h, ix.config.Get("color") or COLOR_WHITE)

			DownloadIconFromURL("https://i.imgur.com/IHwZ7ty.png", function(person)
				surface.SetDrawColor(col3)
				surface.SetMaterial(person or Material("models/wireframe"))
				surface.DrawTexturedRect(5, h * 0.25, w*.07,h*0.5)
			end)
		end
		extraButton.DoClick = function()
			gui.OpenURL(extraURL)
		end
	end

	local tab = buttonsframe:Add("EditablePanel")
	tab:Dock(TOP)
	tab:SetTall(5)
	tab:DockMargin(0, 0, 0, 4)
	-- leave/return button
	self.returnButton = buttonsframe:Add("DButton")
	self.returnButton:Dock(TOP)
	self:UpdateReturnButton()
	self.returnButton.Paint = function(panel, w, h)
		panel:SetText(self.bUsingCharacter and "ВЕРНУТЬСЯ" or "ВЫЙТИ")
		panel:SetFont("DermaLarge")

		if panel:IsHovered() then
			barstat4 = math.Clamp(barstat4 + sp * FrameTime(), 0, 1)
			col4 = Color(20, 20, 20)
			draw.RoundedBox( 10, 0, 0, w, h, Color(20, 20, 20, 240) )
			panel:SetTextColor(Color(20, 20, 20))
		else
			barstat4 = math.Clamp(barstat4 - sp * FrameTime(), 0, 1)
			col4 = Color(255, 255, 255)
			draw.RoundedBox( 10, 0, 0, w, h, Color(20, 20, 20, 240) )
			panel:SetTextColor(Color(230, 230, 230))
		end

		draw.RoundedBox(10, 0, 0, w * barstat4, h, ix.config.Get("color") or COLOR_WHITE)

		if self.bUsingCharacter then
			DownloadIconFromURL("https://i.imgur.com/MUoWRSR.png", function(person)
				surface.SetDrawColor(col4)
				surface.SetMaterial(person or Material("models/wireframe"))
				surface.DrawTexturedRect(5, h * 0.25, w*.06,h*0.5)
			end)
		else
			DownloadIconFromURL("https://i.imgur.com/vkrri3J.png", function(person)
				surface.SetDrawColor(col4)
				surface.SetMaterial(person or Material("models/wireframe"))
				surface.DrawTexturedRect(5, h * 0.25, w*.06,h*0.5)
			end)
		end
	end
	self.returnButton.DoClick = function()
		if (self.bUsingCharacter) then
			parent:Close()
		else
			RunConsoleCommand("disconnect")
		end
	end

end

function PANEL:UpdateReturnButton(bValue)
	local parent = self:GetParent()
	local halfWidth = parent:GetWide() * 0.5 - (padding * 2)
	local halfHeight = parent:GetTall() * 0.5 - (padding * 2)

	if (bValue != nil) then
		self.bUsingCharacter = bValue
	end

	--self.returnButton:SetText(self.bUsingCharacter and "ВЕРНУТЬСЯ" or "ВЫЙТИ")
	--self.returnButton:Dock(TOP)
	self.returnButton:SizeToContents()
	self.returnButton:SetTall(halfHeight * .2)
end

function PANEL:OnDim()
	-- disable input on this panel since it will still be in the background while invisible - prone to stray clicks if the
	-- panels overtop slide out of the way
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
end

function PANEL:OnUndim()
	self:SetMouseInputEnabled(true)
	self:SetKeyboardInputEnabled(true)

	-- we may have just deleted a character so update the status of the return button
	self.bUsingCharacter = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()
	self:UpdateReturnButton()
end

function PANEL:OnClose()
	for _, v in pairs(self:GetChildren()) do
		if (IsValid(v)) then
			v:SetVisible(false)
		end
	end
end

function PANEL:PerformLayout(width, height)
end

vgui.Register("ixCharMenuMain", PANEL, "ixCharMenuPanel")

-- container panel
PANEL = {}

function PANEL:Init()
	if (IsValid(ix.gui.loading)) then
		ix.gui.loading:Remove()
	end

	if (IsValid(ix.gui.characterMenu)) then
		if (IsValid(ix.gui.characterMenu.channel)) then
			ix.gui.characterMenu.channel:Stop()
		end

		ix.gui.characterMenu:Remove()
	end

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)

	-- main menu panel
	self.mainPanel = self:Add("ixCharMenuMain")

	-- new character panel
	self.newCharacterPanel = self:Add("ixCharMenuNew")
	self.newCharacterPanel:SlideDown(0)

	-- load character panel
	self.loadCharacterPanel = self:Add("ixCharMenuLoad")
	self.loadCharacterPanel:SlideDown(0)

	-- notice bar
	self.notice = self:Add("ixNoticeBar")

	-- finalization
	self:MakePopup()
	self.currentAlpha = 255
	self.volume = 0

	ix.gui.characterMenu = self

	if (!IsValid(ix.gui.intro)) then
		self:PlayMusic()
	end

	hook.Run("OnCharacterMenuCreated", self)
end

function PANEL:PlayMusic()
	local path = "sound/" .. ix.config.Get("music")
	local url = path:match("http[s]?://.+")
	local play = url and sound.PlayURL or sound.PlayFile
	path = url and url or path

	play(path, "noplay", function(channel, error, message)
		if (!IsValid(self) or !IsValid(channel)) then
			return
		end

		channel:SetVolume(self.volume or 0)
		channel:Play()

		self.channel = channel

		self:CreateAnimation(audioFadeInTime, {
			index = 10,
			target = {volume = 1},

			Think = function(animation, panel)
				if (IsValid(panel.channel)) then
					panel.channel:SetVolume(self.volume * 0.5)
				end
			end
		})
	end)
end

function PANEL:ShowNotice(type, text)
	self.notice:SetType(type)
	self.notice:SetText(text)
	self.notice:Show()
end

function PANEL:HideNotice()
	if (IsValid(self.notice) and !self.notice:GetHidden()) then
		self.notice:Slide("up", 0.5, true)
	end
end

function PANEL:OnCharacterDeleted(character)
	if (#ix.characters == 0) then
		self.mainPanel.loadButton:SetDisabled(true)
		--self.mainPanel:Undim() -- undim since the load panel will slide down
	else
		self.mainPanel.loadButton:SetDisabled(false)
	end

	self.loadCharacterPanel:OnCharacterDeleted(character)
end

function PANEL:OnCharacterLoadFailed(error)
	self.loadCharacterPanel:SetMouseInputEnabled(true)
	self.loadCharacterPanel:SlideUp()
	self:ShowNotice(3, error)
end

function PANEL:IsClosing()
	return self.bClosing
end

function PANEL:Close(bFromMenu)
	self.bClosing = true
	self.bFromMenu = bFromMenu

	local fadeOutTime = animationTime * 8

	self:CreateAnimation(fadeOutTime, {
		index = 1,
		target = {currentAlpha = 0},

		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end,

		OnComplete = function(animation, panel)
			panel:Remove()
		end
	})

	self:CreateAnimation(fadeOutTime - 0.1, {
		index = 10,
		target = {volume = 0},

		Think = function(animation, panel)
			if (IsValid(panel.channel)) then
				panel.channel:SetVolume(self.volume * 0.5)
			end
		end,

		OnComplete = function(animation, panel)
			if (IsValid(panel.channel)) then
				panel.channel:Stop()
				panel.channel = nil
			end
		end
	})

	-- hide children if we're already dimmed
	if (bFromMenu) then
		for _, v in pairs(self:GetChildren()) do
			if (IsValid(v)) then
				v:SetVisible(false)
			end
		end
	else
		-- fade out the main panel quicker because it significantly blocks the screen
		self.mainPanel.currentAlpha = 255

		self.mainPanel:CreateAnimation(animationTime * 2, {
			target = {currentAlpha = 0},
			easing = "outQuint",

			Think = function(animation, panel)
				panel:SetAlpha(panel.currentAlpha)
			end,

			OnComplete = function(animation, panel)
				panel:SetVisible(false)
			end
		})
	end

	-- relinquish mouse control
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	gui.EnableScreenClicker(false)
end

function PANEL:Paint(width, height)
	surface.SetTexture(gradient)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(0, 0, width, height)

	if (!ix.option.Get("cheapBlur", false)) then
		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawTexturedRect(0, 0, width, height)
		ix.util.DrawBlur(self, Lerp((self.currentAlpha - 200) / 255, 0, 10))
	end
end

function PANEL:PaintOver(width, height)
	if (self.bClosing and self.bFromMenu) then
		surface.SetDrawColor(color_black)
		surface.DrawRect(0, 0, width, height)
	end
end

function PANEL:OnRemove()
	if (self.channel) then
		self.channel:Stop()
		self.channel = nil
	end
end

vgui.Register("ixCharMenu", PANEL, "EditablePanel")

if (IsValid(ix.gui.characterMenu)) then
	ix.gui.characterMenu:Remove()

	--TODO: REMOVE ME
	ix.gui.characterMenu = vgui.Create("ixCharMenu")
end
