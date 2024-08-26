surface.CreateFont("PassportfontUI", {
	font = "TrixieCyr-Light",
	size = ScreenScale(19 / 3),
	weight = 400,
	extended = true
})


local PANEL = {}

local function Scale(size)
    return ScrH() / 1080 * size
end

function PANEL:Init(parent)
    self:SetTall(ScrH() * .2)

    self.dayPanel, self.dayNumber = self:AddNumberPanel(1, 1, 31)
    self.monthPanel, self.monthNumber = self:AddNumberPanel(1, 1, 12)
    self.yearPanel, self.yearNumber = self:AddNumberPanel(1950, 1950, 2013)

    self.birthdatePanel = self:Add("Panel")
    self.birthdatePanel:Dock(TOP)
    self.birthdatePanel:SetTall(self:GetTall())


    self:InvalidateLayout()
    self:UpdateNumberText()
end

function PANEL:AddNumberPanel(initialValue, minValue, maxValue)
    local numberPanel = vgui.Create("Panel", self)
    numberPanel:Dock(LEFT)
    numberPanel:SetWide(ScrW() * .08)

    local number = initialValue or minValue or 0

    local up = numberPanel:Add("DButton")
    up:SetFont("PassportfontUI")
    up:SetText("t")
    up:Dock(TOP)
    up:DockMargin(2, 2, 2, 2)
    up.DoClick = function()
        number = (number + 1) % (maxValue + 1)
        number = math.max(minValue, number)
        self:UpdateNumberText()
    end

    local down = numberPanel:Add("DButton")
    down:SetFont("Marlett")
    down:SetText("u")
    down:Dock(BOTTOM)
    down:DockMargin(2, 2, 2, 2)
    down.DoClick = function()
        number = (number - 1) % (maxValue + 1)
        number = math.min(maxValue, number)
        self:UpdateNumberText()
    end

    local numberLabel = numberPanel:Add("Panel")
    numberLabel:Dock(FILL)
    numberLabel.Paint = function(this, w, h)
        draw.SimpleText(number, "ixNoticeFont", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local function UpdateNumber(newValue)
        number = newValue
        self:UpdateNumberText()
    end

    up.DoClick = function()
        local newValue = number + 1
        if newValue > maxValue then
            newValue = minValue
        end
        UpdateNumber(newValue)
    end

    down.DoClick = function()
        local newValue = number - 1
        if newValue < minValue then
            newValue = maxValue
        end
        UpdateNumber(newValue)
    end

    numberPanel.OnMouseWheeled = function(this, delta)
        if delta > 0 then
            up:DoClick()
        else
            down:DoClick()
        end
    end

    return numberPanel, function() return number end
end

function PANEL:PerformLayout()
    self.dayPanel:DockMargin(0, 0, 5, 0)
    self.monthPanel:DockMargin(0, 0, 5, 0)

    self.dayPanel:Dock(LEFT)
    self.monthPanel:Dock(LEFT)
    self.yearPanel:Dock(LEFT)

    self.birthdatePanel:SizeToChildren(false, true)
end

function PANEL:GetSelectedBirthdate()
    local day = self.dayNumber()
    local month = self.monthNumber()
    local year = self.yearNumber()
    return string.format("%02d.%02d.%04d", day, month, year)
end

function PANEL:SetBirthdateText(birthdate)
    self.Borndate:SetText(birthdate)
end

function PANEL:UpdateNumberText()
    self:InvalidateLayout(true)
end

vgui.Register("BirthdatePanel", PANEL, "Panel")

------------------------------------------------------------------------
local PANEL = {}

local monthNames = {
    ["January"] = "Январь",
    ["February"] = "Февраль",
    ["March"] = "Март",
    ["April"] = "Апрель",
    ["May"] = "Май",
    ["June"] = "Июнь",
    ["July"] = "Июль",
    ["August"] = "Август",
    ["September"] = "Сентябрь",
    ["October"] = "Октябрь",
    ["November"] = "Ноябрь",
    ["December"] = "Декабрь",
}

local function localizeMonth(monthName)
    return monthNames[monthName] or monthName
end

local function GenerateRandomDate()
    local startYear = 1950
    local endYear = 2013

    local day = math.random(1, 31)
    local month = math.random(1, 12)
    local year = math.random(startYear, endYear)

    return string.format("%02d.%02d.%04d", day, month, year)
end

function PANEL:Init()
    local w, h = ScrW(), ScrH()
    local uIDpassport = util.CRC(LocalPlayer():SteamID64()..LocalPlayer():GetCharacter():GetID())-- забавный энкодинг будет, и не будет повторятся

    local RegistrationDate = os.date("%d %B", os.time())
    local TranslatedMonth = localizeMonth(RegistrationDate:match("%s(%a+)$"))
    local RegtimeCurr = RegistrationDate:gsub("%s%a+$", " " .. TranslatedMonth) -------
    
    local Namechar = LocalPlayer():Name() --------------

    local GenderText = LocalPlayer():IsFemale() and "Женский" or "Мужской" -------------

    local National = LocalPlayer():GetNetVar("CharNational", national)

    local RegStr = LocalPlayer():GetNetVar("RegStr", regstr)

    local RegImg = LocalPlayer():GetNetVar("RegImg", RegImg)

    self:SetSize(w * .25, h * .55)
    self:Center()
    self:SetTitle("Регистрация паспорта")
    self:MakePopup()

    self.uIDpassportlabel = self:Add("ixLabel")
    self.uIDpassportlabel:SetFont("PassportfontUI")
    self.uIDpassportlabel:SetText("Уникальный номер паспорта")
    --self.uIDpassportlabel:DockMargin(0, 4, 0, 6)
    self.uIDpassportlabel:Dock(TOP)
    self.uIDpassportlabel:SetContentAlignment(7)

    self.uIDpassport = self:Add("ixTextEntry")
    self.uIDpassport:SetFont("PassportfontUI")
    self.uIDpassport:SetValue(uIDpassport)
    self.uIDpassport:Dock(TOP)
    self.uIDpassport:SetTall(self:GetParent():GetTall() * .04)
    self.uIDpassport:SetEditable(false)

    self.Registrationlabel = self:Add("ixLabel")
    self.Registrationlabel:SetFont("PassportfontUI")
    self.Registrationlabel:SetText("Дата регистрации/авторизации")
   -- self.Registrationlabel:DockMargin(0, 4, 0, 6)
    self.Registrationlabel:Dock(TOP)
    self.Registrationlabel:SetContentAlignment(7)

    self.Registation = self:Add("ixTextEntry")
    self.Registation:SetFont("PassportfontUI")
    self.Registation:SetValue(RegtimeCurr)
    self.Registation:Dock(TOP)
    self.Registation:SetTall(self:GetParent():GetTall() * .04)
    self.Registation:SetEditable(false)

    self.Namelabel = self:Add("ixLabel")
    self.Namelabel:SetFont("PassportfontUI")
    self.Namelabel:SetText("Имя Регистрируемого")
    --self.Namelabel:DockMargin(0, 4, 0, 6)
    self.Namelabel:Dock(TOP)
    self.Namelabel:SetContentAlignment(7)

    self.Name = self:Add("ixTextEntry")
    self.Name:SetFont("PassportfontUI")
    self.Name:SetValue(Namechar)
    self.Name:Dock(TOP)
    self.Name:SetTall(self:GetParent():GetTall() * .04)
    self.Name:SetEditable(false)

    self.Genderlabel = self:Add("ixLabel")
    self.Genderlabel:SetFont("PassportfontUI")
    self.Genderlabel:SetText("Пол")
    --self.Genderlabel:DockMargin(0, 4, 0, 6)
    self.Genderlabel:Dock(TOP)
    self.Genderlabel:SetContentAlignment(7)

    self.Gender = self:Add("ixTextEntry")
    self.Gender:SetFont("PassportfontUI")
    self.Gender:SetValue(GenderText)
    self.Gender:Dock(TOP)
    self.Gender:SetTall(self:GetParent():GetTall() * .04)
    self.Gender:SetEditable(false)

    self.Borndatelabel = self:Add("ixLabel")
    self.Borndatelabel:SetFont("PassportfontUI")
    self.Borndatelabel:SetText("Дата рождения")
    --self.Borndatelabel:DockMargin(0, 4, 0, 6)
    self.Borndatelabel:Dock(TOP)
    self.Borndatelabel:SetContentAlignment(7)

    self.Borndate = self:Add("DButton")
    self.Borndate:SetFont("PassportfontUI")
    self.Borndate:SetText(GenerateRandomDate())
    self.Borndate:Dock(TOP)
    self.Borndate:SetTall(self:GetParent():GetTall() * .04)
    self.Borndate.Paint = function(this, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 80))
    end

    self.Borndate.DoClick = function(this)
        local panel = vgui.Create("DFrame")
        panel:SetTitle("")
        panel:SetSize(w * 0.25, h * 0.25)
        panel:MakePopup()
        panel:SetPos(self:GetPos())
    
        local birthdatePanel = panel:Add("BirthdatePanel", self.Borndate)
        birthdatePanel:Dock(TOP)
    
        local saveButton = panel:Add("DButton")
        saveButton:Dock(TOP)
        saveButton:SetText("Сохранить")
        saveButton.DoClick = function()
            local selectedBirthdate = birthdatePanel:GetSelectedBirthdate()
            self.Borndate:SetText(selectedBirthdate)
            panel:Close()
        end
    end

    self.Nationallabel = self:Add("ixLabel")
    self.Nationallabel:SetFont("PassportfontUI")
    self.Nationallabel:SetText("Национальность")
    --self.Nationallabel:DockMargin(0, 4, 0, 6)
    self.Nationallabel:Dock(TOP)
    self.Nationallabel:SetContentAlignment(7)

    self.National = self:Add("ixTextEntry")
    self.National:SetFont("PassportfontUI")
    self.National:SetValue(National)
    self.National:Dock(TOP)
    self.National:SetTall(self:GetParent():GetTall() * .04)
    self.National:SetEditable(false)

    self.Suceedbutton = self:Add("DButton")
    self.Suceedbutton:SetFont("PassportfontUI")
    self.Suceedbutton:SetText("Завершить")
    --self.Suceedbutton:DockMargin(0, 16, 0, 0)
    self.Suceedbutton:Dock(TOP)
    self.Suceedbutton:SetTall(self:GetParent():GetTall() * .05)

    self.Suceedbutton.Paint = function(this, w, h)
        draw.RoundedBox(0, 0, 0, w, h, ix.config.Get("color"))
    end

    self.Suceedbutton.DoClick = function(this)
        netstream.Start("cmbmtk.proceedpassport", uIDpassport, RegtimeCurr, Namechar, GenderText, self.Borndate:GetText(), National, RegStr, RegImg)
        self:Close()
    end
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
    draw.RoundedBox(0, 0, 0, w, h * .05, ix.config.Get("color"))
end

vgui.Register("cmbmtk.passportvendor", PANEL, "DFrame")


------------------------------------
local PANEL = {}


function PANEL:Init()
    local w, h = ScrW(), ScrH()
    self:SetSize(w * .4, h * .49)
    self:Center()
    self:SetTitle("")
    self:MakePopup()

    self.PassportuID = self:Add("ixLabel")
    self.PassportuID:SetFont("PassportfontUI")
    self.PassportuID:SetPos(self:GetWide() * .605, self:GetTall() * .11)
    self.PassportuID:SetTextColor(Color(0, 0, 0))

    self.Registerdate = self:Add("ixLabel")
    self.Registerdate:SetFont("PassportfontUI")
    self.Registerdate:SetPos(self:GetWide() * .23, self:GetTall() * .86)
    self.Registerdate:SetTextColor(Color(0, 0, 0))

    self.Name = self:Add("ixLabel")
    self.Name:SetFont("PassportfontUI")
    self.Name:SetPos(self:GetWide() * .61, self:GetTall() * .19)
    self.Name:SetTextColor(Color(0, 0, 0))

    self.Gender = self:Add("ixLabel")
    self.Gender:SetFont("PassportfontUI")
    self.Gender:SetPos(self:GetWide() * .61, self:GetTall() * .29)
    self.Gender:SetTextColor(Color(0, 0, 0))

    self.Borndate = self:Add("ixLabel")
    self.Borndate:SetFont("PassportfontUI")
    self.Borndate:SetPos(self:GetWide() * .61, self:GetTall() * .24)
    self.Borndate:SetTextColor(Color(0, 0, 0))

    self.National = self:Add("ixLabel")
    self.National:SetFont("PassportfontUI")
    self.National:SetPos(self:GetWide() * .71, self:GetTall() * .33)
    self.National:SetTextColor(Color(0, 0, 0))

    self.RegStr = self:Add("ixLabel")
    self.RegStr:SetFont("PassportfontUI")
    self.RegStr:SetPos(self:GetWide() * .652, self:GetTall() * .425)
    self.RegStr:SetTextColor(Color(0, 0, 0))

    self.RegImg = self:Add("DImage")
    self.RegImg:SetSize(self:GetWide() * .3, self:GetTall() * .42)
    self.RegImg:SetPos(self:GetWide() * .14, self:GetTall() * .2)

    self:GetInfoPassport()
end

function PANEL:GetInfoPassport(info, stamps)
    if !info then return end
    if not table.IsEmpty( info ) then
        self.PassportuID:SetSize(surface.GetTextSize(info["Уникальный номер"]))
        self.PassportuID:SetText(info["Уникальный номер"])

        self.Registerdate:SetSize(surface.GetTextSize(info["Дата Регистрации"]))
        self.Registerdate:SetText(info["Дата Регистрации"])

        self.Name:SetSize(surface.GetTextSize(info["Имя"]))
        self.Name:SetText(info["Имя"])

        self.Gender:SetSize(surface.GetTextSize(info["Пол"]))
        self.Gender:SetText(info["Пол"])

        self.Borndate:SetSize(surface.GetTextSize(info["Дата Рождения"]))
        self.Borndate:SetText(info["Дата Рождения"])

        self.National:SetSize(surface.GetTextSize(info["Национальность"]))
        self.National:SetText(info["Национальность"])

        self.RegStr:SetSize(surface.GetTextSize(info["Выписано"]))
        self.RegStr:SetText(info["Выписано"])

        self.RegImg:SetImage(info["Печать"])
    end

    if !stamps then return end
    if not table.IsEmpty( stamps ) then
        for k,v in pairs(stamps) do
            self.StampsIMG = self:Add("DImage")
            self.StampsIMG:SetSize(Scale(64), Scale(64))
            self.StampsIMG:SetPos(math.random(self:GetWide() * .55, self:GetWide() * .8), math.random(self:GetTall() * .51, self:GetTall() * .79))
            self.StampsIMG:SetImage(v)
        end
    end
end

function PANEL:Paint(w,h)
    surface.SetMaterial( Material("mutantsimgs/passport.png") )
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("cmbmtk.passportplayer", PANEL, "DFrame")
