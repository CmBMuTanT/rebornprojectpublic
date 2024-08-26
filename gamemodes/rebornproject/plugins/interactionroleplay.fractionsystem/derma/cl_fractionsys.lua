local PLUGIN = PLUGIN

surface.CreateFont("FractionFontUImini", {font = "roboto", size = ScreenScale(4), extended = true, weight = 100})
surface.CreateFont("FractionFontUIsmall", {font = "roboto", size = ScreenScale(6), extended = true, weight = 100})
surface.CreateFont("FractionFontUIsmallstandart", {font = "roboto", size = ScreenScale(14), extended = true, weight = 100})
surface.CreateFont("FractionFontUIstandart-", {font = "roboto", size = ScreenScale(12), extended = true, weight = 100})
surface.CreateFont("FractionFontUIstandart", {font = "roboto", size = ScreenScale(16), extended = true, weight = 100})
surface.CreateFont("FractionFontUIlarge", {font = "roboto", size = ScreenScale(32), extended = true, weight = 100})

local function createbox(x, y, w, h, col)
    surface.SetDrawColor(col)
    surface.DrawRect(x,y,w,h)
end

local PANEL = {}

function PANEL:Init()
	self.TabButtons = {}
	self.wide = ScrW()
	self.tall = ScrH()

	self:Dock(FILL)
	self:MakePopup()

	--Close Button
	self.CloseButton = self:Add("DButton")
	self.CloseButton:SetText( "" )
	self.CloseButton.DoClick = function(this)
		self:OnClose()
	end
	self.CloseButton.Paint = function(this, w, h)
		surface.SetDrawColor(200, 0, 0)
		surface.DrawRect(0, 0, w, h)
		draw.SimpleText("X", "FractionFontUIsmall", w *.5, h *.5, Color(255, 255, 255), 1, 1)
	end
	--
end

function PANEL:OnClose()
	if IsValid(self) then
		self:Remove()
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(51,51,51)
    surface.DrawRect(0, 0, w, h)

	self.CloseButton:SetPos( w * .9740, h * .01 ) --9739
    self.CloseButton:SetSize( w * .02, h * .025 )	

	createbox(0, 0, w, h * .01, Color(255, 255, 255))
	createbox(0, h * .1, w, h * .01, Color(255, 255, 255))
	createbox(0, h * .6, w * .7, h * .01, Color(255, 255, 255))
	createbox(0, h * .992, w, h * .01, Color(255, 255, 255))

	createbox(0, 0, h * .01, h, Color(255, 255, 255))
	createbox(w * .7, h * .12, h * .01, h * .865, Color(255, 255, 255))
	createbox(w * .994, 0, h * .01, h, Color(255, 255, 255))
	---TEXT---
	draw.SimpleText("ПАНЕЛЬ УПРАВЛЕНИЯ", "FractionFontUIlarge", w *.5, h *.06, Color(255, 255, 255), 1, 1)

	draw.SimpleText("Принадлежит: "..team.GetName(self.entity:GetFraction()), "FractionFontUIstandart", w *.05, h *.15, Color(255, 255, 255), 0, 1)
	draw.SimpleText("Сейчас на службе: "..team.NumPlayers(self.entity:GetFraction()), "FractionFontUIsmall", w *.06, h *.19, Color(255, 255, 255), 0, 1)
	draw.SimpleText("Склад: "..self.entity:GetCurrStorage().."/"..self.entity:GetMaxStorage().." (Пассивный доход: "..self.entity:GetPassiveIncome().." Пуль/30c.)", "FractionFontUIsmall", w *.06, h *.22, Color(255, 255, 255), 0, 1)

	
	draw.SimpleText("Отношение между фракциями", "FractionFontUIsmallstandart", w *.85, h *.135, Color(255, 255, 255), 1, 1)
	---TEXT---

	
end

local relationshipmaterials = {
    ["WAR"] = {
        icon = "cmbmtk_fractiondesk/war.png",
        color = Color(200, 0, 0),
    },
    ["ALLIANCE"] = {
        icon = "cmbmtk_fractiondesk/alliance.png",
        color = Color(0, 200, 0),
    },
    ["NEUTRAL"] = {
        icon = "cmbmtk_fractiondesk/equal.png",
        color = Color(255, 255, 255),
    },
}

function PANEL:Setup(entity)
	local y = 0
	local yy = 0
	self.entity = entity


	for k,v in SortedPairs(PLUGIN.Buttons) do
		self.UpgradeButtons = self:Add("DButton")
		self.UpgradeButtons:SetText("")
		self.UpgradeButtons:SetSize(self.wide * .11, self.tall * .05)
		self.UpgradeButtons:SetPos(self.wide *.59, self.tall * .12 + y )


		self.UpgradeButtons.DoClick = function(this)
			if v.derma then
				local menu = DermaMenu() 
				for k2,v2 in pairs(PLUGIN.Shipments) do
					menu:AddOption(k2, function() netstream.Start("fractionsystem::Buttons", self.entity, k, k2) end )
				end
				menu:Open()
			else
				netstream.Start("fractionsystem::Buttons", self.entity, k)

				if k == "OpenInv" or k == "OpenShop" then
					self:Remove()
				end
			end
		end

		self.UpgradeButtons.Paint = function(this, w, h)
			if this.Hovered then
				color = Color(200, 100, 0)
			else
				color = Color(255, 150, 0)
			end

			surface.SetDrawColor(color)
			surface.DrawRect(0, 0, w, h)
			draw.SimpleText(v.name, "FractionFontUIsmall", w *.5, h *.3, Color(255, 255, 255), 1, 1)

			if k ~= "OpenInv" and k ~= "OpenShop" then 
				local price = self.entity:GetNetVar(k) or v.price -- багует, исправить потом.
				draw.SimpleText("Цена: "..price, "FractionFontUImini", w *.5, h *.7, Color(255, 255, 255), 1, 1)
			end
		end
		y = y + ScreenScale(23)
	end

	local factions = ix.faction.indices
	for i = 1, #factions do
		if factions[self.entity:GetFraction()].name == factions[i].name then continue end
		self.RelationshipButtons = self:Add("DButton")
		self.RelationshipButtons:SetText("")
		self.RelationshipButtons:SetSize(self.wide * .275, self.tall * .06)
		self.RelationshipButtons:SetPos(self.wide *.71, self.tall * .185 + yy )

		self.RelationshipButtons.DoClick = function(this)
			local menu = DermaMenu() 
			for k,v in pairs(PLUGIN.RelationshipOpts) do
				menu:AddOption(k, function() netstream.Start("fractionsystem::Relationship", self.entity, factions[i].index, k) end )
			end
			menu:Open()
		end

		self.RelationshipButtons.Paint = function(this, w, h)
			if this.Hovered then
				color = Color(200, 100, 0)
			else
				color = Color(255, 150, 0)
			end

			surface.SetDrawColor(color)
			surface.DrawRect(0, 0, w, h)
			draw.SimpleText(factions[self.entity:GetFraction()].name, "FractionFontUIstandart-", w *.01, h *.5, Color(255, 255, 255), 0, 1)

			surface.SetDrawColor(relationshipmaterials[self.entity:GetNetVar(factions[i].name)].color)
			surface.SetMaterial( Material(relationshipmaterials[self.entity:GetNetVar(factions[i].name)].icon) )
			surface.DrawTexturedRect( w * .42, h * .1, ScreenScale(16), ScreenScale(16) )

			draw.SimpleText(factions[i].name, "FractionFontUIstandart-", w *.99, h *.5, Color(255, 255, 255), 2, 1)
		end

		yy = yy + ScreenScale(28)
	end

	self.PlayerPanel = self:Add("DScrollPanel")
	self.PlayerPanel:SetSize(self.wide * .69, self.tall * .36)
	self.PlayerPanel:SetPos(self.wide *.01, self.tall * .62)
	self.PlayerPanel.Paint = function(this, w, h)
		surface.SetDrawColor(22,22,22)
		surface.DrawRect(0, 0, w, h)
	end
	
	for k, v in pairs(player.GetAll()) do
		if v:Team() != self.entity:GetFraction() then continue end
		self.Players = self.PlayerPanel:Add("DButton")
		self.Players:Dock( TOP )
		self.Players:SetTall(self.PlayerPanel:GetTall() * .15)
		self.Players:SetText("")
		self.Players:DockMargin( 0, 0, 0, 5 )

		self.Players.DoClick = function(this)
			local menu = DermaMenu() 
			local subMenuRank, parentMenuOptionRank = menu:AddSubMenu("Изменить ранг игрока")
			parentMenuOptionRank:SetIcon("icon16/user_edit.png")
			
			for k2,v2 in SortedPairs(ix.faction.Get(self.entity:GetFraction()).Ranks) do
				subMenuRank:AddOption(v2[1], function() netstream.Start("fractionsystem::ChangeFraction", v, self.entity, k2) end)
			end

			menu:AddOption("Исключить игрока из фракции", function() netstream.Start("fractionsystem::Disqualify", v, self.entity) end )
			menu:AddOption("Изменить имя игрока", function() netstream.Start("fractionsystem::ChangeName", v, self.entity) end )

			menu:Open()
		end

		self.Players.Paint = function(this, w, h)
			if this.Hovered then
				color = Color(200, 100, 0)
			else
				color = Color(255, 150, 0)
			end
			surface.SetDrawColor(color)
			surface.DrawRect(0, 0, w, h)

			draw.SimpleText(v:Name(), "FractionFontUIstandart-", w *.06, h *.5, Color(255, 255, 255), 0, 1)

			local namesize = surface.GetTextSize(v:Name()) * 1.1
			local factionTable = ix.faction.Get(v:Team())
			local rankTable = factionTable.Ranks
			local character = v:GetCharacter()

			if rankTable then
				local rank = rankTable[character:GetRank()][1] ~= nil and rankTable[character:GetRank()][1] or "N/A"
				draw.SimpleText("| "..rank, "FractionFontUIstandart-", namesize + w *.06, h *.5, Color(255, 255, 255), 0, 1)
			end
		end
	end
end

vgui.Register("CMBMTK.fractionsystem", PANEL, "EditablePanel")
