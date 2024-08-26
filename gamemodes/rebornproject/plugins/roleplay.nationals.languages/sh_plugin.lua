local PLUGIN = PLUGIN
PLUGIN.name = "Национальности"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[
Много музыки послушал пока это писал конечно

Locked Club - It's My Rave
Sewerslvt - Newlove
Sewerslvt - Lolibox
Sewerslvt - Antidepressant
Sewerslvt - Yandere Complex
Sewerslvt - The Maw
Sewerslvt (feat. Skvllz) - Blacklight
Sewerslvt - self destruction worldwide broadcast
gefalsht - АЙС ТУРБО РЕМИКС
merakisimon - Inside UNNV
interworld - metamorphosis 
https://www.youtube.com/watch?v=8kOBsUa3M0I
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
—————————————————————————————————————
]]

ix.util.Include("sh_langs.lua")

if CLIENT then

    netstream.Hook("DLLP", function(languageName)
        Derma_Query("Я уже изучаю "..languageName.." язык, забыть прогресс?", "Языки", "Да", function()
            netstream.Start("QueryDeleteLanguageSuccess")
        end, "Нет")
    end)
    
end

if SERVER then
    ix.util.Include("sv_hooks.lua")
end


ix.char.RegisterVar("languages", {
    field = "languages",
    default = {},
    isLocal = true,
    bNoDisplay = true
})

ix.char.RegisterVar("learningLanguages", {
    field = "learningLanguages",
    default = {},
    isLocal = true,
    bNoDisplay = true
})

do
    for _, v in pairs(ix.languages.stored) do
            for i = 1, 2 do
                local ITEM = ix.item.Register("audiobook_"..i..v.name, nil, false, nil, true)
                ITEM.name = "Выучить "..v.name.." - Часть "..i..""
                ITEM.category = "[REBORN] ALL PAPER`S"
                ITEM.model = "models/props_lab/binderredlabel.mdl"
                ITEM.description = "Книга состоящая из 2 глав, чтобы изучить "..v.name.." язык."

                ITEM.functions.Listen = {
                    OnRun = function(itemTable)
                        local client = itemTable.player
                        local character = client:GetCharacter()
                        local learningLanguages = character:GetLearningLanguages() or {}
                        local knownLanguages = character:GetLanguages() or {}

                        local cooldown = 86400
                        local time = os.time()

                        if (table.HasValue(knownLanguages, v.uniqueID)) then
                            client:NotifyLocalized("Ваш персонаж уже знает "..v.name.." язык!")
                            return false
                        end

                        if client.CantPlace then
                            client:NotifyLocalized("Вам нужно подождать перед тем, как использовать это вновь!..")
                            return false
                        end

                        if !table.IsEmpty(learningLanguages) and learningLanguages[1] then
                            if learningLanguages[1].name then
                                client.CantPlace = true

                                timer.Simple(3, function()
                                    if client then
                                        client.CantPlace = false
                                    end
                                end)

                                if v.name != learningLanguages[1].name then
                                    netstream.Start(client, "DLLP", learningLanguages[1].name)
                                    return false
                                end

                                if v.name == learningLanguages[1].name then
                                    if learningLanguages[1].progress then
                                        if learningLanguages[1].progress + 1 != i then
                                            client:NotifyLocalized("Вам нужно прочесть главу "..tostring(tonumber(learningLanguages[1].progress) + 1).." из этой книги, чтобы узнать больше!")
                                            return false
                                        end

                                        local nextUse = learningLanguages[1].timestamp

                                        if time < nextUse then
                                            client:NotifyLocalized("Я слишком устал, мне нужно отдохнуть.")
                                            return false
                                        end

                                        learningLanguages[1].progress = math.Clamp(learningLanguages[1].progress + 1, 0, 5)
                                        learningLanguages[1].timestamp = time + cooldown

                                        if learningLanguages[1].progress == 2 then
                                            table.insert(knownLanguages, v.uniqueID)
                                            character:SetLanguages(knownLanguages)
                                            for k,v in pairs(knownLanguages) do
                                                character:SetData(v, true)
                                            end
                                            client:NotifyLocalized("Вы полностью изучили "..v.name.." язык!")

                                            table.Empty(learningLanguages)
                                            character:SetLearningLanguages(learningLanguages)
                                            character:SetData("LearnProgress", nil)
                                        else
                                            client:NotifyLocalized("Вы повысили уровень знания языка "..v.name.." на "..learningLanguages[1].progress)
                                            character:SetLearningLanguages(learningLanguages)
                                        end
                                    end
                                end
                            end
                        else
                            if string.find(itemTable.name, "1") then
                              --  if character:GetData("LearnProgress").progress == 1 then return client:NotifyLocalized("Вы уже изучили это!") false end
                                learningLanguages[1] = {name = v.name, progress = 0, timestamp = time + cooldown}
                                learningLanguages[1].progress = math.Clamp(learningLanguages[1].progress + 1, 0, 2)
                                
                                client:NotifyLocalized("Вы повысили уровень знания языка "..tostring(v.name).." на "..learningLanguages[1].progress)
                                character:SetLearningLanguages(learningLanguages)
                                character:SetData("LearnProgress", learningLanguages)
                            else
                                client:NotifyLocalized("Для начала вам необходимо прослушать первую часть!")
                                return false
                            end
                        end
                    end
                }
            end
    end
end
