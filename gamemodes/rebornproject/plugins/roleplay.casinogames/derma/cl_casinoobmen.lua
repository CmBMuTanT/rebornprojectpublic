local PLUGIN = PLUGIN

local PANEL = {}

surface.CreateFont( "Provod_ThinX", {
	font = "Roboto-Thin",
	extended = false,
	size = ScreenScale(8),
	weight = 1000,
} )

surface.CreateFont( "Provod_Thintext", {
	font = "Roboto-Thin",
	extended = false,
	size = ScreenScale(5),
	weight = 750,
} )

surface.CreateFont("MouseFonts", {
	font = "Capture Smallz",
	size = ScreenScale(8),
	weight = 1000,
	extended = true
})

surface.CreateFont("MouseFontstw", {
	font = "Capture Smallz",
	size = ScreenScale(5),
	weight = 750,
	extended = true
})


function PANEL:Init()
    self:SetSize(ScrW() * 0.4, ScrH() * 0.4)
    self:MakePopup()
    self:Center()
    self:SetTitle("")
	self:ShowCloseButton(false)

	self.items = {}

	self.CoinsPanel = self:Add("DScrollPanel")
	self.CoinsPanel:SetSize(self:GetWide() * .4, self:GetTall() * .55)
	self.CoinsPanel:SetPos(self:GetWide() * .55, self:GetTall() * .25)
	local CoinBar = self.CoinsPanel:GetVBar()

	CoinBar.btnGrip.Paint = function(this, w, h)
		draw.RoundedBox(10, 0, 0, w * .3, h, Color(255, 162, 0))
	end

	for name,count in SortedPairsByValue(PLUGIN.coinstable) do
		self.CoinButton = self.CoinsPanel:Add("DButton")
		self.CoinButton:SetTall(self:GetTall() * .1)
		self.CoinButton:Dock(TOP)
		self.CoinButton:SetText("")
		self.CoinButton:DockMargin( 0, 0, 0, 5 )

		self.CoinButton.Paint = function(this, w, h)
			if this.Hovered then
				color = Color(15, 15, 15, 250)
			else
				color = Color(50, 50, 50, 225)
			end
	
			draw.RoundedBox(10, 0, 0, w, h, color)
	
			draw.DrawText(name, "MouseFonts", w * .5, h * .25, Color(150, 150, 150), TEXT_ALIGN_CENTER)
		end

		self.CoinButton.DoClick = function(this)
			netstream.Start("Obmen:coins", name, count)
		end
	end

	self.closebtn = self:Add("DButton")
	self.closebtn:SetSize(self:GetWide() * .09, self:GetTall() * .1)
	self.closebtn:SetPos(self:GetWide() * .92, 0)
	self.closebtn:SetText("")

	self.closebtn.Paint = function(this, w, h)
		draw.DrawText("X", "MouseFonts", w * .52, h * .2, Color(150, 150, 150), TEXT_ALIGN_CENTER)
	end

	self.closebtn.DoClick = function(this)
		self:Close()
	end
end

function PANEL:Paint(w, h)
	draw.RoundedBox(10, 0, 0, w, h, Color(25, 25, 25, 240))
	draw.RoundedBox(10, 0, 0, w, h * .1, Color(25, 25, 25, 230))
	draw.RoundedBox(0, w * .5, h * .1, w * .01, h * .9, Color(25, 25, 25, 230))
	
	draw.DrawText("1 Монета = 1 Пачка Рублей", "MouseFonts", w * .56, h * .15, Color(150, 150, 150), TEXT_ALIGN_LEFT)
	draw.DrawText("Имеется в наличии", "MouseFonts", w * .1, h * .15, Color(150, 150, 150), TEXT_ALIGN_LEFT)

end

function PANEL:SetItems(tbl)
	self.items = tbl

	self.ItemsPanel = self:Add("DScrollPanel")
	self.ItemsPanel:SetSize(self:GetWide() * .4, self:GetTall() * .55)
	self.ItemsPanel:SetPos(self:GetWide() * .05, self:GetTall() * .25)

	local ItemsBar = self.ItemsPanel:GetVBar()

	ItemsBar.btnGrip.Paint = function(this, w, h)
		draw.RoundedBox(10, 0, 0, w * .3, h, Color(255, 162, 0))
	end

	for _,data in pairs(self.items) do
		self.ItemsButton = self.ItemsPanel:Add("DButton")
		self.ItemsButton:SetTall(self:GetTall() * .11)
		self.ItemsButton:Dock(TOP)
		self.ItemsButton:SetText("")
		self.ItemsButton:DockMargin( 0, 0, 0, 5 )

		local itemuid = ix.item.list[data.item]

		self.ItemsButton.Paint = function(this, w, h)
			if this.Hovered then
				color = Color(15, 15, 15, 250)
			else
				color = Color(50, 50, 50, 225)
			end
	
			draw.RoundedBox(10, 0, 0, w, h, color)
	
			draw.DrawText(itemuid.name, "MouseFontstw", w * .1, h * .25, Color(150, 150, 150), TEXT_ALIGN_LEFT)
			draw.DrawText("(Цена: "..data.count.." )", "MouseFontstw", w * .1, h * .5, Color(150, 150, 150), TEXT_ALIGN_LEFT)
		end

		self.ItemsButton.DoClick = function(this)
			netstream.Start("Obmen:Item", data.item, data.count)
		end
	end
end

vgui.Register("CMBMTK:NPCOBMENNIK", PANEL, "DFrame")
