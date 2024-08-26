local PLUGIN = PLUGIN

PLUGIN.name = "Казиныч"
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

PLUGIN.ToTradeItems = {
  --["uID"] = price,
  ["techaabatt"] = 5,
  ["techaaacum"] = 15,
  ["recharger"] = 10,
  ["repairkit"] = 2,
  ["hobo_kit"] = 2,
  ["suhoipaek"] = 5,
  ["r6s_suppr"] = 13,
  ["metro_2_db_ex_barrel"] = 4,
  ["r6s_grip_lowlife"] = 5,
  ["r6s_solid_grip"] = 4,
  ["healthkit"] = 7,
  ["balaclavas_4o1"] = 4,
  ["patch_10"] = 2,
  ["helmet_shapka_13"] = 5,
  ["korobkaamm"] = 10,
  ["vedra"] = 25,
  ["helmet_shlem_29"] = 6,
  ["helmet_shlem_29o1"] = 8,
  ["helmet_shlem_22"] = 18,
  ["oxygen2"] = 10,
  ["sirentwo"] = 25,
  ["tfa_metro_exo_ak47u"] = 45,
}

--не рекомендую добавлять больше, стандарта хватит
PLUGIN.coinstable = {
	["Обменять на 1 монету"] = 1,
	["Обменять на 2 монеты"] = 2,
	["Обменять на 5 монет"] = 5,
	["Обменять на 10 монет"] = 10,
	["Обменять на 20 монет"] = 20,
	["Обменять на 50 монет"] = 50,
	["Обменять на 100 монет"] = 100,
}

PLUGIN.Mouses = {
  [1] = {
      name = "«Бздюбель»",
      description = [[Бздюбель - обычная крыса, которая была выкуплена у жителей станции. Скорее всего, его начальная судьба ложилась через гастрономический ряд жизненных аспектов станции, но теперь - он фактическое звено развлекательных игр! Вот она, судьба.. Куда только не завернёт, не так-ли?]],
      skinnum = 0, -- добавьте скины на крыс и ставьте это значение
      wins = 0,
      ratio = 0,
  },
  [2] = {
      name = "«Юлиан»",
      description = [[Юлиан - был специально выращен на «Арбатской», на нём, как ходят слухи.. Испытывали специальные препараты для повышения способностей солдат, но ничего не добившись - просто отпустили. Ну, а дальше - его судьба легла через рынок на Кольце, потому он здесь и оказался.. Кто-ж знает, может, эксперименты учёных с Полиса - дали свои плоды?]],
      skinnum = 0,
      wins = 0,
      ratio = 0,
  },
  [3] = {
      name = "«Дымок»",
      description = [[Дымок - был отловлен в тоннелях близь «Рижской», и буквально с первого дня он начал поражать публику своим умом.. Нет-нет, Дымок - явно не простая крыса! Это крыса с умом, с хитростью.. Быть может, она и принесет вам удачи и богатства?]],
      skinnum = 0,
      wins = 0,
      ratio = 0,
  },
}

local nextrefresh = 0
function PLUGIN:Think() -- auto-refresh sell items

  if CurTime() > nextrefresh then
    PLUGIN.TempItemsToTrade = {}

    local itemsToAdd = {}
    
    for item, count in pairs(PLUGIN.ToTradeItems) do
      table.insert(itemsToAdd, {item = item, count = count})
    end
    
    for i = 1, math.random(10) do
      if #itemsToAdd > 0 then
      local randomIndex = math.random(1, #itemsToAdd)
      table.insert(PLUGIN.TempItemsToTrade, itemsToAdd[randomIndex])
      table.remove(itemsToAdd, randomIndex)
      end
    end

    nextrefresh = CurTime() + 14400 -- в секундах (4 часа на данный момент)
  end
end



if CLIENT then
  netstream.Hook("Obmen:OpenMenu", function(items)
      local menu = vgui.Create("CMBMTK:NPCOBMENNIK")
      menu:SetItems(items)
  end)

  netstream.Hook("MouseRun:OpenMenu", function(mouses, mousessync)
    local menu = vgui.Create("CMBMTK:MOUSEMENU")
    menu:SetMouses(mouses, mousessync)
  end)

  netstream.Hook("Thimbles:OpenMenu", function()
    Derma_StringRequest(
      "Ставка", 
      "Введите ставку",
      "1",
      function(bet) 
          local client = LocalPlayer()
          local character = client:GetCharacter()
          local inv = character:GetInventory()
          local item = inv:HasItem("casinocoin")

          if !isnumber(tonumber(bet)) then client:Notify("Ставка должна быть числом или цифрой!") return end
          if tonumber(bet) <= 0 then client:Notify("Thimbles ERROR#1 Некорректная ставка!") return end
          if !item then client:Notify("У вас недостаточно средств для этого!") return end
          if item:GetData("stacks", 1) < tonumber(bet) then client:Notify("У вас недостаточно средств для этого!") return end

         local menu = vgui.Create("CMBMTK:THIMBLES")
         menu:SetBet(bet)
      end
    )
  end)
end