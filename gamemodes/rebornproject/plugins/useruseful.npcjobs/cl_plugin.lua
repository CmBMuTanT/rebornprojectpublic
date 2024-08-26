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

local Already = false
function PLUGIN:HUDPaint()
  local client = LocalPlayer()
  local character = client:GetCharacter()
  
  if !client:Alive() and !character and client:GetNetVar("HasJob", false) == false then return end
  if client:GetNetVar("WorkTempProgress", 0) >= 3 then return end

  
	for _, entity in pairs(ents.FindByClass( "cmbmtk_"..tostring(client:GetNetVar("HasJob")) )) do
    if entity:GetNoDrawIcon() then continue end

    local dist = LocalPlayer():GetPos():Distance(entity:GetPos())
		local Position = ( entity:GetPos() + Vector( 0,0,10 ) ):ToScreen()
    local iconSize = math.Clamp(500 / dist, 64, 28)

      if dist <= 2000 then -- дистанции 3000 думаю хватит
          if !Already then
              --LocalPlayer():EmitSound("buttons/blip1.wav")
              Already = true
          end

          surface.SetDrawColor(255, 255, 255)
          surface.SetMaterial(Material("icon16/arrow_down.png"))
          surface.DrawTexturedRect(Position.x - 15, Position.y + 10, iconSize, iconSize)
          draw.DrawText( string.format("%.i м", dist), "Default", Position.x, Position.y, Color( 255, 255, 255), 1 )
      else
          Already = false
      end
	end


end


---мне в падлу создавать vgui отдельную, так что я просто и красиво сделаю вот так.
net.Receive("MiniGameElectro_Start", function()
  local targetColor = net.ReadColor()
  local targetButtonText = net.ReadString()
  local targetTextColor = net.ReadColor()
  local targetEntity = net.ReadEntity()
  PLUGIN:CreateColorGamePanel(targetColor, targetButtonText, targetTextColor, targetEntity)
end)

function PLUGIN:CreateColorGamePanel(targetColor, targetButtonText, targetTextColor, targetEntity)
  local frame = vgui.Create("DFrame")
  frame:SetSize(ScrW() * .17, ScrH() * .15)
  frame:SetTitle("")
  frame:SetVisible(true)
  frame:SetDraggable(false)
  frame:ShowCloseButton(false)
  frame:MakePopup()
  frame:Center()

  local label = vgui.Create("DLabel", frame)
  label:SetText("Нажми на кнопку с текстом:")
  label:SetPos(frame:GetWide() * .28, frame:GetTall() * .1)
  label:SetSize(frame:GetWide() * .5, frame:GetTall() * .5)

  local targetLabel = vgui.Create("DLabel", frame)
  targetLabel:SetText(targetButtonText)
  targetLabel:SetPos(frame:GetWide() * .45, frame:GetTall() * .2)
  targetLabel:SetSize(frame:GetWide() * .5, frame:GetTall() * .5)
  targetLabel:SetColor(targetTextColor)

  local buttonColors = {Color(255, 0, 0), Color(0, 255, 0), Color(0, 0, 255), Color(255, 255, 0)}
  local buttonY = frame:GetTall() * 0.55
  local buttonWidth = frame:GetWide() * 0.15
  local buttonSpacing = frame:GetWide() * 0.01
  local totalButtonWidth = (buttonWidth + buttonSpacing) * #buttonColors - buttonSpacing
  local startX = (frame:GetWide() - totalButtonWidth) * 0.5

  for i, color in ipairs(buttonColors) do
      local button = vgui.Create("DButton", frame)
      button:SetSize(buttonWidth, frame:GetTall() * 0.25)
      button:SetPos(startX + (i - 1) * (buttonWidth + buttonSpacing), buttonY)
      button:SetText("")
      button.Paint = function(self, w, h)
          draw.RoundedBox(4, 0, 0, w, h, color)
      end
      
      button.DoClick = function()
          net.Start("MiniGameElectro_ButtonClicked")
          net.WriteBool(color == targetColor)
          net.SendToServer()
          frame:Close()
      end
  end
end