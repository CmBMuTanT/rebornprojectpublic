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
	self.bet = 0
end

function PANEL:Paint(w, h)
	draw.RoundedBox(10, 0, 0, w, h, Color(25, 25, 25, 240))
	draw.RoundedBox(10, 0, 0, w, h * .1, Color(25, 25, 25, 230))

	draw.SimpleText("Угадайте где находится шарик для победы", "Provod_Thintext", w * .5, h * .1, Color(255, 255, 255), TEXT_ALIGN_CENTER)

	draw.SimpleText("Ваша ставка: "..self.bet, "Provod_Thintext", w * .5, h * .15, Color(255, 255, 255), TEXT_ALIGN_CENTER)
end

function PANEL:SetBet(coins)
	self.bet = coins

	local x = self:GetWide() * .04

	local tbl = {
		Color(255, 0, 0),
		Color(0, 255, 0),
		Color(0, 0, 255),
		Color(255, 255, 0),
		Color(255, 0, 255),
		Color(0, 255, 255),
		Color(255, 255, 255),
		Color(0, 0, 0),
	}

	for i=1, 3 do
		self.thimbles = self:Add("DModelPanel")
		self.thimbles:SetSize(self:GetWide() * 0.3, self:GetTall() * 0.5)
		self.thimbles:SetModel("models/props_junk/terracotta01.mdl")
		self.thimbles:SetPos(x, self:GetTall() * .25)

		local center = Vector(0, 0, 0)
		local sideView = Vector(1, 0, 0)
		
		self.thimbles:SetLookAt(center + sideView)
		self.thimbles:SetCamPos(center + sideView * 30)
		self.thimbles.LayoutEntity = function(this, ent)
			ent:SetPos(Vector(0, 0, 5))
			ent:SetAngles(Angle(0, 0, 180))
		end

		self.thimbles.Entity:SetMaterial("models/debug/debugwhite")
		self.thimbles:SetColor(tbl[math.random(#tbl)])

		x = x + self:GetWide() * 0.31

		self.thimbles.DoClick = function(this)
			netstream.Start("Thimbles:Bet", i, self.bet)
			if IsValid(self) then
				self:Close()
			end
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
		netstream.Start("Thimbles:Bet", 0, self.bet)
		self:Close()
	end
end

vgui.Register("CMBMTK:THIMBLES", PANEL, "DFrame")
