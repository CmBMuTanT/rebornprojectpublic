surface.CreateFont("StalkerUI-400-16", {
	font = "Capture Smallz",
	size = ScreenScale(20 / 3),
	weight = 400,
	extended = true
})

local PANEL = {}

function PANEL:Init()

    if (IsValid(ix.gui.intro)) then
		ix.gui.intro:Remove()
	end

	ix.gui.intro = self

    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
    self:SetVisible(true)
    self:SetMouseInputEnabled(false)
    self:SetKeyboardInputEnabled(false)
    self:MakePopup()

    self.slides = {
        {
            img = "mutantsimgs/screenbssd.png",
            text = [[ПРОЛОГ...]],
            sound = "mutantsimgs/ones.ogg",
            transitionTime = 37,
            fullscreen = true
        },
        {
            img = "mutantsimgs/fontext.png",
            text = [[]],
            sound = "mutantsimgs/twosoundintrof.ogg",
            transitionTime = 37,
            fullscreen = true
        },
        {
            img = "mutantsimgs/screeennsbs.png",
            text = [[]],
            sound = "mutantsimgs/threesounditrnom.ogg",
            transitionTime = 30,
            fullscreen = true
        },
         {
            img = "mutantsimgs/149.png",
            text = [[Уважаемый игрок! Мы рады приветствовать тебя на нашем проекте. Советуем присоединится к нашему discord-сообществу, и в случае вопросов обращаться к администрации. Помни - главное это атмосфера! С любовью и уважением - владелец проекта NullNull.]],
            sound = "mutantsimgs/metrosound.ogg",
            transitionTime = 69,
            fullscreen = true
        },
    }
 
    self.currentSlide = 1
    self.transitionStartTime = 0
    self.transitionEndTime = 0
    self.currentText = ""
    self.textLength = 0
    self.lastCharacterTime = 0

    self.animationStartTime = 0
    self.animationType = 0

    self.showContinueText = false
    self.continueTextAlpha = 0
    self.continueTextFadeStartTime = 0
    self.continueTextFadeDuration = 1

    self.pressed = false
    self.pressedAlpha = 255
    self.pressedFadeStartTime = 0
    self.pressedFadeDuration = 2
end

function PANEL:Start()

    ix.option.Set("showIntro", false) -- отключаем интро чтоб потом оно не показывалось.

    timer.Simple(5, function()
        if #self.slides == 0 then return end
        LocalPlayer():SetDSP(0)
        self:ShowSlide(self.currentSlide)
    end)
end

function PANEL:ShowSlide(slideIndex)
    if not self.slides[slideIndex] then return end

    self.currentSlide = slideIndex

    local slide = self.slides[slideIndex]

    

    self.imagePanel = vgui.Create("DImage", self)
    self.imagePanel:SetImage(slide.img)
    
    if slide.fullscreen then
        self.imagePanel:SetSize(ScrW(), ScrH())
    else 
        self.imagePanel:SizeToContents()
        self.imagePanel:SetPos((ScrW() - self.imagePanel:GetWide()) * .5, (ScrH() - self.imagePanel:GetTall()) * .1)
    end
    -- self.imagePanel:SizeToContents()
    -- self.imagePanel:SetPos((ScrW() - self.imagePanel:GetWide()) * .5, (ScrH() - self.imagePanel:GetTall()) * .1)
   -- self.imagePanel:SetSize(ScrW(), ScrH())
    self.imagePanel:SetAlpha(0)

    self.textPanel = vgui.Create("RichText", self)
    self.textPanel:SetSize((ScrW() - self.textPanel:GetWide()) * .6, (ScrH() - self.textPanel:GetTall()) * .15)
    self.textPanel:SetVerticalScrollbarEnabled(false)
    self.textPanel.PerformLayout = function(this)
        this:SetFontInternal("StalkerUI-400-16")
        this:SetFGColor(Color(255, 255, 255))
    end

    self.animationDuration = slide.transitionTime / 3

    self.currentText = slide.text
    self.textLength = 0
    self.lastCharacterTime = 0

    self.sound = CreateSound(LocalPlayer(), slide.sound)
    self.sound:Play()

    self.transitionStartTime = CurTime()
    self.transitionEndTime = CurTime() + slide.transitionTime
    self.animationStartTime = CurTime() + 2
    self.animationType = 0
end

function PANEL:Think()
    if self.transitionEndTime > 0 and CurTime() > self.transitionEndTime then
        self.transitionEndTime = 0

        if self.imagePanel then
            self.imagePanel:Remove()
            self.imagePanel = nil
        end

        if self.sound then
            self.sound:Stop()
            self.sound = nil
        end

        self.currentSlide = self.currentSlide + 1

        if self.currentSlide > #self.slides then
            self.showContinueText = true
            self:SetKeyboardInputEnabled(true)
            return
        end

        self:ShowSlide(self.currentSlide)
    end

    local currentTime = CurTime()
    if self.currentText ~= "" and currentTime > self.lastCharacterTime + 0.1 then
        self.lastCharacterTime = currentTime
        self.textLength = self.textLength + 1
        local displayText = string.sub(self.currentText, 1, self.textLength)

        if #displayText < #self.currentText then surface.PlaySound("mutantsimgs/type"..math.random(1, 7)..".ogg") end
        if self.textPanel then
            self.textPanel:SetText(displayText)
            self.textPanel:SetPos((ScrW() - self.textPanel:GetWide()) * .5, (ScrH() - self.textPanel:GetTall()) * .8)
        end
    end

    if self.animationStartTime > 0 then
        local elapsed = CurTime() - self.animationStartTime
        local alpha

        if self.animationType == 0 then
            alpha = math.Clamp(elapsed / self.animationDuration * 255, 0, 255)

            if self.textPanel then
                self.textPanel:SetAlpha(255)
            end
        else
            alpha = math.Clamp(255 - elapsed / self.animationDuration * 255, 0, 255)

            if self.textPanel then
                self.textPanel:SetAlpha(alpha)
            end
        end

        if self.imagePanel then
            self.imagePanel:SetAlpha(alpha)
        end

        if elapsed >= self.animationDuration then
            self.animationStartTime = 0
            if self.animationType == 1 then
                self.animationType = 0
            else
                self.animationType = 1
                self.animationStartTime = CurTime() + 2
            end
        end
    end

    if self.showContinueText then
        if self.continueTextFadeStartTime == 0 then
            self.continueTextFadeStartTime = CurTime()
        end

        local fadeElapsed = CurTime() - self.continueTextFadeStartTime
        self.continueTextAlpha = math.Clamp(fadeElapsed / self.continueTextFadeDuration * 255, 0, 255)
    end

    if self.pressed then
        if self.pressedFadeStartTime == 0 then
            self.pressedFadeStartTime = CurTime()
        end

        local fadeElapsed = CurTime() - self.pressedFadeStartTime
        self.pressedAlpha = math.Clamp(255- fadeElapsed / self.pressedFadeDuration * 255, 0, 255)
    end
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, self.pressedAlpha))

    if self.showContinueText then
        surface.SetFont("StalkerUI-400-16")
        local text = "НАЖМИТЕ [SPACE] для продолжения"
        local textWidth, textHeight = surface.GetTextSize(text)
        local posX = (w - textWidth) * 0.5
        local posY = h - textHeight - 20

        draw.SimpleText(text, "StalkerUI-400-16", posX, posY, Color(255, 255, 255, self.continueTextAlpha))
    end
end

function PANEL:OnKeyCodePressed(keyCode)
    if self.showContinueText and keyCode == KEY_SPACE then
        self.pressed = true

        timer.Simple(2, function()
            self:SetVisible(false)
            if (IsValid(ix.gui.characterMenu)) then
                ix.gui.characterMenu:PlayMusic()
            end
        end)
    end
end

vgui.Register("ixIntro", PANEL, "EditablePanel")
