local PLUGIN = PLUGIN
PLUGIN.name = "Батарейки"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

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

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")


--да-да. не удивляйтесь

PLUGIN.itemstocharge = {
  ["recharger"] = true, -- зарядка
  ["dosimetr"] = true,
  ["geiger"] = true,
  ["chatter"] = true,
  ["goglightblue"] = true,
  ["goggreen"] = true,
  ["gogblue"] = true,
  ["gogred"] = true,
}


function PLUGIN:InitializedPlugins()
  timer.Simple(1, function() -- чтоб все айтемы прогрузились

    for k,v in pairs(ix.item.list) do
        if self.itemstocharge[k] then

          v.functions.takeoffbat = {
            name = "Вынуть батарейку",
            tip = "useTip",
            icon = "icon16/arrow_up.png",
            OnRun = function(item)
              local client = item.player
              local character = client:GetCharacter()
              local inv = character:GetInventory()

              if item:GetData("IsBattery") then
               inv:Add("techaabatt", 1, {BatteryCondition = item:GetData("BatteryCondition")})
              else
                inv:Add("techaaacum", 1, {BatteryCondition = item:GetData("BatteryCondition")})
              end

              item:SetData("BatteryCondition", nil)
              client:EmitSound("eftsounds/item_injector_03_putaway.wav")

              return false
            end,
              OnCanRun = function(item)
              return !IsValid(item.entity) and item:GetData("BatteryCondition") ~= nil
            end
          }
          
        end
    end
  end)
end

function PLUGIN:PopulateItemTooltip(tooltip, item)
  if self.itemstocharge[item.uniqueID] then
    if item:GetData("BatteryCondition") == nil then return end

      local condition = tooltip:AddRowAfter("description", "condition")
      condition:SetText("Заряд: ".. math.floor(item:GetData("BatteryCondition", 100)).."%")
      condition:SetBackgroundColor(Color(0, 170, 255))
      condition:SizeToContents()
  end
end