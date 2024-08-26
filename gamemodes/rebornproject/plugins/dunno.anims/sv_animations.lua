-- Вообще этот файл юзлесс по итогу, Но я сделаю его так чтоб люди если твой сервер спиздят немного мозгами пошарили лол. Скорее всего у них это так же. Только он буквально пустой.

local PLUGIN = PLUGIN

ix.command.Add("CharMovementSeq", {
    description = "Изменить походку",
    adminOnly = false,
    arguments = ix.type.number,
    argumentNames = {
        "Стандарт: 1, Бандит: 2, Военный: 3, Раненый: 4, Зомбированный: 5"
    },
    OnRun = function(self, player, arguments)
        local sequence = arguments
        if sequence == 5 and player:GetUserGroup() == "user" and not player:GetCharacter():HasFlags("w") then
            player:Notify("Доступно только для администрации")
            sequence = 1
        end
        player:Notify("Вы изменили походку")
        player:SetNetVar("movementSequence", sequence)
    end
})
