local PLUGIN = PLUGIN
PLUGIN.name = "PFX SAVE"
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

function PLUGIN:SaveData()
  local pfx_effects = {}

  for _, pfx_data in pairs(ents.FindByClass("pfx*")) do
      if IsValid(pfx_data) then
          pfx_effects[#pfx_effects + 1] = {
              position = pfx_data:GetPos(),
              angles = pfx_data:GetAngles(),
              class = pfx_data:GetClass(),
          }
      end
  end

  ix.data.Set("pfx_effects", pfx_effects)
end

function PLUGIN:LoadData()
  local pfx_effects = ix.data.Get("pfx_effects")

  if istable(pfx_effects) then
      for _, v in pairs(pfx_effects) do
          local pfx = ents.Create(v.class)

          if IsValid(pfx) then
              pfx:SetPos(v.position)
              pfx:SetAngles(v.angles)
              pfx:Spawn()

              local physObj = pfx:GetPhysicsObject()
              if IsValid(physObj) then
                  physObj:EnableMotion(false)
              end
          else
              print("Failed to create entity with class:", v.class)
          end
      end
  end
end