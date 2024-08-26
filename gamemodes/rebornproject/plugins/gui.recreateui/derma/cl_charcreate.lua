local PLUGIN = PLUGIN

local ICONColors = Color(255,100,0)

local padding = ScreenScale(32)
--local subpanelactivenow = 1
-- create character panel
DEFINE_BASECLASS("ixCharMenuPanel")
local PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	local halfWidth = parent:GetWide() * 0.5 - (padding * 2)
	local halfHeight = parent:GetTall() * 0.5 - (padding * 2)
	local modelFOV = (ScrW() > ScrH() * 1.8) and 100 or 78
	self.CHARHeightChoice = 4
	self.GetStartPoints = 0


	self:ResetPayload(true)

	self.factionButtons = {}
	self.repopulatePanels = {}

	-- faction selection subpanel
	self.factionPanel = self:AddSubpanel("faction", true)
	self.factionPanel:SetTitle("chooseFaction")
	self.factionPanel.OnSetActive = function()
		if (#self.factionButtons == 1) then
			self:SetActiveSubpanel("description", 0)
		end
	end

	local modelList = self.factionPanel:Add("Panel")
	modelList:Dock(RIGHT)
	modelList:SetSize(halfWidth + padding * 2, halfHeight)

	local proceed = modelList:Add("ixMenuButton")
	proceed:SetText("proceed")
	proceed:SetContentAlignment(6)
	proceed:Dock(BOTTOM)
	proceed:SizeToContents()
	proceed.DoClick = function()
		self.progress:IncrementProgress()

		self:Populate()
		self:SetActiveSubpanel("description")
	end

	self.factionModel = modelList:Add("ixModelPanel")
	self.factionModel:Dock(FILL)
	self.factionModel:SetModel("models/error.mdl")
	self.factionModel:SetFOV(modelFOV)
	self.factionModel.PaintModel = self.factionModel.Paint
	self.factionModel.Entity:SetSequence("bandit_idle_1_idle_0")

	self.factionButtonsPanel = self.factionPanel:Add("ixCharMenuButtonList")
	self.factionButtonsPanel:SetWide(halfWidth)
	self.factionButtonsPanel:Dock(FILL)

	local factionBack = self.factionPanel:Add("ixMenuButton")
	factionBack:SetText("return")
	factionBack:SizeToContents()
	factionBack:Dock(BOTTOM)
	factionBack.DoClick = function()
		self.progress:DecrementProgress()

		self:SetActiveSubpanel("faction", 0)
		self:SlideDown()

		parent.mainPanel:Undim()
	end

	---------------------------------------------------------------------------------------------------------------
	-- character customization subpanel
	self.description = self:AddSubpanel("description")
	self.description:SetTitle("chooseDescription")
	self.description.Paint = function(this,w,h)
	end

	local buttonsdescription = self.description:Add("Panel")
	buttonsdescription:Dock(BOTTOM)
	buttonsdescription:SetTall(64)
	buttonsdescription.Paint = function(this,w,h)
	end

	local descriptionProceed = buttonsdescription:Add("ixMenuButton")
	descriptionProceed:SetText("proceed")
	descriptionProceed:SetContentAlignment(6)
	descriptionProceed:SizeToContents()
	descriptionProceed:Dock(RIGHT)
	descriptionProceed.DoClick = function()
		if (self:VerifyProgression("description")) then
				self:SendPayload()
				
			self.progress:IncrementProgress()

			if IsValid(self.descriptionModelItemsChar) then
				self.descriptionModelItemsChar:Clear()
			end
		end
	end

	self.descriptionPanel = self.description:Add("Panel")
	self.descriptionPanel:SetWide(halfWidth + padding * 2)
	self.descriptionPanel:SetSize(halfWidth *.65, halfHeight *.65)
	self.descriptionPanel:Dock(RIGHT)
	self.descriptionPanel.Paint = function(this,w,h)
		--draw.RoundedBox(0,0,0,w,h,Color(255,0,0))
	end
	
	local descriptionModelList = self.description:Add("Panel")
	descriptionModelList:Dock(FILL)
	descriptionModelList:SetSize(halfWidth, halfHeight)
	descriptionModelList.Paint = function(this,w,h)
	end

	self.descriptionModel = descriptionModelList:Add("DModelPanel")
	self.descriptionModel:Dock(FILL)
	self.descriptionModel:SetModel(self.factionModel:GetModel())
	self.descriptionModel:SetFOV(modelFOV - 65)
	self.descriptionModel:SetLookAt(Vector(0, 0, 65))
	self.descriptionModel:SetCamPos(Vector(50, 50, 50))
	self.descriptionModel.Entity:SetSequence("bandit_idle_1_idle_0")
--    function icon:LayoutEntity( Entity ) return end 
	self.descriptionModel.LayoutEntity = function() return end 
	self.descriptionModel.PaintModel = self.descriptionModel.Paint

	self.descriptionPanelCustoms = self.description:Add("Panel")
	self.descriptionPanelCustoms:SetWide(halfWidth * .6)
	self.descriptionPanelCustoms:Dock(LEFT)
	self.descriptionPanelCustoms.Paint = function(this,w,h)
	end

	self.descriptionModelHeight = self.descriptionPanelCustoms:Add("Panel")
	self.descriptionModelHeight:Dock(TOP)
	self.descriptionModelHeight:SetTall(halfHeight * .17)
	self.descriptionModelHeight.Paint = function(this,w,h)
		draw.DrawText("РОСТ ПЕРСОНАЖА", "ixMenuButtonLabelFont", w / 2, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end

	local CharHeightNum = {
		"160",
		"165",
		"170",
		"175", -- STANDART https://ru.wikipedia.org/wiki/Рост_человека#Средний_рост_человека_в_России (fuck women, only men)
		"180",
		"185",
		"190",
	}

	self.descriptionModelComboHeight = self.descriptionModelHeight:Add("DComboBox")
	self.descriptionModelComboHeight:Dock(BOTTOM)
	self.descriptionModelComboHeight:SetTextColor(color_white)
	self.descriptionModelComboHeight:SetValue( "175" )
	self.descriptionModelComboHeight:SetTextColor( Color( 20, 20, 20) )
	self.descriptionModelComboHeight.Paint = function(this,w,h)
		draw.RoundedBox(0,0,0,w,h, Color(20, 20, 20))
		draw.DrawText(this:GetSelected() or "175", "ixMenuButtonLabelFont", w / 2, -2, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end

	for _, v in ipairs(CharHeightNum) do
		self.descriptionModelComboHeight:AddChoice(v)
	end

	self.descriptionModelComboHeight.OnSelect = function( this, index, value )
		self.CHARHeightChoice = index
	end

	self.descriptionModelItems = self.descriptionPanelCustoms:Add("Panel")
	self.descriptionModelItems:Dock(TOP)
	self.descriptionModelItems:SetTall(halfHeight * 2)
	self.descriptionModelItems.Paint = function(this,w,h)
		draw.DrawText("ВЫБОР ПРЕДМЕТОВ", "ixMenuButtonLabelFont", w / 2, h * .01, Color(255, 255, 255), TEXT_ALIGN_CENTER)

		draw.DrawText("ПЕРСОНАЖ", "ixMenuButtonLabelFont", w / 2, h * .44, Color(255, 255, 255), TEXT_ALIGN_CENTER)

		draw.DrawText("СТАРТОВЫЕ ОЧКИ: "..self.GetStartPoints, "ixMenuButtonLabelFont", w / 2, h * .87, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end

	self.descriptionModelItemsFull = self.descriptionModelItems:Add("DListView")
	self.descriptionModelItemsFull:Dock(TOP)
	self.descriptionModelItemsFull:SetMultiSelect( false )
	self.descriptionModelItemsFull:AddColumn( "UID" ).Header:SetTextColor(Color(25, 25, 25))
	self.descriptionModelItemsFull:AddColumn( "Название предмета" ).Header:SetTextColor(Color(25, 25, 25))
	self.descriptionModelItemsFull:AddColumn( "Цена" ).Header:SetTextColor(Color(25, 25, 25))
	self.descriptionModelItemsFull:SetTall(halfHeight * .7)
	self.descriptionModelItemsFull:DockMargin(0, 50, 0, 50)

	self.descriptionModelItemsFull.Paint = function(this,w,h)

		for _, FORFUCKSAKE in pairs(this:GetLines()) do -- я мать гарри ебал в рот, вы понимаете? Я блять весь КЛ сайд пересмотрел ради этой хуйни.
			for _, FUCKYOGARRY in pairs(FORFUCKSAKE.Columns) do
				FUCKYOGARRY:SetTextColor(Color(255, 255, 255))
			end
		end

		draw.RoundedBox(0,0,0,w,h, Color(20,20,20))
	end


	for k,v in SortedPairs(PLUGIN.itemstochoice) do
		local item = ix.item.Get(v.ItemUID)
		--if !item then continue end
		self.descriptionModelItemsFull:AddLine(k, item.name, v.price )
	end

	self.descriptionModelItemsFull.DoDoubleClick = function(pnl, ID)

		for k,v in SortedPairs(PLUGIN.itemstochoice) do -- double check ok m8?
			if k == ID then
				if self.GetStartPoints >= v.price then
					local item = ix.item.Get(v.ItemUID)
					self.descriptionModelItemsChar:AddLine(k, v.ItemUID, item.name, v.price )
					self.GetStartPoints = self.GetStartPoints - v.price
				end
			end
		end
	end

	self.descriptionModelItemsChar = self.descriptionModelItems:Add("DListView")
	self.descriptionModelItemsChar:Dock(TOP)
	self.descriptionModelItemsChar:SetMultiSelect( false )
	self.descriptionModelItemsChar:AddColumn( "UID" ).Header:SetTextColor(Color(25, 25, 25))
	self.descriptionModelItemsChar:AddColumn( "iID" ).Header:SetTextColor(Color(25, 25, 25))
	self.descriptionModelItemsChar:AddColumn( "Название предмета" ).Header:SetTextColor(Color(25, 25, 25))
	self.descriptionModelItemsChar:AddColumn( "Цена" ).Header:SetTextColor(Color(25, 25, 25))
	self.descriptionModelItemsChar:SetTall(halfHeight * .7)

	self.descriptionModelItemsChar.Paint = function(this,w,h)

		for _, FORFUCKSAKE in pairs(this:GetLines()) do -- CTRL + C, CTRL + V
			for _, FUCKYOGARRY in pairs(FORFUCKSAKE.Columns) do
				FUCKYOGARRY:SetTextColor(Color(255, 255, 255))
			end
		end

		draw.RoundedBox(0,0,0,w,h, Color(20,20,20))
	end

	self.descriptionModelItemsChar.DoDoubleClick = function(this, linenumber, lineinfo)
		for k,v in pairs(PLUGIN.itemstochoice) do
			if k == lineinfo:GetColumnText(1) then
				this:RemoveLine(linenumber)
				self.GetStartPoints = self.GetStartPoints + v.price
			end
		end
	end

	local descriptionBack = buttonsdescription:Add("ixMenuButton")
	descriptionBack:SetText("return")
	descriptionBack:SetContentAlignment(4)
	descriptionBack:SizeToContents()
	descriptionBack:Dock(LEFT)
	descriptionBack.DoClick = function()
		self.progress:DecrementProgress()

		if (#self.factionButtons == 1) then
			factionBack:DoClick()
		else
			self:SetActiveSubpanel("faction")
		end
	end
----------------------------
	--creation progress panel
	self.progress = self:Add("ixSegmentedProgress")
	self.progress:SetBarColor(ix.config.Get("color"))
	self.progress:SetSize(parent:GetWide(), 0)
	self.progress:SizeToContents()
	self.progress:SetPos(0, parent:GetTall() - self.progress:GetTall())
	

	-- setup payload hooks
	self:AddPayloadHook("model", function(value)
		local faction = ix.faction.indices[self.payload.faction]

		if (faction) then
			local model = faction:GetModels(LocalPlayer())[value]

			-- assuming bodygroups
			if (istable(model)) then
				self.factionModel:SetModel(model[1], model[2] or 0, model[3])
				self.descriptionModel:SetModel(model[1], model[2] or 0, model[3])
			else
				self.factionModel:SetModel(model)
				self.descriptionModel:SetModel(model)
			end
		end
	end)

	-- setup character creation hooks
	net.Receive("ixCharacterAuthed", function()
		timer.Remove("ixCharacterCreateTimeout")
		self.awaitingResponse = false

		local id = net.ReadUInt(32)
		local indices = net.ReadUInt(6)
		local charList = {}

		for _ = 1, indices do
			charList[#charList + 1] = net.ReadUInt(32)
		end

		ix.characters = charList

		self:SlideDown()

		if (!IsValid(self) or !IsValid(parent)) then
			return
		end

		if (LocalPlayer():GetCharacter()) then
			parent.mainPanel:Undim()
			parent:ShowNotice(2, L("charCreated"))
		elseif (id) then
			self.bMenuShouldClose = true

			net.Start("ixCharacterChoose")
				net.WriteUInt(id, 32)
			net.SendToServer()
		else
			self:SlideDown()
		end
	end)

	net.Receive("ixCharacterAuthFailed", function()
		timer.Remove("ixCharacterCreateTimeout")
		self.awaitingResponse = false

		local fault = net.ReadString()
		local args = net.ReadTable()

		self:SlideDown()

		parent.mainPanel:Undim()
		parent:ShowNotice(3, L(fault, unpack(args)))
	end)
end

function PANEL:SendPayload()
	if (self.awaitingResponse or !self:VerifyProgression()) then
		return
	end

	self.awaitingResponse = true

	timer.Create("ixCharacterCreateTimeout", 10, 1, function()
		if (IsValid(self) and self.awaitingResponse) then
			local parent = self:GetParent()

			self.awaitingResponse = false
			self:SlideDown()

			parent.mainPanel:Undim()
			parent:ShowNotice(3, L("unknownError"))
		end
	end)

	self.payload:Prepare()

	net.Start("ixCharacterCreate")
	net.WriteUInt(table.Count(self.payload), 8)

	for k, v in pairs(self.payload) do
		net.WriteString(k)
		net.WriteType(v)
	end

	net.WriteString(self.CHARHeightChoice)
	net.SendToServer()

	local dataToSend = {}

	for k, line in pairs(self.descriptionModelItemsChar:GetLines()) do
		dataToSend[k] = line:GetValue(2)
	end
	
	net.Start("SH_Pendulum_Propane_Nightmares")
	net.WriteTable(dataToSend)
	net.SendToServer()
	

	-- for k, line in pairs( self.descriptionModelItemsChar:GetLines()) do
	-- 	--netstream.Start("SH_Pendulum_Propane_Nightmares", LocalPlayer(), k, line:GetValue(2))
	-- 	net.Start("SH_Pendulum_Propane_Nightmares")
	-- 	net.WriteString(k)
	-- 	net.WriteString(line:GetValue(2))
	-- 	net.SendToServer()
	-- end

end

function PANEL:OnSlideUp()
	self:ResetPayload()
	self:Populate()
	self.progress:SetProgress(1)

	self:SetActiveSubpanel("faction", 0)
end

function PANEL:OnSlideDown()
end

function PANEL:ResetPayload(bWithHooks)
	if (bWithHooks) then
		self.hooks = {}
	end

	if IsValid(self.descriptionModelItemsChar) then
		self.descriptionModelItemsChar:Clear()
	end

	self.payload = {}
	self.PornoDulum = {}
	netstream.Start("GiveMeStartCredits", LocalPlayer())

	self.GetStartPoints = LocalPlayer():GetNetVar("StartCredits")

	-- TODO: eh..
	function self.payload.Set(payload, key, value)
		self:SetPayload(key, value)
	end

	function self.payload.AddHook(payload, key, callback)
		self:AddPayloadHook(key, callback)
	end

	function self.payload.Prepare(payload)
		self.payload.Set = nil
		self.payload.AddHook = nil
		self.payload.Prepare = nil
	end
end

function PANEL:SetPayload(key, value)
	self.payload[key] = value
	self:RunPayloadHook(key, value)
end

function PANEL:AddPayloadHook(key, callback)
	if (!self.hooks[key]) then
		self.hooks[key] = {}
	end

	self.hooks[key][#self.hooks[key] + 1] = callback
end

function PANEL:RunPayloadHook(key, value)
	local hooks = self.hooks[key] or {}

	for _, v in ipairs(hooks) do
		v(value)
	end
end

function PANEL:GetContainerPanel(name)
	-- TODO: yuck
	if (name == "description") then
		return self.descriptionPanel
	end

	return self.descriptionPanel
end

function PANEL:AttachCleanup(panel)
	self.repopulatePanels[#self.repopulatePanels + 1] = panel
end

function PANEL:Populate()
	if (!self.bInitialPopulate) then
		-- setup buttons for the faction panel
		-- TODO: make this a bit less janky
		local lastSelected

		for _, v in pairs(self.factionButtons) do
			if (v:GetSelected()) then
				lastSelected = v.faction
			end

			if (IsValid(v)) then
				v:Remove()
			end
		end

		self.factionButtons = {}

		for _, v in SortedPairs(ix.faction.teams) do
			if (ix.faction.HasWhitelist(v.index)) then
				local button = self.factionButtonsPanel:Add("ixMenuSelectionButton")
				button:SetBackgroundColor(v.color or color_white)
				button:SetText(L(v.name):utf8upper())
				button:SizeToContents()
				button:SetButtonList(self.factionButtons)
				button.faction = v.index
				button.OnSelected = function(panel)
					local faction = ix.faction.indices[panel.faction]
					local models = faction:GetModels(LocalPlayer())

					self.payload:Set("faction", panel.faction)
					self.payload:Set("model", math.random(1, #models))
				end

				if ((lastSelected and lastSelected == v.index) or (!lastSelected and v.isDefault)) then
					button:SetSelected(true)
					lastSelected = v.index
				end
			end
		end
	end

	-- remove panels created for character vars
	for i = 1, #self.repopulatePanels do
		self.repopulatePanels[i]:Remove()
	end

	self.repopulatePanels = {}

	-- payload is empty because we attempted to send it - for whatever reason we're back here again so we need to repopulate
	if (!self.payload.faction) then
		for _, v in pairs(self.factionButtons) do
			if (v:GetSelected()) then
				v:SetSelected(true)
				break
			end
		end
	end

	self.factionButtonsPanel:SizeToContents()

	local zPos = 1

	-- set up character vars
	for k, v in SortedPairsByMemberValue(ix.char.vars, "index") do
		if (!v.bNoDisplay and k != "__SortedIndex") then
			local container = self:GetContainerPanel(v.category or "description")

			if (v.ShouldDisplay and v:ShouldDisplay(container, self.payload) == false) then
				continue
			end

			local panel

			-- if the var has a custom way of displaying, we'll use that instead
			if (v.OnDisplay) then
				--if v.field == "model" then continue end
				panel = v:OnDisplay(container, self.payload)
			elseif (isstring(v.default)) then
				panel = container:Add("DTextEntry")
				panel:Dock(TOP)
				panel:SetFont("ixMenuButtonHugeFont")
				panel:SetUpdateOnType(true)
				panel:SetSize(ScrW() * .1, ScrH() * .05)
				panel.OnValueChange = function(this, text)
					self.payload:Set(k, text)
				end

				panel.Paint = function(this,w,h)
					surface.SetDrawColor(20, 20, 20)
					surface.DrawRect(0, 0, w, h)
					this:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
				end
			end

			if (IsValid(panel)) then
				if k == "model" then continue end
				-- add label for entry
				local label = container:Add("DLabel")
				label:SetFont("ixMenuButtonLabelFont")
				label:SetText(L(k):utf8upper())
				label:SizeToContents()
				label:DockMargin(0, -2, 0, -8)
				label:Dock(TOP)
				label:SetSize(ScrW() * .1, ScrH() * .05)

				label.Paint = function(this,w,h)
					local tw, th = surface.GetTextSize( this:GetText() )
					if k == "name" then
						-- DownloadIconFromURL("https://i.imgur.com/epPIR23.png", function(person)
						-- 	surface.SetDrawColor( 255, 255, 255)
						-- 	surface.SetMaterial(person)
						-- 	surface.DrawTexturedRect( tw*.35, h *.2, w *.07, h*.58 )
						-- end)
					elseif k == "description" then
						-- DownloadIconFromURL("https://i.imgur.com/xnpppaf.png", function(person)
						-- 	surface.SetDrawColor( 255, 255, 255)
						-- 	surface.SetMaterial(person)
						-- 	surface.DrawTexturedRect( tw*.32, h *.2, w *.07, h*.58 )
						-- end)
					else
						draw.SimpleText("| "..L("model"):utf8upper(), "ixMenuButtonLabelFont", tw * .48, h*.22, Color(255,255,255), TEXT_ALIGN_CENTER) -- eto pizdec
					end
				end

				-- we need to set the docking order so the label is above the panel
				label:SetZPos(zPos - 1)
				panel:SetZPos(zPos)

				self:AttachCleanup(label)
				self:AttachCleanup(panel)

				if (v.OnPostSetup) then
					v:OnPostSetup(panel, self.payload)
				end

				zPos = zPos + 2
			end
		end
	end

	if (!self.bInitialPopulate) then
		-- setup progress bar segments
		if (#self.factionButtons > 1) then
			self.progress:AddSegment("@faction")
		end

		self.progress:AddSegment("@description")

		-- we don't need to show the progress bar if there's only one segment
		if (#self.progress:GetSegments() == 1) then
			self.progress:SetVisible(false)
		end
	end

	self.bInitialPopulate = true
end

function PANEL:VerifyProgression(name)
	for k, v in SortedPairsByMemberValue(ix.char.vars, "index") do
		if (name ~= nil and (v.category or "description") != name) then
			continue
		end

		local value = self.payload[k]

		if (!v.bNoDisplay or v.OnValidate) then
			if (v.OnValidate) then
				local result = {v:OnValidate(value, self.payload, LocalPlayer())}

				if (result[1] == false) then
					self:GetParent():ShowNotice(3, L(unpack(result, 2)))
					return false
				end
			end

			self.payload[k] = value
		end
	end

	return true
end

function PANEL:Paint(width, height)
	DownloadIconFromURL("https://i.imgur.com/Ahcl4qk.png", function(person)
		surface.SetDrawColor( 255, 255, 255)
		surface.SetMaterial(person)
		surface.DrawTexturedRect( 0, 0, width, height )
	end)
end

vgui.Register("ixCharMenuNew", PANEL, "ixCharMenuPanel")
