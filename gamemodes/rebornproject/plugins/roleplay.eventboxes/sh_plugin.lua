local PLUGIN = PLUGIN

PLUGIN.name = "Система дропов"
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

ix.config.Add(
    "ItemDropCount",
    5,
    "Максимальное число предмета который может появится",
    nil,
    {
	    data = {min = 1, max = 15},
	    category = "Shipment Drops"
    }
)
ix.config.Add(
    "ItemsDropCount",
    5,
    "Максимальное число предметов которые могут появится",
    nil,
    {
	    data = {min = 1, max = 15},
	    category = "Shipment Drops"
    }
)
ix.config.Add(
    "ShipTimeout",
    600,
    "Через какое время ящик будет общедоступным? (секунды)",
    nil,
    {
	    data = {min = 10, max = 1200},
	    category = "Shipment Drops"
    }
)

PLUGIN.shipment_category ={
    ["MED"] = {     
        "aztreonam",
        "novox",
        "bintik",
        "fullmed",
        "paracetamol",
        "armbint",
        "shina",
        "perelom",
        "aztreonam_box",
        "novox_box",
        "paracetamol_box",
        "blindnessfixer",
        "pustpachka",
        "revivepill",
        "metro_medkit2",
        "metro_medkit",
        "keisa2",
        "keisa",
    },
    ["FOOD"] = {
        "kilka",
        "konscorn",
        "sgushenka",
        "morpeh",
        "konsche",
        "hleb",
        "sok",
    },
    ["SPORE"] = {
        "mushroomspores",
        "potatospore",
        "trufelspore",
    },
    ["OTHER"] = {
        "gasmask",
        "gasmask_filter",
        "hobo_kit",
        "glasses_5",
        "note",
        "morpeh",
        "emptybucket",
        "stallion",
        "padonok",
        "revoler",
        "ashot",
        "flare_b",
        "flare",
        "flare_g",
        "duplet",
        "chatter",
    },
    ["AMMOS"] = {
        "ammo_toplivo",
        "ammo_1270",
        "ammo_127x108",
        "ammo_15mm",
        "ammo_545x39",
        "ammo_762x51",
        "ammo_pistol",
    },
}
ix.command.Add("StartShipmentEvent", { -- создаем пустышку для отображения в чате, так как команда в СВ, и будет скрыта.
    description = "Создать ивент с дропом",
    superAdminOnly = true,
    arguments = {ix.type.string, ix.type.string},
    OnRun = function(self, client, faction_team, shipment_name) return end
})

ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_hooks.lua")
