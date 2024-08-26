
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

function PANEL:Init()
    self:SetSize(ScrW() * 0.5, ScrH() * .6)
    self:MakePopup()
    self:Center()
    self:SetTitle("")
	self:ShowCloseButton(false)
    self.mouses = {}

	self.closebtn = self:Add("DButton")
	self.closebtn:SetSize(self:GetWide() * .09, self:GetTall() * .1)
	self.closebtn:SetPos(self:GetWide() * .92, 0)
	self.closebtn:SetText("")

	self.closebtn.Paint = function(this, w, h)
		draw.DrawText("X", "Provod_ThinX", w * .52, h * .05, Color(150, 150, 150), TEXT_ALIGN_CENTER)
	end

	self.closebtn.DoClick = function(this)
		self:Close()
	end
end


function PANEL:Paint(w, h)
	draw.RoundedBox(10, 0, 0, w, h, Color(25, 25, 25, 240))
	draw.RoundedBox(10, 0, 0, w, h * .05, Color(25, 25, 25, 230))
    draw.RoundedBox(10, 0, h * .965, w, h * .04, Color(25, 25, 25, 230))

    ------
    draw.RoundedBox(0, 0, h * .35, w, h * .01, Color(25, 25, 25, 230))
    draw.RoundedBox(0, 0, h * .658, w, h * .01, Color(25, 25, 25, 230))
    draw.RoundedBox(0, w * .25, h * .05, w * .005, h * .92, Color(25, 25, 25, 230))
    -----
end

function PANEL:SetMouses(mouses, mousessync)
    self.mouses = mouses
    self.mousessync = mousessync

    local y = self:GetTall() * .05

    for k, v in SortedPairs(self.mousessync) do
        if self.mouses[k] then
            self.MouZBG = self:Add("EditablePanel")
            self.MouZBG:SetSize(self:GetWide() * 0.25, self:GetTall() * 0.3)
            self.MouZBG:SetPos(0, y)

            self.MouZBG.Paint = function(this, w, h)
                draw.RoundedBox(10, 0, 0, w, h, Color(173, 95, 0, 50))

                draw.SimpleText(v.name, "Provod_Thintext", w * .4, h * .1, Color(255, 255, 255), TEXT_ALIGN_LEFT)
                draw.SimpleText("НАЖМИТЕ ДАБЫ СДЕЛАТЬ СТАВКУ", "Provod_Thintext", w * .05, h * .8, Color(255, 255, 255), TEXT_ALIGN_LEFT)
            end

            self.MouZDetails = self:Add("EditablePanel")
            self.MouZDetails:SetSize(self:GetWide() * 0.75, self:GetTall() * 0.3)
            self.MouZDetails:SetPos(self:GetWide() * .255, y)

            self.MouZDetails.Paint = function(this, w, h)
                draw.RoundedBox(10, 0, 0, w, h, Color(255, 95, 0, 50))

                local richtext = this:Add("RichText")
                richtext:SetSize(w, h * .6)
                richtext:AppendText(v.description)
                richtext:SetVerticalScrollbarEnabled(false)
                function richtext:PerformLayout()
                    self:SetFontInternal( "ChatFont" )
                    self:SetFGColor( color_white ) 
                end

                
                draw.SimpleText("Побед: "..v.wins, "Provod_Thintext", w * .05, h * .6, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            end

            self.MouZicon = self:Add("DModelPanel")
            self.MouZicon:SetSize(self:GetWide() * 0.25, self:GetTall() * 0.3)
            self.MouZicon:SetModel("models/alieneer2/rat.mdl")
            self.MouZicon:SetPos(0, y)

            local center = Vector(0, 0, 0)
            local min, max = self.MouZicon.Entity:GetRenderBounds()
            local centerPos = (min + max) * 3

            self.MouZicon:SetLookAt(center)
            self.MouZicon:SetCamPos(centerPos)
            self.MouZicon.Entity:SetSkin(v.skinnum)

            y = y + self:GetTall() * 0.3 + (self:GetTall() * 0.009)

            self.MouZicon.DoClick = function(this)
                Derma_StringRequest(
                "Ставка", 
                "Введите ставку",
                "1",
                function(bet) 
                    if !isnumber(tonumber(bet)) then LocalPlayer():Notify("Ставка должна быть числом или цифрой!") return end
                    if tonumber(bet) <= 0 then client:Notify("MouseRuns ERROR#1 Некорректная ставка!") return end
                    netstream.Start("MouseRun:Bet", self.mouses[k], bet)
                    if IsValid(self) then
                        self:Close()
                    end
                end
                )
            end
        end
    end
end

vgui.Register("CMBMTK:MOUSEMENU", PANEL, "DFrame")
