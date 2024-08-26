local PLUGIN = PLUGIN

PLUGIN.name = "Item Spawner"
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

if CLIENT then
  net.Receive("ixItemSpawnerManager", function()
    vgui.Create("ixItemSpawnerManager"):Populate(net.ReadTable())
  end)  
end

CAMI.RegisterPrivilege({
	Name = "Helix - Item Spawner",
	MinAccess = "admin"
})

PLUGIN.ItemCategoryes = {
  ["Musor"] = {
    "ampuls",
    "itemkraska1",
    "gaiki",
    "iboltis3",
    "hilzaa",
    "iboltis84",
    "gavnashky",
    "iboltis8655",
    "iboltis76",
    "iboltis71",
    "iboltis70",
    "iboltis80",
    "iboltis77",
    "itemcraft4",
    "marla",
    "isexyidontknow2222",
    "itemhlopok555",
    "itemhlopok3",
    "itemhlopok5555",
    "iboltis79",
    "itemcraft555",
    "iboltis010",
    "itemcraft45",
    "isexyidontknow2954566",
    "rubbls",
    "isexyidontknow266234",
    "oorohtop",
    "oorohlow",
    "oorohmedium",
    "bankpus",
    "iboltis81",
    "mshpr",
    "iboltis83",
    "itembroneplitabroken1",
    "itembroneplitabroken2",
    "itembroneplitabroken3",
    "isexyidontknow2662",
    "kirzunka",
    "armkraska",
    "spirtaga26655",
    "iboltis74",
    "iboltis72",
    "isexyidontknow26655",
    "iboltis2",
    "itembroneplitabroken4",
    "itemhlopok23",
    "itemhlopok1",
    "itemsherst1",
    "iboltis865",
    "iboltis",
    "isexyidontknow2221",
    "isexyidontknow",
    "gunoiilss",
    "itemcraft656",
    "itemcraft666",
    "mooka",
    "pillow",
    "roadsign",
    "lighter",
    "kallian",
    "conserve",
    "nuclearothod",
    "plastmassa",
    "derevyashka",
    "krisa",
    "slomannypropan",
    "slomannygsmask",
    "leska",
    "gilza",
    "binto2",
    "healthkit",
    "canfood_conserve2",
    "canfood_conserve3",
    "canfood_sugar",
    "canfood_sguha",
    "ammo_pistol",
    "ammo_545x39",
    "ammo_1270",
    "mohovikspore",
    "mushroomspores",
    "potatospore",
    "trufelspore",
  },
}

ix.command.Add("ItemSpawnerAdd", {
	description = "Item Spawner Add",
	privilege = "Item Spawner",
	superAdminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, category)
		local location = client:GetEyeTrace().HitPos
		location.z = location.z + 10

    category = string.upper(string.sub(category, 1, 1)) .. string.sub(category, 2)

    if !PLUGIN.ItemCategoryes[category] then client:ChatPrint("Такой категории не существует! Вот список всех категорий: \n Musor/Usesly") return end

		PLUGIN:AddSpawner(client, location, category)
	end
})

ix.command.Add("ItemSpawnerList", {
	description = "@cmdItemSpawnerList",
	privilege = "Item Spawner",
	superAdminOnly = true,
	OnRun = function(self, client)
    print(#PLUGIN.spawner.positions)
		if (#PLUGIN.spawner.positions == 0) then
			return "We don't have a spawnpoints yet"
		end
		net.Start("ixItemSpawnerManager")
			net.WriteTable(PLUGIN.spawner.positions)
		net.Send(client)
	end
})
