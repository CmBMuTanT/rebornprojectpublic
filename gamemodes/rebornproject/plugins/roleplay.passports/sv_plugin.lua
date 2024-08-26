local PLUGIN = PLUGIN

local monthNames = {
    ["January"] = "Январь",
    ["February"] = "Февраль",
    ["March"] = "Март",
    ["April"] = "Апрель",
    ["May"] = "Май",
    ["June"] = "Июнь",
    ["July"] = "Июль",
    ["August"] = "Август",
    ["September"] = "Сентябрь",
    ["October"] = "Октябрь",
    ["November"] = "Ноябрь",
    ["December"] = "Декабрь",
}

local function localizeMonth(monthName)
    return monthNames[monthName] or monthName
end

netstream.Hook("cmbmtk.proceedpassport", function(client, passportID, Regtime, CharName, Gender, BornDate, National)

    if !client:IsValid() then return end
    if !client:GetCharacter() then return end
    local RegistrationDate = os.date("%d %B", os.time())
    local TranslatedMonth = localizeMonth(RegistrationDate:match("%s(%a+)$"))
    local RegtimeCurr = RegistrationDate:gsub("%s%a+$", " " .. TranslatedMonth)
    local GenderCurr = client:IsFemale() and "Женский" or "Мужской"
    local RegStr = client:GetNetVar("RegStr", RegStr)
    local RegImg = client:GetNetVar("RegImg", RegImg)

    if passportID ~= util.CRC(client:SteamID64()..client:GetCharacter():GetID()) then return end
    if Regtime ~= RegtimeCurr then return end
    if CharName ~= client:Name() then return end
    if Gender ~= GenderCurr then return end
    if National ~= client:GetNetVar("CharNational", National) then return end

    local character = client:GetCharacter()
    local inventory = character:GetInventory()

    if inventory:HasItem("passport") then client:Notify("У вас уже имеется паспорт!") return end

    if !inventory:Add("passport", 1, { PassportInfo = {["Уникальный номер"] = passportID, ["Дата Регистрации"] = Regtime, ["Имя"] = CharName, ["Пол"] = Gender, ["Дата Рождения"] = BornDate, ["Национальность"] = National, ["Выписано"] = RegStr, ["Печать"] = RegImg, },  PassportStamps = {RegImg}} ) then
        client:Notify("У вас недостаточно места в инвентаре!")
    end

    client:SetNetVar("RegStr", nil)
    client:SetNetVar("RegImg", nil)

end)


do
    local debug_getinfo = debug.getinfo
    local CurTime       = CurTime
    local rawget        = rawget
    local rawset        = rawset
    local setmetatable  = setmetatable

    local WEAK_REF_META = {__mode = "k"}

    --- Нужно будет перенести в отдельную "библиотеку"
    local function PlayerCallCooldown(ePly, nTime)
        local func = rawget(debug_getinfo(2, "f"), "func")
        if not func then return false end
        local function_calls = ePly.__function_calls__
        if not function_calls then
            function_calls = setmetatable({}, WEAK_REF_META)
            ePly.__function_calls__ = function_calls
        end
        local next_time = rawget(function_calls, func)
        local time = CurTime()
        if not next_time or next_time < time then
            rawset(function_calls, func, time + nTime)
            return true
        end
        return false
    end

    netstream.Hook("cmbmtk.PassportRequest", function(client)
        if not PlayerCallCooldown(client, 0.5) then return end
        client:SetNetVar("PassportRequest", nil)
        client:SetNetVar("PassportRequest2", nil)
    end)    
end

netstream.Hook("cmbmtk.passportbuystamp", function(client, stamp)
    local character = client:GetCharacter()
    local inventory = character:GetInventory()
    local item = inventory:HasItem("passport")
    local money = character:GetMoney()
    if money < 100 then client:Notify("У вас недостаточно пуль для покупки!") return end -- меняй цену здесь
    if !item then client:Notify("ERROR#1 invalid passport") return end

    local passportStamps = item:GetData("PassportStamps", {})
    table.insert(passportStamps, stamp)

    item:SetData("PassportStamps", passportStamps)
    character:TakeMoney(100) -- и вот здесь
end)


