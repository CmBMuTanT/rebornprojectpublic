local PLUGIN = PLUGIN

PLUGIN.name = "Re-Edit Vendor"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[
  Тут нихуя нет, ибо это айтемы. И все.
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



local PLUGIN = PLUGIN

-- if CLIENT then
--   function PLUGIN:PopulateItemTooltip(tooltip, item)
--     -- local name = tooltip:AddRow("name")
--     -- name:SetText("My Cool Entity!")
--     -- name:SetBackgroundColor(Color(230, 0, 0))
--     -- name:SetImportant()
--     -- name:SizeToContents()

--     -- local desc = tooltip:AddRowAfter("name", "desc")
--     -- desc:SetText("My entity does cool things!.")
--     -- desc:SetBackgroundColor(Color(255, 0, 0))
--     -- desc:SizeToContents()

--     tooltip.Paint = function(self, width, height)
--       --draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0))
--     end
--   end
-- end

if CLIENT then
  function PLUGIN:LoadIntro()
    if (!IsValid(ix.gui.intro)) then
      if (ix.config.Get("intro", true) and ix.option.Get("showIntro", true)) then
         timer.Simple(0.1, function()
          local intro = vgui.Create("ixIntro")
          intro:Start()
        end)
      end
    end
  end  
end