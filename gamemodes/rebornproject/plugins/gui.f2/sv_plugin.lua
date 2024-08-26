local PLUGIN = PLUGIN

tablelines = {} -- массив с датой (пока имеет пустое значение)

local voicelines = {
    [1] = {
        "anekdoti/anekdot1.wav",
        "anekdoti/anekdot10.wav",
        "anekdoti/anekdot11.wav",
        "anekdoti/anekdot2.wav",
        "anekdoti/anekdot3.wav",
        "anekdoti/anekdot4.wav",
        "anekdoti/anekdot5.wav",
        "anekdoti/anekdot6.wav",
        "anekdoti/anekdot7.wav",
        "anekdoti/anekdot8.wav",
        "anekdoti/anekdot9.wav",
    }, -- Key 1 (Угрозы)

    [2] = {
        "idle/idleqanons_15.wav",
        "idle/idleqanons_16.wav",
        "idle/idleqanons_17.wav",
        "idle/idleqanons_18.wav",
        "idle/idleqanons_19.wav",
        "idle/idleqanons_20.wav",
        "idle/idleqanons_23.wav",
        "idle/idleqanons_24.wav",
        "idle/idleqanons_27.wav",
        "idle/idleqanons_33.wav",
    },
    
    [3] = {
        "storyh/story_1.wav",
        "storyh/story_2.wav",
        "storyh/story_3.wav",
        "storyh/story_4.wav",
        "storyh/story_5.wav",
        "storyh/story_6.wav",
    }-- Key 2 (Враг обнаружен)
-- Key 3 (IDLE озвучка, скорее просто рандомные звуки по типу "эх щас пожрать бы", "я писька?", "кто-то кто-то умер, кто то бухает, кого то жить заебала, и т.д")

    -- [4] = {
    --     "SND.wav",
    -- },
    -- Можешь создать их хоть 999999999999999999999999999999999

    
} -- создаем МАССИВ В МАССИВЕ с войслайнами и НУМЕРУЕМ их дабы выдавало нам значения KEY для разных войслайнов

local specialtbl = {

    ---------vdnh---------
    [1] = {
        "idle/idleqanons_33.wav",
    },
    [2] = {
        "idle/idleqanons_16.wav",
    },
    [3] = {
        "idle/idleqanons_18.wav",
    },
    [4] = {
        "attack/stalkers/stalkerssattack_6.wav",
    },
    [5] = {
        "ranenie/neutral/neutralranenie_1.wav",
    },


    ---------reich---------
    [6] = {
        "idle/idleqanons_19.wav", --кашель
    },
    [7] = {
        "attack/reich/reichattack_3.wav", --угрозы кловцу
    },
    [8] = {
        "dobitie/ubitie/attackub_8.wav", --сдохни
    },
    [9] = {
        "idle/idleqanons_7.wav", --легкая паника
    },
    [10] = {
        "idle/idleqanons_9.wav", --рассуждение о кловцах
    },

    [11] = {
    "idle/idleqanons_47.wav",
    },


    -------Hanza
    [12] = {
        "idle/idleqanons_8.wav",
    },

    [13] = {
        "idle/idleqanons_31.wav",
    },

    [14] = {
        "idle/idleqanons_27.wav",
    },

    [15] = {
        "ranenie/neutral/neutralranenie_2.wav",
    },

    [16] = {
        "attack/stalkers/stalkerssattack_2.wav",
    },

    [17] = {
        "idle/idleqanons_44.wav",
    },



    ---citizen
    [18] = {
        "idle/idleqanons_46.wav",
    },

    [19] = {
        "idle/idleqanons_38.wav",
    },

    [20] = {
        "idle/idleqanons_37.wav",
    },

    [21] = {
        "attack/stalkers/stalkerssattack_5.wav",
    },

    [22] = {
        "ranenie/neutral/neutralranenie_4.wav",
    },

    [23] = {
        "attack/bratva/bratvasattack_1.wav",
    },

    [24] = {
        "idle/idleqanons_16.wav",
    },

    ---spartan
    [25] = {
        "idle/idleqanons_35.wav",
    },

    [26] = {
        "idle/idleqanons_6.wav",
    },

    [27] = {
        "idle/idleqanons_29.wav",
    },

    [28] = {
        "idle/idleqanons_15.wav",
    },

    [29] = {
        "idle/idleqanons_11.wav",
    },

    [30] = {
        "idle/idleqanons_14.wav",
    },
    

    ---polis
    [31] = {
        "idle/idleqanons_35.wav",
    },

    [32] = {
        "idle/idleqanons_6.wav",
    },

    [33] = {
        "idle/idleqanons_29.wav",
    },

    [34] = {
        "idle/idleqanons_15.wav",
    },

    [35] = {
        "idle/idleqanons_11.wav",
    },

    [36] = {
        "idle/idleqanons_14.wav",
    },
    

    ---redline
    [37] = {
        "idle/idleqanons_51.wav",
    },

    [38] = {
        "idle/idleqanons_52.wav",
    },

    [39] = {
        "idle/idleqanons_22.wav",
    },

    [40] = {
        "idle/idleqanons_13.wav",
    },

    [41] = {
        "idle/idleqanons_28.wav",
    },

    [42] = {
        "idle/idleqanons_39.wav",
    },
    
    [43] = {
        "idle/idleqanons_19.wav",
    },

    --bandits
    [44] = {
        "idle/idleqanons_42.wav",
    },

    [45] = {
        "idle/idleqanons_45.wav",
    },

    [46] = {
        "idle/idleqanons_15.wav",
    },

    [47] = {
        "attack/bratva/bratvasattack_4.wav",
    },

    [48] = {
        "attack/bratva/bratvasattack_12.wav",
    },

    [49] = {
        "attack/bratva/bratvasattack_5.wav",
    },
    

    --other
    [50] = {
        "attack/spartan/spartansattack_1.wav",
    },
    [51] = {
        "attack/spartan/spartansattack_2.wav",
    },
    [52] = {
        "attack/spartan/spartansattack_3.wav",
    },
    [53] = {
        "ranenie/bratva/bratvaranenie_9.wav",
    },
    [54] = {
        "ranenie/bratva/bratvaranenie_3.wav",
    },
    [55] = {
        "ranenie/bratva/bratvaranenie_1.wav",
    },
    [56] = {
        "attack/redline/redlinesattack_2.wav",
    },
    [57] = {
        "attack/redline/redlinesattack_1.wav",
    },
    [58] = {
        "attack/reich/reichattack_2.wav",
    },
    [59] = {
        "attack/reich/reichattack_7.wav",
    },
    [60] = {
        "ranenie/reich/reichranenie_1.wav",
    },
    [61] = {
        "idle/idleqanons_12.wav",
    },
    [62] = {
        "attack/spartan/spartansattack_4.wav",
    },
    [63] = {
        "idle/idleqanons_25.wav",
    },
    [64] = {
        "idle/idleqanons_26.wav",
    },
    [65] = {
        "ranenie/spartan/spartanranenie_1.wav",
    },
    [66] = {
        "free_40.wav",
    },
    [67] = {
        "free_20.wav",
    },
    [68] = {
        "free_44.wav ",
    },
    [69] = {
        "comissar_song.wav",
    },
    [70] = {
        "body_found_11.wav",
    },
    [71] = {
        "nazi_attack_1.wav",
    },
    [72] = {
        "uber_alert_alone_7.wav",
    },
    [73] = {
        "combat_idle_9.wav",
    },
    [74] = {
        "combat_idle_1.wav",
    },
    [75] = {
        "body_found_11bandits.wav",
    },
    
}

local choicevoiceline -- создаем пустую переменную
local voicelinecooldwon = 5 -- переменная задержки
local voicelineocs = 0 -- не трогай эту переменную ну или разбирайся в коде

-- function PLUGIN:ShowTeam(client) -- менюшка F2
--     if (client:GetCharacter()) then -- если клиент играет за персонажа тогда
--         netstream.Start(client, "OpenMenuPLZ") -- нетстрим (они дебилы юзали за место этого обычный net.Receive и net.send, ебланы хуле)
--     end
-- end

netstream.Hook("kickmepls", function(client) -- кикает человека в меню (я проверил пока делал войслайны у меня все работает ИДЕАЛЬНО, видимо ты полупокер полудурок)
    local char = client:GetCharacter() -- берет персонажа клиента который это вызывает
    char:Kick() -- кикает его
end)

netstream.Hook("VCstart", function(client, val) -- сами войслайны
    if !val then return end -- если нет значения Value -> конец
    if !voicelines[val] then return end -- если нет войслайнов[Value] -> конец
    if voicelines[val]then -- если войслайн[Value] тогда
        local voicelinetimeleft = voicelineocs - CurTime()
        if voicelinetimeleft < 0 then -- если времени осталось меньше нуля значит
            local randomchoicevoiceline = voicelines[val][math.random(1, #voicelines[val])] -- запоминает рандом (для STFU, ибо без этого он будет рандомизировать и то и другое)

            if choicevoiceline then -- если переменная CVL имеет какое либо значение (не NIL) тогда
                client:StopSound(choicevoiceline) -- стопим звук который был в прошлом
            end

            client:EmitSound(randomchoicevoiceline) -- издает звук который мы выбрали угрозы/враг/idle
            choicevoiceline = randomchoicevoiceline -- пустая переменная становится запоминающим ключом что мы выбрали в прошлом

            voicelineocs = CurTime() + voicelinecooldwon -- обновляем кулдаун
        else
            client:Notify("Ты попался на кулдаун! Жди еще: "..math.Round(voicelinetimeleft, 0).." Секунд(ы)!") -- Собственно кулдаун, спросишь А НАХУЯ ТУТ МОТЕМАТИКА, я тебе отвечу: Он убирает числа после точки. Чтоб не было 4.56748974865456 сек, а было ровно 0/1/2/3/4/5
        end
    end
end)


netstream.Hook("VCstartspec", function(client, val) -- сами войслайны
    if !val then return end -- если нет значения Value -> конец
    if !specialtbl[val] then return end -- если нет войслайнов[Value] -> конец
    if specialtbl[val]then -- если войслайн[Value] тогда
        local voicelinetimeleft = voicelineocs - CurTime()
        if voicelinetimeleft < 0 then -- если времени осталось меньше нуля значит
            local randomchoicevoiceline = specialtbl[val][math.random(1, #specialtbl[val])]

            if choicevoiceline then
                client:StopSound(choicevoiceline)
            end

            client:EmitSound(randomchoicevoiceline)
            choicevoiceline = randomchoicevoiceline

            voicelineocs = CurTime() + voicelinecooldwon
        else
            client:Notify("Ты попался на кулдаун! Жди еще: "..math.Round(voicelinetimeleft, 0).." Секунд(ы)!") -- Собственно кулдаун, спросишь А НАХУЯ ТУТ МОТЕМАТИКА, я тебе отвечу: Он убирает числа после точки. Чтоб не было 4.56748974865456 сек, а было ровно 0/1/2/3/4/5
        end
    end
end)

netstream.Hook("STFUSOUND", function(client, data)
    if !choicevoiceline then return end -- если звук пустой -> end
    client:StopSound(choicevoiceline) -- стопит звук, если звук сам остановился и при попытке его остановить нихуя не будет.
end)