
local PLUGIN = PLUGIN

PLUGIN.name = "Better Crafting++"
PLUGIN.author = "wowm0d (original creation) + БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"


ix.util.Include("cl_hooks.lua", "client")
ix.util.Include("sh_hooks.lua", "shared")
ix.util.Include("meta/sh_recipe.lua", "shared")
ix.util.Include("meta/sh_station.lua", "shared")


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
--ix.util.Include("sv_plugin.lua") в этой сборке его не существует. Пользуйтесь опенсурсом.

ix.char.RegisterVar("recipes", {
    field = "recipes",
    default = {},
    isLocal = true,
    bNoDisplay = true
})

function PLUGIN:PostPlayerLoadout(client)
	if !client:IsValid() then return end

	local character = client:GetCharacter()
	if character then
		local data = character:GetData("knownRecipes")
		character:SetRecipes(data)
	end
end

timer.Simple(0.1, function()
	for k,v in pairs(PLUGIN.craft.recipes) do
		if v.isDefaultLearn then continue end
		local ITEM = ix.item.Register("recipebook_"..v.uniqueID, nil, false, nil, true)
		ITEM.name = "Рецепт "..v.name..""
		ITEM.category = "[REBORN] ALL PAPER`S"
		ITEM.model = "models/props_lab/binderblue.mdl"
		ITEM.description = "Книга с рецептом: "..v.name.."."
		ITEM.functions.Read = {
			name = "Изучить",
			icon = "icon16/book_add.png",
			OnRun = function(item)
				local client = item.player
				local character = client:GetCharacter()
				local knownRecipes = character:GetRecipes()

				if (table.HasValue(knownRecipes, v.uniqueID)) then
					client:NotifyLocalized("Ваш персонаж уже знает чертеж "..v.name.."!")
					return false
				end

				table.insert(knownRecipes, v.uniqueID)
				character:SetRecipes(knownRecipes)

				character:SetData("knownRecipes", knownRecipes)
			
				return true
			end
		}
	end
end)
do
	local ITEM = ix.item.Register("mutievs_bible", nil, false, nil, true)
	ITEM.name = "⛧Библия Мутьева⛧"
	ITEM.category = "[REBORN] ALL PAPER`S"
	ITEM.exRender = true
	ITEM.model = "models/props_c17/FurnitureDrawer003a.mdl"
	ITEM.width = 1
	ITEM.height = 1
	ITEM.iconCam = {
		pos = Vector(15.59, 1.47, 199.43),
		ang = Angle(86.2, 179.67, 0),
		fov = 3.58
	}


	ITEM.description = "Довольно странная книга, с пентаграммой на обложке, стоит ли мне ее читать?"
	ITEM.functions.Read = {
		name = "Прочесть",
		icon = "icon16/book_error.png",
		OnRun = function(item)
			local client = item.player
			local character = client:GetCharacter()
			local knownRecipes = character:GetRecipes()
			client:EmitSound("mtkbible/vo/"..math.random(1,4)..".wav")
			table.Empty(knownRecipes)

			for k,v in pairs(PLUGIN.craft.recipes) do

				table.insert(knownRecipes, v.uniqueID)
				character:SetRecipes(knownRecipes)
				character:SetData("knownRecipes", knownRecipes)
			end

			return true
		end
	}

	if CLIENT then
		function ITEM:PopulateTooltip(tooltip)
			local name = tooltip:GetRow("name")
			timer.Create("SBCHSV", 0.01, 0, function()
				if !IsValid(name) then return end
				name:SetBackgroundColor(HSVToColor( CurTime() * 75 % 360, 1, 1 ))
			end)
		end
	end

end
