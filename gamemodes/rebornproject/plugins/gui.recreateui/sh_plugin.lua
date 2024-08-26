local PLUGIN = PLUGIN

PLUGIN.name = "recreated UI"
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
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")

PLUGIN.itemstochoice = {
  -- [1] = {ItemUID = "tfa_metro_knife", price = 10},  
  -- [2] = {ItemUID = "weapon_hl2pipe", price = 10},  
  -- [3] = {ItemUID = "suhoipaek", price = 30},  
  -- [4] = {ItemUID = "canfood_conserve3", price = 10},  
  -- [5] = {ItemUID = "dinamo", price = 10},  
  -- [6] = {ItemUID = "repairkit", price = 15},  
  -- [7] = {ItemUID = "hobo_kit", price = 15},  
  -- [8] = {ItemUID = "geiger", price = 30},  
  -- [9] = {ItemUID = "techaabatt", price = 5},  
  -- [10] = {ItemUID = "helmet_shlem_29", price = 40},  
  -- [11] = {ItemUID = "siren", price = 50},  
  -- [12] = {ItemUID = "tfa_metro_lowlife", price = 15},  
  -- [13] = {ItemUID = "tfa_metro_exo_revolver", price = 15},  
  -- [14] = {ItemUID = "ammo_pistol", price = 5},  
}


if CLIENT then
  file.CreateDir("cmbmtkui")

  function DownloadIconFromURL(url, cback)
		local fname = url:match("([^/]+)$")
		if fname:match("^.+(%..+)$") == nil then
			fname = fname ..".png"
		end
		local path = "cmbmtkui/".. util.CRC(url) .."_".. fname

		if file.Exists(path, "DATA") then
			cback(Material("data/".. path, "mips"))
		else
			http.Fetch(url, function(img)
				file.Write(path, img)
				cback(Material("data/".. path, "mips"))
			end)
		end
	end
end



ix.config.Add(
    "Money to remove",
    100,
    "Сколько необходимо денег для удаления персонажа",
    nil,
    {
	    data = {min = 0, max = 10000},
	    category = "MoneyZ"
    }
)