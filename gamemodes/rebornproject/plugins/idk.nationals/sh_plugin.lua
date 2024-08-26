local PLUGIN = PLUGIN
PLUGIN.name = "Национальности"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[
Locked Club feat. Vadim Seleznev - Svoboda
RLGN - Rave Me Tender
Any Act - Amo Delphino
Locked Club, RLGN - Nega arashi
———————————No cmbmutant.xyz?———————————
⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
—————————————————————————————————————secondlanguage="0"
]]

PLUGIN.nationals = {
    ["RUSSIANS"] = {name = "Русский", chance = 0.28, secondlanguage="nil"},
    ["TATARS"] = {name = "Татар", chance = 0.07, secondlanguage="tat"},
    ["UKRANIANS"] = {name = "Украинец", chance = 0.08, secondlanguage="ua"},
    ["BASHKIRS"] = {name = "Башкир", chance = 0.01, secondlanguage="bas"},
    ["CHUVAS"] = {name = "Чуваш", chance = 0.01, secondlanguage="chu"},
    ["CHECHENES"] = {name = "Чеченец", chance = 0.01, secondlanguage="che"},
    ["ARMYANS"] = {name = "Армян", chance = 0.01, secondlanguage="arm"},
    ["BELORUSES"] = {name = "Белорус", chance = 0.01, secondlanguage="bel"},
    ["KAZAHS"] = {name = "Казах", chance = 0.01, secondlanguage="kz"},
    ["AZERS"] = {name = "Азербайджанец", chance = 0.01, secondlanguage="azer"},
    ["GERMANS"] = {name = "Немец", chance = 0.01, secondlanguage="ger"},
    ["KABARDS"] = {name = "Кабардин", chance = 0.02, secondlanguage="cab"},
    ["OSETNIS"] = {name = "Осетин", chance = 0.04, secondlanguage="ose"},
    ["BURYATS"] = {name = "Бурят", chance = 0.02, secondlanguage="bur"},
    ["YAKUTS"] = {name = "Якут", chance = 0.03, secondlanguage="yak"},
    ["TUVINES"] = {name = "Тувинец", chance = 0.02, secondlanguage="tuv"},
    ["JEWS"] = {name = "Еврей", chance = 0.03, secondlanguage="evr"},
    ["GRUZINS"] = {name = "Грузин", chance = 0.04,secondlanguage="gru"},
    ["CHIGANS"] = {name = "Цыган", chance = 0.04, secondlanguage="cig"},
    ["KAZAKS"] = {name = "Казак", chance = 0.03, secondlanguage="kaz"},
    ["UZBEKS"] = {name = "Узбек", chance = 0.02, secondlanguage="uzb"},
    ["TADJIKS"] = {name = "Таджик", chance = 0.05, secondlanguage="tdj"},
    ["GREKS"] = {name = "Грек", chance = 0.01, secondlanguage="gre"},
    ["POLANDS"] = {name = "Поляк", chance = 0.01, secondlanguage="pol"},
    ["LITOVS"] = {name = "Литовец", chance = 0.02, secondlanguage="lit"},
    ["KITAETSI"] = {name = "Китаец", chance = 0.01, secondlanguage="chi"},
    ["FINNS"] = {name = "Финн", chance = 0.02, secondlanguage="fin"},
    ["BOLGARS"] = {name = "Болгар", chance = 0.01, secondlanguage="bul"},
    ["KIRGIZS"] = {name = "Киргиз", chance = 0.02, secondlanguage="krgz"},
    ["LATISH"] = {name = "Латыш", chance = 0.01, secondlanguage="lat"},
    ["ESTONIA"] = {name = "Эстонец", chance = 0.01, secondlanguage="est"},
    ["SERBS"] = {name = "Серб", chance = 0.01, secondlanguage="ser"},
    ["VENGR"] = {name = "Венгр", chance = 0.01, secondlanguage="hun"},
    ["CHECH"] = {name = "Чех", chance = 0.01, secondlanguage="che"},
}

if SERVER then
    ix.util.Include("sv_plugin.lua")
end

if CLIENT then
    function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
        local national = client:GetNetVar("CharNational")
        if national then 
            local panel = tooltip:AddRowAfter("name", "national")
            panel:SetBackgroundColor(Color(255, 255, 255)) 
            panel:SetText("Выглядит как "..national)
            panel:SizeToContents()
        end
    end	
end

ix.command.Add("NationalDataSettingPlayer", {
    arguments = {
        ix.type.character,
        ix.type.string
    },
    description = "Сменить национальность игрока",
    AdminOnly = true,
    OnRun = function(self, client, target, national)
        local targetply = target:GetPlayer()
    
        targetply:SetNationalData(national)
    end
})