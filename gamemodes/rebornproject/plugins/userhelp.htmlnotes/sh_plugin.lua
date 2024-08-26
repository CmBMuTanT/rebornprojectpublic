local PLUGIN = PLUGIN
PLUGIN.name = "Notes + Books [XHTML]"
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

ix.util.IncludeDir("libs")
ix.util.Include("sv_plugin.lua")

function ix.item:FindInstance(itemID)
	return self.instances[tonumber(itemID)]
end


PLUGIN.EditCodes = {
  [1] = {
		id = "[b]",
		hint = "Жирный",
		find = {"[b]", "[/b]"},
		replace = {"<b>", "</b>"},
		format = "[b]$&[/b]"
	},
  [2] = {
		id = "[i]",
		hint = "Курсив",
		find = {"[i]", "[/i]"},
		replace = {"<i>", "</i>"},
		format = "[i]$&[/i]"
	},
  [3] = {
		id = "[u]",
		hint = "Подчёркнутый",
		find = {"[u]", "[/u]"},
		replace = {"<u>", "</u>"},
		format = "[u]$&[/u]"
	},
  [4] = {
		id = "[large]",
		hint = "Огромный размер шрифта",
		find = {"[large]", "[/large]"},
		replace = {"<large>", "</large>"},
		format = "[large]$&[/large]"
	},
  [5] = {
		id = "[small]",
		hint = "Маленький размер шрифта",
		find = {"[small]", "[/small]"},
		replace = {"<small>", "</small>"},
		format = "[small]$&[/small]"
	},
  [6] = {
		id = "[big]",
		hint = "Большой размер шрифта",
		find = {"[big]", "[/big]"},
		replace = {"<big>", "</big>"},
		format = "[big]$&[/big]"
	},
  [7] = {
		id = "[center]",
		hint = "По центру",
		find = {"[center]", "[/center]"},
		replace = {"<center>", "</center>"},
		format = "[center]$&[/center]"
	},
  [8] = {
		id = "[list]",
		hint = "Список",
		find = {"[list]", "[/list]"},
		replace = {"<list>", "</list>"},
		format = "[list]$&[/list]"
	},
  [9] = {
		id = "[*]",
		hint = "Элемент в списке",
		find = {"[*]"},
		replace = {"<li>"},
		format = "[*]"
	},
  [10] = {
		id = "[hr]",
		hint = "Горизонтальная линия",
		find = {"[hr]"},
		replace = {"<hr>"},
		format = "[hr]"
	},
	[11] = {
		id = "[br]",
		hint = "Перенос строки",
		find = {"[br]"},	
		replace = {"<br>"},
		format = "[br]"
	},
  [12] = {
		id = "[blue]",
		hint = "Синий цвет",
		find = {"[blue]", "[/blue]"},
		replace = {"<blue>", "</blue>"},
		format = "[blue]$&[/blue]"
	},
  [13] = {
		id = "[red]",
		hint = "Красный цвет",
		find = {"[red]", "[/red]"},
		replace = {"<red>", "</red>"},
		format = "[red]$&[/red]"
	},
  [14] = {
		id = "[green]",
		hint = "Зеленый цвет",
		find = {"[green]", "[/green]"},
		replace = {"<green>", "</green>"},
		format = "[green]$&[/green]"
	},
  [15] = {
		id = "[sign]",
		hint = "Поставить подпись",
		find = false,
		replace = false,
		format = "[sign]"
	},
  [16] = {
		id = "[field]",
		hint = "Добавить поле ввода",
		find = false,
		replace = false,
		format = "[field]"
	},
  [17] = {
		id = "[img]",
		hint = "URL картинка",
		find = {"[img]", "[/img]"},
		replace = {"<img>", "</img>"},
		format = "[img]$&[/img]"
	},
}