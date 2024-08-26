surface.CreateFont("StalkerUI-400-16", {
	font = "Capture Smallz",
	size = ScreenScale(20 / 3),
	weight = 400,
	extended = true
})

local function drawline(x, y, w, h)
	draw.NoTexture()
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( x, y, w, h )
end

local PANEL = {}

AccessorFunc(PANEL, "bReadOnly", "ReadOnly", FORCE_BOOL)

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:SetTitle("")
	self:MakePopup()
	self:Center()
	self:ShowCloseButton(false)

	local leftpanel = self:Add("DPanel")
	leftpanel:SetWide(self:GetWide() * .35)
	leftpanel:Dock(LEFT)

	leftpanel.Paint = function(this, w, h)
		drawline(w * .004, 0, w * .003, h * .21)
		drawline(w * .572, 0, w * .003, h * .21)
		drawline(2, 0, w * .572, h * .003)
		drawline(2, h * .209, w * .572, h * .003)

		drawline(w * .004, h * .237, w * .995, h * .003)
		drawline(w * .004, h * .97, w * .995, h * .003)
		drawline(w * .004, h * .237, w * .003, h * .735)
		drawline(w * .995, h * .237, w * .003, h * .735)
	end

	local centerpanel = self:Add("DPanel")
	centerpanel:SetWide(self:GetWide() * .295)
	centerpanel:Dock(LEFT)
	centerpanel:SetPaintBackground(false)

	local rightpanel = self:Add("DPanel")
	rightpanel:SetWide(self:GetWide() * .35)
	rightpanel:Dock(RIGHT)

	rightpanel.Paint = function(this, w, h)
		drawline(w * .004, 0, w * .003, h * .21)
		drawline(w * .572, 0, w * .003, h * .21)
		drawline(2, 0, w * .572, h * .003)
		drawline(2, h * .209, w * .572, h * .003)

		drawline(w * .004, h * .237, w * .995, h * .003)
		drawline(w * .004, h * .97, w * .995, h * .003)
		drawline(w * .004, h * .237, w * .003, h * .735)
		drawline(w * .996, h * .237, w * .003, h * .735)
	end

	local headerleft = leftpanel:Add("DPanel")
	headerleft:SetTall(self:GetTall() * .2)
	headerleft:DockMargin(4, 2, self:GetWide() * .15, 0)
	headerleft:Dock(TOP)

	headerleft.Paint = function(this,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))

		draw.RoundedBox(0, w * .5, h * .7, w * .5, h * .3, Color(0, 0, 0))

		drawline(w * .5, h * .7, w * .5, h * .01)
		drawline(w * .5, h * .7, w * .007, h)

		surface.SetMaterial( Material("metroui/moneyicon") )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( w * .85, h *.75, w * .1, h * .2 )
	end

	self.vendorName = headerleft:Add("DLabel")
	self.vendorName:Dock(TOP)
	self.vendorName:DockMargin(self:GetWide() * .07, self:GetTall() * .03, 0, 0)
	self.vendorName:SetText("John Doe")
	self.vendorName:SetTextInset(4, 0)
	self.vendorName:SetTextColor(color_white)
	self.vendorName:SetFont("StalkerUI-400-16")

	self.vendorCurrency = headerleft:Add("DLabel")
	self.vendorCurrency:Dock(BOTTOM)
	self.vendorCurrency:DockMargin(self:GetWide() * .13, 0, 0, self:GetTall() * .02)
	self.vendorCurrency:SetText("0")
	self.vendorCurrency:SetTextInset(4, 0)
	self.vendorCurrency:SetTextColor(color_white)
	self.vendorCurrency:SetFont("StalkerUI-400-16")

	local headerright = rightpanel:Add("DPanel")
	headerright:SetTall(self:GetTall() * .2)
	headerright:DockMargin(4, 2, self:GetWide() * .15, 0)
	headerright:Dock(TOP)

	headerright.Paint = function(this,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))

		draw.RoundedBox(0, w * .5, h * .7, w * .5, h * .3, Color(0, 0, 0))

		drawline(w * .5, h * .7, w * .5, h * .01)
		drawline(w * .5, h * .7, w * .007, h)

		surface.SetMaterial( Material("metroui/moneyicon") )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( w * .85, h *.75, w * .1, h * .2 )
	end

	self.ourName = headerright:Add("DLabel")
	self.ourName:Dock(TOP)
	self.ourName:DockMargin(self:GetWide() * .07, self:GetTall() * .03, 0, 0)
	self.ourName:SetText(L"you")
	self.ourName:SetTextInset(4, 0)
	self.ourName:SetTextColor(color_white)
	self.ourName:SetFont("StalkerUI-400-16")

	self.ourCurrency = headerright:Add("DLabel")
	self.ourCurrency:Dock(BOTTOM)
	self.ourCurrency:DockMargin(self:GetWide() * .13, 0, 0, self:GetTall() * .02)
	self.ourCurrency:SetText(LocalPlayer():GetCharacter():GetMoney())
	self.ourCurrency:SetTextInset(4, 0)
	self.ourCurrency:SetTextColor(color_white)
	self.ourCurrency:SetFont("StalkerUI-400-16")


	self.itemuseful = centerpanel:Add("DPanel")
	self.itemuseful:SetTall(self:GetTall() * .8)
	self.itemuseful:Dock(TOP)
	self.itemuseful:SetPaintBackground(false)

	self.itemuseful.Paint = function(this, w, h)
		
		drawline(w * .012, h * .673, w * .98, h * .004)
		drawline(w * .012, h * .926, w * .98, h * .004)
		drawline(w * .012, h * .673, w * .006, h * .255)
		drawline(w * .985, h * .673, w * .006, h * .255)

		draw.RoundedBox(0, w * .032, h *.012, w * .935 , h * .628, Color(0, 0, 0, 250))

		surface.SetMaterial( Material("mutantsimgs/hexagon3.png") )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( w *.032, h * .012, w * .945, h *.63 )

		drawline(w *.03, h * .009, w * .945, h * .004)
		drawline(w *.03, h * .637, w * .945, h * .004)
		drawline(w *.03, h * .01, w * .006, h * .63)
		drawline(w *.968, h * .01, w * .006, h * .63)

	end

	self.itemlookup = self.itemuseful:Add("ixModelPanel")
	self.itemlookup:SetTall(self:GetTall() * .5)
	self.itemlookup:DockMargin(self:GetWide() * .01, self:GetTall() * .01, self:GetWide() * .01, 0)
	self.itemlookup:Dock(TOP)

	self.itemlookup.LayoutEntity = function(this, ent)
		ent:SetAngles(Angle(0, RealTime()*50,  0))
	end

	self.itemdesc = self.itemuseful:Add("RichText")
	self.itemdesc:SetTall(self:GetTall() * .2)
	self.itemdesc:DockMargin(self:GetWide() * .005, 0, self:GetWide() * .005, self:GetTall() * .06)
	self.itemdesc:Dock(BOTTOM)
	self.itemdesc.PerformLayout = function(this)
		this:SetFontInternal( "StalkerUI-400-16" )
		this:SetFGColor( Color(255, 255, 255) )
	end

	self.itemdesc.Paint = function(this,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))
	end
	
	local footer = centerpanel:Add("DPanel")
	footer:SetTall(self:GetTall() * .15)
	footer:Dock(BOTTOM)
	footer:DockMargin(0, 0, 0, self:GetTall() * .028)
	footer:SetPaintBackground(false)

	self.Closebutton = footer:Add("DButton")
	self.Closebutton:SetFont("StalkerUI-400-16")
	self.Closebutton:SetTall(self:GetTall() * .09)
	self.Closebutton:Dock(BOTTOM)
	self.Closebutton:DockMargin(0, self:GetTall() * .025, 0, 0)
	self.Closebutton:SetText(L"Закрыть")
	self.Closebutton:SetTextColor(color_white)
	self.Closebutton.DoClick = function(this)
		self:Close()
	end

	self.Closebutton.Paint = function(this,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))

		drawline(0, 0, w * .01, h)
		drawline(w * .992, 0, w * .01, h)
		drawline(0, 0, w, h *.06)
		drawline(0, h *.95, w, h *.06)
	end

	self.vendorSell = footer:Add("DButton")
	self.vendorSell:SetFont("StalkerUI-400-16")
	self.vendorSell:SetWide(self:GetWide() * .14)
	self.vendorSell:Dock(LEFT)
	self.vendorSell:SetContentAlignment(5)
	-- The text says purchase but the vendor is selling it to us.
	self.vendorSell:SetText(L"purchase")
	self.vendorSell:SetTextColor(color_white)

	self.vendorSell.DoClick = function(this)
		if (IsValid(self.activeSell)) then
			net.Start("ixVendorTrade")
				net.WriteString(self.activeSell.item)
				net.WriteBool(false)
			net.SendToServer()
		end
	end

	self.vendorSell.Paint = function(this, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))

		drawline(0, 0, w * .01, h)
		drawline(w * .995, 0, w * .01, h)
		drawline(0, 0, w, h *.06)
		drawline(0, h *.95, w, h *.06)
	end

	self.vendorBuy = footer:Add("DButton")
	self.vendorBuy:SetFont("StalkerUI-400-16")
	self.vendorBuy:SetWide(self:GetWide() * .14)
	self.vendorBuy:Dock(RIGHT)
	self.vendorBuy:SetContentAlignment(5)
	self.vendorBuy:SetText(L"sell")
	self.vendorBuy:SetTextColor(color_white)
	self.vendorBuy.DoClick = function(this)
		if (IsValid(self.activeBuy)) then
			net.Start("ixVendorTrade")
				net.WriteString(self.activeBuy.item)
				net.WriteBool(true)
			net.SendToServer()
		end
	end

	self.vendorBuy.Paint = function(this, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))

		drawline(0, 0, w * .01, h)
		drawline(w * .995, 0, w * .01, h)
		drawline(0, 0, w, h *.06)
		drawline(0, h *.95, w, h *.06)
	end

	self.selling = leftpanel:Add("DScrollPanel")
	self.selling:SetWide(self:GetWide() * 0.346)
	self.selling:Dock(LEFT)
	self.selling:DockMargin(4, self:GetTall() * .03, 0, self:GetTall() * .03)
	self.selling:SetPaintBackground(true)

	self.selling.Paint = function(this,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))
		surface.SetMaterial( Material("mutantsimgs/hexagon3.png") )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0, 0, w, h )
	end

	self.sellingItems = self.selling:Add("DListLayout")
	self.sellingItems:SetSize(self.selling:GetSize())
	self.sellingItems:DockPadding(0, 0, 0, 4)
	self.sellingItems:SetTall(ScrH())

	self.buying = rightpanel:Add("DScrollPanel")
	self.buying:SetWide(self:GetWide() * 0.346)
	self.buying:Dock(LEFT)
	self.buying:DockMargin(4, self:GetTall() * .03, 0, self:GetTall() * .03)
	self.buying:SetPaintBackground(true)

	self.buying.Paint = function(this,w,h)

		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))
		surface.SetMaterial( Material("mutantsimgs/hexagon3.png") )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0, 0, w, h )
	end

	self.buyingItems = self.buying:Add("DListLayout")
	self.buyingItems:SetSize(self.buying:GetSize())
	self.buyingItems:DockPadding(0, 0, 0, 4)

	self.sellingList = {}
	self.buyingList = {}
end

function PANEL:addItem(uniqueID, listID)
	local entity = self.entity
	local items = entity.items
	local data = items[uniqueID]

	if ((!listID or listID == "selling") and !IsValid(self.sellingList[uniqueID])
	and ix.item.list[uniqueID]) then
		if (data and data[VENDOR_MODE] and data[VENDOR_MODE] != VENDOR_BUYONLY) then
			local item = self.sellingItems:Add("ixVendorItem")
			item:Setup(uniqueID)

			self.sellingList[uniqueID] = item
			self.sellingItems:InvalidateLayout()
		end
	end

	if ((!listID or listID == "buying") and !IsValid(self.buyingList[uniqueID])
	and LocalPlayer():GetCharacter():GetInventory():HasItem(uniqueID)) then
		if (data and data[VENDOR_MODE] and data[VENDOR_MODE] != VENDOR_SELLONLY) then
			local item = self.buyingItems:Add("ixVendorItem")
			item:Setup(uniqueID)
			item.isLocal = true

			self.buyingList[uniqueID] = item
			self.buyingItems:InvalidateLayout()
		end
	end
end

function PANEL:removeItem(uniqueID, listID)
	if (!listID or listID == "selling") then
		if (IsValid(self.sellingList[uniqueID])) then
			self.sellingList[uniqueID]:Remove()
			self.sellingItems:InvalidateLayout()
		end
	end

	if (!listID or listID == "buying") then
		if (IsValid(self.buyingList[uniqueID])) then
			self.buyingList[uniqueID]:Remove()
			self.buyingItems:InvalidateLayout()
		end
	end
end

function PANEL:Setup(entity)
	self.entity = entity
	self:SetTitle(entity:GetDisplayName())
	self.vendorName:SetText(entity:GetDisplayName())
	self.vendorCurrency:SetText(entity.money or "")

	self.ourName:SetText(L"you")
	self.ourCurrency:SetText(LocalPlayer():GetCharacter():GetMoney())

	self.vendorBuy:SetEnabled(!self:GetReadOnly())
	self.vendorSell:SetEnabled(!self:GetReadOnly())

	for k, _ in SortedPairs(entity.items) do
		self:addItem(k, "selling")
	end

	for _, v in SortedPairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
		self:addItem(v.uniqueID, "buying")
	end
end

function PANEL:OnRemove()
	net.Start("ixVendorClose")
	net.SendToServer()

	if (IsValid(ix.gui.vendorEditor)) then
		ix.gui.vendorEditor:Remove()
	end
end

function PANEL:Think()
	local entity = self.entity

	if (!IsValid(entity)) then
		self:Remove()

		return
	end

	if ((self.nextUpdate or 0) < CurTime()) then
		self:SetTitle(self.entity:GetDisplayName())
		self.vendorName:SetText(entity:GetDisplayName())
		self.vendorCurrency:SetText(entity.money or "")

		self.ourName:SetText(L"you")
		self.ourCurrency:SetText(LocalPlayer():GetCharacter():GetMoney())

		self.nextUpdate = CurTime() + 0.25
	end
end

function PANEL:OnItemSelected(panel)
	local price = self.entity:GetPrice(panel.item, panel.isLocal)
	local origitem = ix.item.Get(panel.item)


	if (panel.isLocal) then
		self.vendorBuy:SetText(L"sell".." ("..ix.currency.Get(price)..")")
		
		self.itemdesc:SetText(origitem.description)
		self.itemlookup:SetModel(origitem:GetModel(), origitem:GetSkin() or 0)
		local ent = self.itemlookup:GetEntity()
		local pos = ent:GetPos()
		local tab = PositionSpawnIcon(ent, pos)

		if ( tab ) then
			self.itemlookup:SetCamPos(tab.origin)
			self.itemlookup:SetFOV(tab.fov)
			self.itemlookup:SetLookAng(tab.angles)
		end

	else
		self.vendorSell:SetText(L"purchase".." ("..ix.currency.Get(price)..")")

		self.itemdesc:SetText(origitem.description)
		self.itemlookup:SetModel(origitem:GetModel(), origitem:GetSkin() or 0)
		local ent = self.itemlookup:GetEntity()
		local pos = ent:GetPos()
		local tab = PositionSpawnIcon(ent, pos)
		if ( tab ) then
			self.itemlookup:SetCamPos(tab.origin)
			self.itemlookup:SetFOV(tab.fov)
			self.itemlookup:SetLookAng(tab.angles)
		end

	end
end

function PANEL:Paint(w, h)
	ix.util.DrawBlur(self, 5)

	surface.SetMaterial( Material("mutantsimgs/bgven1.png") )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( 0, 0, w, h )
end


vgui.Register("ixVendor", PANEL, "DFrame")

PANEL = {}

function PANEL:Init()
	self:SetTall(36)
	self:DockMargin(4, 4, 4, 0)

	self.icon = self:Add("SpawnIcon")
	self.icon:SetPos(2, 2)
	self.icon:SetSize(32, 32)
	self.icon:SetModel("models/error.mdl")

	self.name = self:Add("DLabel")
	self.name:Dock(FILL)
	self.name:DockMargin(42, 0, 0, 0)
	self.name:SetFont("StalkerUI-400-16")
	self.name:SetTextColor(color_white)
	self.name:SetExpensiveShadow(1, Color(0, 0, 0, 200))

	self.click = self:Add("DButton")
	self.click:Dock(FILL)
	self.click:SetText("")
	self.click.Paint = function() end
	self.click.DoClick = function(this)
		if (self.isLocal) then
			ix.gui.vendor.activeBuy = self
		else
			ix.gui.vendor.activeSell = self
		end

		ix.gui.vendor:OnItemSelected(self)
	end
end

function PANEL:SetCallback(callback)
	self.click.DoClick = function(this)
		callback()
		self.selected = true
	end
end

function PANEL:Setup(uniqueID)
	local item = ix.item.list[uniqueID]

	if (item) then
		self.item = uniqueID
		self.icon:SetModel(item:GetModel(), item:GetSkin())
		self.name:SetText(item:GetName())
		self.itemName = item:GetName()

		self.click:SetHelixTooltip(function(tooltip)
			ix.hud.PopulateItemTooltip(tooltip, item)

			local entity = ix.gui.vendor.entity
			if (entity and entity.items[self.item] and entity.items[self.item][VENDOR_MAXSTOCK]) then
				local info = entity.items[self.item]
				local stock = tooltip:AddRowAfter("name", "stock")
				stock:SetText(string.format("Stock: %d/%d", info[VENDOR_STOCK], info[VENDOR_MAXSTOCK]))
				stock:SetBackgroundColor(derma.GetColor("Info", self))
				stock:SizeToContents()
			end
		end)
	end
end

function PANEL:Think()
	if ((self.nextUpdate or 0) < CurTime()) then
		local entity = ix.gui.vendor.entity

		if (entity and self.isLocal) then
			local count = LocalPlayer():GetCharacter():GetInventory():GetItemCount(self.item)

			if (count == 0) then
				self:Remove()
			end
		end

		self.nextUpdate = CurTime() + 0.1
	end
end

function PANEL:Paint(w, h)
	if (ix.gui.vendor.activeBuy == self or ix.gui.vendor.activeSell == self) then
		surface.SetDrawColor(ix.config.Get("color"))
	else
		surface.SetDrawColor(0, 0, 0, 100)
	end

	surface.DrawRect(0, 0, w, h)
end

vgui.Register("ixVendorItem", PANEL, "DPanel")
