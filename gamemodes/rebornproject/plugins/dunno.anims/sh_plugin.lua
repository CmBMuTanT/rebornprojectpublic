local PLUGIN = PLUGIN 
PLUGIN.name = "Player Animations"
PLUGIN.author = "Taxin2012 & PURP"
PLUGIN.description = ""

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
Все что обфусцировано, может быть де-обфусцировано. Таксин сорри мне заплатили.
]]

function PLUGIN:InitializedPlugins()
    HOLDTYPE_TRANSLATOR = {}
    HOLDTYPE_TRANSLATOR[""] = "normal"
    HOLDTYPE_TRANSLATOR["physgun"] = "smg"
    HOLDTYPE_TRANSLATOR["grenade"] = "grenade"
    HOLDTYPE_TRANSLATOR["fist"] = "normal"
    HOLDTYPE_TRANSLATOR["melee2"] = "melee"
    HOLDTYPE_TRANSLATOR["passive"] = "normal"
    HOLDTYPE_TRANSLATOR["knife"] = "melee"
    HOLDTYPE_TRANSLATOR["revolver"] = "pistol"
    HOLDTYPE_TRANSLATOR["magic"] = "magic"
    PLAYER_HOLDTYPE_TRANSLATOR = {}
    PLAYER_HOLDTYPE_TRANSLATOR[""] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["fist"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["pistol"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["grenade"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["melee"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["melee2"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["passive"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["knife"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["duel"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["bugbait"] = "normal"
    PLAYER_HOLDTYPE_TRANSLATOR["magic"] = "magic"
end

HOLDTYPE_TRANSLATOR["magic"] = "magic"

ix.util.Include("sh_animations.lua")
ix.util.Include("sh_models_list.lua")
ix.util.Include("sh_overrides.lua")

ix.command.Add("CharMovementSeq", {
    description = "Изменить походку",
    adminOnly = false,
    arguments = ix.type.number,
    argumentNames = {
        "Стандарт: 1, Бандит: 2, Военный: 3, Раненый: 4, Зомбированный: 5"
    },
    
    OnRun = function(self, player, arguments)
        -- хихихихи все в sv_
        return
    end
})

ix.util.Include("sv_animations.lua")