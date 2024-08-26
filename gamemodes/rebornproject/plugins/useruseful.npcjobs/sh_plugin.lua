local PLUGIN = PLUGIN

PLUGIN.name = "Нпс-Работяги"
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

PLUGIN.WorkProgress = PLUGIN.WorkProgress or {}
PLUGIN.Works = {"electro", "garbage"}

ix.util.Include("cl_plugin.lua")


ix.config.Add("Respawn Electro Minimal", 10, "Сколько времени понадобится для полома счетчика? (минимальное число секунд)", nil, {
  data = {min = 1, max = 1200},
	category = "Amogus Jobs"
})

ix.config.Add("Respawn Electro Max", 60, "Сколько времени понадобится для полома счетчика? (максимальное число секунд)", nil, {
  data = {min = 1, max = 1200},
	category = "Amogus Jobs"
})

ix.config.Add("Respawn Garbage Minimal", 10, "Сколько времени понадобится для респавна мусора? (минимальное число секунд)", nil, {
  data = {min = 1, max = 1200},
	category = "Amogus Jobs"
})

ix.config.Add("Respawn Garbage Max", 60, "Сколько времени понадобится для респавна мусора? (максимальное число секунд)", nil, {
  data = {min = 1, max = 1200},
	category = "Amogus Jobs"
})

ix.config.Add("Amout of Work", 3, "Сколько нужно поработать для получения зарплаты?", nil, {
  data = {min = 1, max = 24},
	category = "Amogus Jobs"
})

ix.config.Add("PayMin", 1, "Сколько нпс платит за смену? (мин число)", nil, {
  data = {min = 1, max = 100},
	category = "Amogus Jobs"
})

ix.config.Add("PayMax", 7, "Сколько нпс платит за смену? (макс число)", nil, {
  data = {min = 1, max = 100},
	category = "Amogus Jobs"
})

ix.config.Add("Work Cooldown", 10, "Через какое время можно начинать работу вновь? (в секундах)", nil, {
  data = {min = 1, max = 1200},
	category = "Amogus Jobs"
})

if SERVER then
  util.AddNetworkString("MiniGameElectro_Start")
  util.AddNetworkString("MiniGameElectro_ButtonClicked")
end
