local PLUGIN = PLUGIN
--[[
——————————————————————————————————————no cmbmutant.xyz?———————————————————————————
          .                                                      .
        .n                   .                 .                  n.
  .   .dP                  dP                   9b                 9b.    .
 4    qXb         .       dX                     Xb       .        dXp     t
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'
        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP
                     `'      9XXXXXX(   )XXXXXXP      `'
                              XXXX X.`v'.X XXXX
                              XP^X'`b   d'`X^XX
                              X. 9  `   '  P )X
                              `b  `       '  d'
                               `             '
—————————————————————————————————————————————————————————————————————————————————
]]

surface.CreateFont("ButcherFrameTextBig", {font = "Capture Smallz", extended = true, size = ScreenScale(23), weight = 500})
surface.CreateFont("ButcherFrameTextBlurBig", {font = "Capture Smallz", extended = true, size = ScreenScale(23), weight = 500,  blursize = 10})

surface.CreateFont("ButcherFrameTextNormal", {font = "Capture Smallz", extended = true, size = ScreenScale(7), weight = 500})
surface.CreateFont("ButcherFrameTextBlurNormal", {font = "Capture Smallz", extended = true, size = ScreenScale(7), weight = 500,  blursize = 10})

surface.CreateFont("ButcherFrameTextSmall", {font = "Capture Smallz", extended = true, size = ScreenScale(5), weight = 500})

netstream.Hook("ButcherMenuOpen", function(data)
  local datas = PLUGIN.list[data]
  local MainPanel = vgui.Create("DFrame")
  MainPanel:SetSize(ScrW() * .6, ScrH()  *.7)
  MainPanel:SetTitle("")
  MainPanel:Center()
  MainPanel:SetDraggable(false)
  MainPanel:ShowCloseButton(false)

  function MainPanel:AnimateShow()
    self:SetPos(ScrW() / 2 - self:GetWide() / 2, ScrH())
    local endY = ScrH() / 2 - self:GetTall() / 2 
    self:MoveTo(ScrW() / 2 - self:GetWide() / 2, endY, 0.3, 0, -1, function()
    self:SetPos(ScrW() / 2 - self:GetWide() / 2, endY)
    end)
  end
  MainPanel:AnimateShow()
  MainPanel:MakePopup()
  
  local DescriptionText = vgui.Create("RichText", MainPanel)
  DescriptionText:SetPos(MainPanel:GetWide() * .73, MainPanel:GetTall() * .21)
  DescriptionText:SetSize(MainPanel:GetWide() * .23, MainPanel:GetTall() * .46)
  DescriptionText:SetText(datas.description)
  DescriptionText.PerformLayout = function(this)
    this:SetFontInternal( "ButcherFrameTextSmall" )
    this:SetFGColor( Color(255, 140, 0) )
  end

  local isButtonHovered = false
  local buttonX, buttonY = 0, 0
  local targetX, targetY = 0, 0
  local lineProgress = 0

  MainPanel.Paint = function(this, w, h)

      surface.SetDrawColor( 255, 255, 255, 255 )
      surface.SetMaterial( Material("stalker/inv2.png") )
      surface.DrawTexturedRect( 0, 0, w, h )


      surface.SetDrawColor( 255, 255, 255, 255 )
      surface.SetMaterial( Material("stalker/ui.png") )
      surface.DrawTexturedRect( w * .08, h * .18, w * .6, h * .5 )

      surface.SetDrawColor( 255, 255, 255, 200 )
      surface.SetMaterial( Material(datas.material or "debug/debugempty") )
      surface.DrawTexturedRect( w * .1, h * .22, w * .56, h * .43 )

      surface.SetDrawColor( 255, 255, 255, 255 )
      surface.SetMaterial( Material("stalker/charinfo.png") )
      surface.DrawTexturedRect( w * .69, h * .18, w * .28, h * .5 )

      draw.SimpleText(datas.name, "ButcherFrameTextBig", w * .5, h * .075, Color(207, 114, 0), TEXT_ALIGN_CENTER)
      draw.SimpleText(datas.name, "ButcherFrameTextBlurBig", w * .5, h * .075, Color(207, 114, 0), TEXT_ALIGN_CENTER)

      draw.SimpleText("Описание", "ButcherFrameTextNormal", w * .75, h * .176, Color(255, 140, 0), TEXT_ALIGN_CENTER)
      draw.SimpleText("Описание", "ButcherFrameTextBlurNormal", w * .75, h * .176, Color(255, 140, 0), TEXT_ALIGN_CENTER)


      if isButtonHovered or lineProgress < 1 then
        lineProgress = lineProgress + 0.02
  
        if lineProgress > 1 then
          lineProgress = 1
        end
  
        local lineX = Lerp(lineProgress, buttonX, targetX)
        local lineY = Lerp(lineProgress, buttonY, targetY)
  
        surface.SetDrawColor(255, 140, 0)
        surface.DrawLine(buttonX, buttonY, lineX, lineY)
      end
  end


  if LocalPlayer():GetActiveWeapon():GetClass() == "weapon_crowbar" then
    local xxx = 0
    for k,v in ipairs(datas.buttons) do
      local ButcherButton = vgui.Create("DButton", MainPanel)
      ButcherButton:SetText("Срезать "..v.name)
      ButcherButton:SetFont("ButcherFrameTextNormal")
      ButcherButton:SetPos(MainPanel:GetWide() * .08 + xxx, MainPanel:GetTall() * .75)
      ButcherButton:SetSize(MainPanel:GetWide() * .15, MainPanel:GetTall() * .05)
    
      ButcherButton.DoClick = function(this)
          MainPanel:Close()
          netstream.Start("StartButchering", v.item)
      end
    
      ButcherButton.Paint = function(this, w, h)
          if this.Hovered then
              thismat = Material("stalker/buttontab.png")
          else
              thismat = Material("stalker/x.png")
          end
    
          surface.SetDrawColor( 255, 255, 255, 255 )
          surface.SetMaterial( thismat )
          surface.DrawTexturedRect( 0, 0, w, h )
      end

      ButcherButton.OnCursorEntered = function(this) -- для линии
        if IsValid(this) and IsValid(MainPanel) then
          local x, y = this:LocalToScreen(0, 0)
          x, y = MainPanel:ScreenToLocal(x, y)

          buttonX, buttonY = x + this:GetWide() * 0.5, y + this:GetTall() * 0.5
          targetX, targetY  = MainPanel:GetWide() * v.x, MainPanel:GetTall() * v.y 
          isButtonHovered = true
          lineProgress = 0
        end
      end

      ButcherButton.OnCursorExited = function(this) -- для линии
        isButtonHovered = false
      end
      
      xxx = xxx + 180
    end

    local CloseButton = vgui.Create("DButton", MainPanel)
    CloseButton:SetText("Закрыть")
    CloseButton:SetFont("ButcherFrameTextNormal")
    CloseButton:SetPos(MainPanel:GetWide() * .86, MainPanel:GetTall() * .86)
    CloseButton:SetSize(MainPanel:GetWide() * .1, MainPanel:GetTall() * .05)

    CloseButton.DoClick = function(this)
      MainPanel:Close()
    end
      
    CloseButton.Paint = function(this, w, h)
      if this.Hovered then
          thismat = Material("stalker/buttontab.png")
      else
          thismat = Material("stalker/x.png")
      end

      surface.SetDrawColor( 255, 255, 255, 255 )
      surface.SetMaterial( thismat )
      surface.DrawTexturedRect( 0, 0, w, h )
    end
  else
    local CloseButton = vgui.Create("DButton", MainPanel)
    CloseButton:SetText("Закрыть")
    CloseButton:SetFont("ButcherFrameTextNormal")
    CloseButton:SetPos(MainPanel:GetWide() * .86, MainPanel:GetTall() * .86)
    CloseButton:SetSize(MainPanel:GetWide() * .1, MainPanel:GetTall() * .05)

    CloseButton.DoClick = function(this)
      MainPanel:Close()
    end
      
    CloseButton.Paint = function(this, w, h)
      if this.Hovered then
          thismat = Material("stalker/buttontab.png")
      else
          thismat = Material("stalker/x.png")
      end

      surface.SetDrawColor( 255, 255, 255, 255 )
      surface.SetMaterial( thismat )
      surface.DrawTexturedRect( 0, 0, w, h )
    end
  end

end)