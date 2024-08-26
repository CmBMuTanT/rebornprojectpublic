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

function PLUGIN:KeyPress(client, key)
  if client:GetCharacter() and client:Alive() then
      if key == IN_USE then
          local HitPos = client:GetEyeTraceNoCursor()
          local target = HitPos.Entity
          if target and IsValid(target) and target:IsRagdoll() and self.list[target:GetModel()] then
              netstream.Start(client, "ButcherMenuOpen", target:GetModel())
          end
      end
  end
end


netstream.Hook("StartButchering", function(client, data)
  local seconddata = PLUGIN.list[client:GetEyeTrace().Entity:GetModel()]
  if !seconddata then client:Notify("Error#1 invalid model") return end
  if client:GetActiveWeapon():GetClass() ~= "weapon_crowbar" then client:Notify("Error#2 invalid weapon") return end
  local entity = client:GetEyeTrace().Entity
  
  if entity:GetClass() ~= "prop_ragdoll" then client:Notify("Error#3 invalid entity") return end

  client:ForceSequence("Roofidle1", nil, 0)
  client:EmitSound("ambient/machines/slicer1.wav")

  local randombutch = math.random(10, 30)
  client:SetAction("Разрезаю...", randombutch)
  client:DoStaredAction(entity, function()
    client:LeaveSequence()

    local character = client:GetCharacter()
    local inventory = character:GetInventory()

    local effect = EffectData()
    effect:SetStart(entity:LocalToWorld(entity:OBBCenter()))
    effect:SetOrigin(entity:LocalToWorld(entity:OBBCenter()))
    effect:SetScale(5)
    util.Effect("BloodImpact", effect)

    entity:Remove()
    

    if math.random(100) >= 50 then -- шанс 50%
      if !inventory:Add(data) then
          ix.item.Spawn(data, client)
      end
    else
      client:Notify("Ваша рука дёрнулась - и часть тела была повреждена.. Сегодня - явно не ваш день.")
    end
  end, randombutch, function()
    if ( IsValid(client) ) then
        client:SetAction()
        client:LeaveSequence()
    end
  end)

end)