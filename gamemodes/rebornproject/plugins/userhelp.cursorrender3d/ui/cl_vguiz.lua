local PANEL = {}

surface.CreateFont( "CURSORVGUIFONT", {
	font = "Arial",
	extended = false,
	size = 15,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function PANEL:Init()

    self:SetPaintedManually(true)
    self:SetX(-150)
    self:SetY(60)
    self:SetWide(300)
    self:SetTall(50)

    self.mainpanel = self:Add("DPanel")
	self.mainpanel:Dock(FILL)
    self.mainpanel.Paint = function(this, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color( 85, 85, 85, 100) )
        surface.SetDrawColor( 0, 0, 0, 150)
        surface.DrawOutlinedRect( 0, 0, w, h, 1)
    end



    self.label = self.mainpanel:Add("DLabel")
    self.label:Dock(FILL)
    self.label:DockMargin(-55,0,0,0) -- ооо да двигаем текст заебись ваще
    self.label:SizeToContents()
    self.label:SetSize(10, 10)
    self.label:SetFont("CURSORVGUIFONT")


end

function PANEL:Paint( w, h )

end

function PANEL:SetText(text)
	self.label:SetText(text)
end

function PANEL:SetColor(col)
    self.label:SetColor(col)
end


vgui.Register( "Panel3D2D2D", PANEL, "Panel" )