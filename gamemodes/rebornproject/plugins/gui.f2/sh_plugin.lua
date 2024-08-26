local PLUGIN = PLUGIN
PLUGIN.name = "F2 menu"
PLUGIN.author = ""
PLUGIN.description = ""

PLUGIN.teamtbl = {
    ["vdnh"] = {
        ["Рассуждение о еде"] = 1,
        ["Кашель"] = 2,
        ["Грустный вздох"] = 3,
        ["``Жареным запахло``"] = 4,
        ["``Ты что творишь?``"] = 5,
        ["Эх, не тот уже хабар пошел.."] = 63,
        ["От судьбы - не скроешься.."] = 64,
    },

    ["reich"] = {
        ["Кашель"] = 6,
        ["Угрозы для КЛ"] = 7,
        ["Сдохни!"] = 8,
        ["Лёгкая паника"] = 9,
        ["Рассуждение о КЛ"] = 10,
        ["Я их вижу!"] = 11,
        ["Да ты просто супермэн!"] = 52,
        ["Найдем свинью краснопузую!"] = 58,
        ["Молодец, работаем-работаем!"] = 59,
        ["Противник, уничтожить!"] = 60,
        ["Слава победе!"] = 71,
        ["Красные атакуют!"] = 72,
        ["Москвин - капут!"] = 73,
        ["Сдавайся, коммуняка!"] = 74,
    },

    ["hanza"] = {
        ["Лучше перестраховаться!"] = 12,
        ["Рассуждение об обуви"] = 13,
        ["Вздох"] = 14,
        ["Я буду жаловаться!"] = 15,
        ["Огонь! Огонь!"] = 16,
        ["Можно перекурить?"] = 17,
        ["Кусок бы мяса.."] = 61,
        ["Вперед, врага найти - и уничтожить!"] = 62,
    },

    ["citizenmetro"] = {
        ["Етить твою кочерыжку!"] = 18,
        ["Ну всё, с богом."] = 19,
        ["Будьте вы прокляты, сволочи!"] = 20,
        ["Ух, ну и дадим мы им.."] = 21,
        ["Караул! Убивают!"] = 22,
        ["Конец тебе!"] = 23,
        ["Кашель"] = 24,
    },

    ["stg"] = {
        ["Етить твою кочерыжку!"] = 18,
        ["Ну всё, с богом."] = 19,
        ["Будьте вы прокляты, сволочи!"] = 20,
        ["Ух, ну и дадим мы им.."] = 21,
        ["Караул! Убивают!"] = 22,
        ["Конец тебе!"] = 23,
        ["Кашель"] = 24,
    },

    ["newwail"] = {
        ["Етить твою кочерыжку!"] = 18,
        ["Ну всё, с богом."] = 19,
        ["Будьте вы прокляты, сволочи!"] = 20,
        ["Ух, ну и дадим мы им.."] = 21,
        ["Караул! Убивают!"] = 22,
        ["Конец тебе!"] = 23,
        ["Кашель"] = 24,
    },

    ["gpr"] = {
        ["Етить твою кочерыжку!"] = 18,
        ["Ну всё, с богом."] = 19,
        ["Будьте вы прокляты, сволочи!"] = 20,
        ["Ух, ну и дадим мы им.."] = 21,
        ["Караул! Убивают!"] = 22,
        ["Конец тебе!"] = 23,
        ["Кашель"] = 24,
    },

    ["spart"] = {
        ["Отличная вещь!"] = 25,
        ["Какого хрена вам от меня надо?"] = 26,
        ["Пожрать бы чего.."] = 27,
        ["Вздох"] = 28,
        ["Плохая еда.."] = 29,
        ["И никого на горизонте.."] = 30,
        ["Сдавайся, и останешься жив!"] = 50,
        ["Ну, пошли за нашивками!"] = 51,
        ["Кто посеял ветер - пожнёт бурю."] = 65,
    },

    ["polis"] = {
        ["Отличная вещь!"] = 31,
        ["Какого хрена вам от меня надо?"] = 32,
        ["Пожрать бы чего.."] = 33,
        ["Вздох"] = 34,
        ["Плохая еда.."] = 35,
        ["И никого на горизонте.."] = 36,
    },

    ["redline"] = {
        ["Служу Красной Линии!"] = 37,
        ["По всем подозрительным - огонь без приказа!"] = 38,
        ["Новичков нынче.."] = 39,
        ["Квасу бы.."] = 40,
        ["Настроения - хуже не бывает."] = 41,
        ["Тревога!"] = 42,
        ["Кашель"] = 43,
        ["Подохни, контра!"] = 56,
        ["Тревога! К бою!"] = 57,
        ["О службе"] = 66,
        ["Страх"] = 67,
        ["О форме"] = 68,
        ["Прифронтовая песня"] = 69,
        ["!!!ТРЕВОГА!!!"] = 70,

    },

    ["bandits"] = {
        ["Твоё место - у параши!"] = 44,
        ["Не верещи, не поможет!"] = 45,
        ["Вздох"] = 46,
        ["Порву сука, как грелку!"] = 47,
        ["Вали лошару!"] = 48,
        ["Братва, ищите терпилу!"] = 49,
        ["Кашель"] = 43,
        ["Братву лохи валят!"] = 53,
        ["Гасите всех чужаков!"] = 54,
        ["Братва - шухер!"] = 55,
        ["Пацаны, труп!"] = 75,
    },
    ["chinatown"] = {
        ["Твоё место - у параши!"] = 44,
        ["Не верещи, не поможет!"] = 45,
        ["Вздох"] = 46,
        ["Порву сука, как грелку!"] = 47,
        ["Вали лошару!"] = 48,
        ["Братва, ищите терпилу!"] = 49,
        ["Кашель"] = 43,
        ["Братву лохи валят!"] = 53,
        ["Гасите всех чужаков!"] = 54,
        ["Братва - шухер!"] = 55,
        ["Пацаны, труп!"] = 75,
    },
    
    ["yasenevka"] = {
        ["Рассуждение о еде"] = 1,
        ["Кашель"] = 2,
        ["Грустный вздох"] = 3,
        ["``Жареным запахло``"] = 4,
        ["``Ты что творишь?``"] = 5,
        ["Эх, не тот уже хабар пошел.."] = 63,
        ["От судьбы - не скроешься.."] = 64,
    },
    ["detimetro"] = {
        ["Рассуждение о еде"] = 1,
        ["Кашель"] = 2,
        ["Грустный вздох"] = 3,
        ["``Жареным запахло``"] = 4,
        ["``Ты что творишь?``"] = 5,
        ["Эх, не тот уже хабар пошел.."] = 63,
        ["От судьбы - не скроешься.."] = 64,
    },
    ["gpr"] = {
        ["Рассуждение о еде"] = 1,
        ["Кашель"] = 2,
        ["Грустный вздох"] = 3,
        ["``Жареным запахло``"] = 4,
        ["``Ты что творишь?``"] = 5,
        ["Эх, не тот уже хабар пошел.."] = 63,
        ["От судьбы - не скроешься.."] = 64,
    },
    ["emirat"] = {
        ["Рассуждение о еде"] = 1,
        ["Кашель"] = 2,
        ["Грустный вздох"] = 3,
        ["``Жареным запахло``"] = 4,
        ["``Ты что творишь?``"] = 5,
        ["Эх, не тот уже хабар пошел.."] = 63,
        ["От судьбы - не скроешься.."] = 64,
    },
    ["newwawilon"] = {
        ["Рассуждение о еде"] = 1,
        ["Кашель"] = 2,
        ["Грустный вздох"] = 3,
        ["``Жареным запахло``"] = 4,
        ["``Ты что творишь?``"] = 5,
        ["Эх, не тот уже хабар пошел.."] = 63,
        ["От судьбы - не скроешься.."] = 64,
    },
}

-- local function Recognize(level)
--     net.Start("ixRecognize")
--         net.WriteUInt(level, 2)
--     net.SendToServer()
-- end


if CLIENT then

    local function VoiceDistance(levelvoice)
		net.Start("ixVoiceDistan")
			net.WriteUInt(levelvoice, 2)
		net.SendToServer()
	end
        
    function DrawArgsBox(strTitle, strBtn, strDefaultText, strSecondDefaultText, secondText, fnEnter)
        secondText = secondText or false

        local w, h
        local number

        if secondText then
            w, h = 250, 200
            number = 3
        else
            w, h = 250, 100
            number = 2.35
        end

        local Window = vgui.Create ("DFrame")
        Window:SetTitle (strTitle)
        Window:ShowCloseButton(true)
        Window:MakePopup()
        Window:SetSize (w, h)
        Window:Center()
        Window:SetKeyboardInputEnabled(true)
        Window:SetMouseInputEnabled(true)
        
        local width, height = Window:GetSize()

        local TextEntr = vgui.Create("ixTextEntry", Window)
        TextEntr:SetFont("ixMenuButtonFont")
        TextEntr:Dock(TOP)
        TextEntr:SetSize(width, height / number)
        TextEntr:SetText(strDefaultText || "")

        local TextEntr2 = vgui.Create("ixTextEntry", Window)
        TextEntr2:SetFont("ixMenuButtonFont")
        TextEntr2:Dock(TOP)
        TextEntr2:SetSize(width, height / number)
        TextEntr2:SetText(strSecondDefaultText || "")
        TextEntr2:DockMargin(0, 5, 0, 0)
        if !secondText then
            TextEntr2:Hide()
        end

        local Btn = vgui.Create ("DButton", Window)
        Btn:SetText(strBtn)
        Btn:Dock(BOTTOM)
        Btn.DoClick = function ()
                if secondText then
                    fnEnter( TextEntr:GetValue(), TextEntr2:GetValue() )
                else
                    fnEnter( TextEntr:GetValue() )
                end
                Window:Remove()
        end
    end

    --netstream.Hook("OpenMenuPLZ", function(client, val)
    local Cooldown
    function PLUGIN:PlayerButtonDown(me, button)
        if button == KEY_B then
            if IsFirstTimePredicted() then
                if (Cooldown or 0) < CurTime() then
                    ix.option.Set("thirdpersonEnabled", nil) -- отключаем третье лицо

                    local client = LocalPlayer()

                    local scrW, scrH = ScrW(), ScrH()
                    local x, y = scrW - (scrW - 870), scrH - (scrH - 690)

                    local character = client:GetCharacter()
                    local clientFactionTable = ix.faction.Get(client:Team())
                    
                    local MENU = ix.plugin.Get("gui.f2_ui")
                    MENU:ClearOptions()
                    MENU:CreateRadialMenu()

                    local key = 0
                    
                    MENU:AddOption({
                        name = "Фразы",
                        icon = "control_play_blue",
                        newmenu = true,
                        callback = function()
                            MENU:ClearOptions()
                            MENU:CreateRadialMenu()

                            MENU:AddOption({
                                name = "Анекдоты",
                                icon = "control_play_blue",
                                callback = function()
                                    key = 1
                                    netstream.Start("VCstart", key)
                                end
                            })
                            

                            MENU:AddOption({
                                name = "IDLE",
                                icon = "control_play_blue",
                                callback = function()
                                    key = 2
                                    netstream.Start("VCstart", key)
                                end
                            })

                            MENU:AddOption({
                                name = "Истории",
                                icon = "control_play_blue",
                                callback = function()
                                    key = 3
                                    netstream.Start("VCstart", key)
                                end
                            })


                            MENU:AddOption({
                                name = "Спец. Озвучка",
                                icon = "clock_red",
                                newmenu = true,
                                callback = function()
                                    MENU:ClearOptions()
                                    MENU:CreateRadialMenu()

                                    local playerfaction = ix.faction.indices[LocalPlayer():Team()].uniqueID
                
                                        for k,v in pairs(PLUGIN.teamtbl) do
                                            if k == playerfaction then
                                                for k2, v2 in pairs(v) do
                                                    MENU:AddOption({
                                                        name = k2,
                                                        icon = "control_play_blue",
                                                        callback = function()
                                                            key = v2
                                                            netstream.Start("VCstartspec", key)
                                                        end
                                                    })                        
                                                end
                                            end
                                        end

                                end
                            })

                            MENU:AddOption({
                                name = "Остановить разговор",
                                icon = "cancel",
                                callback = function()
                                    netstream.Start("STFUSOUND")
                                end
                            })
                        end
                    })

                    MENU:AddOption({
                        name = "Анимации",
                        icon = "emoticon_smile",
                        newmenu = true,
                        callback = function()
                            MENU:ClearOptions()
                            MENU:CreateRadialMenu()

                            MENU:AddOption({
                                name = "Анимации",
                                icon = "clock_red",
                                newmenu = true,
                                callback = function()
                                    MENU:ClearOptions()
                                    MENU:CreateRadialMenu()
            MENU:AddOption({
                name = "Анимации [IDLE-1]",
                icon = "clock_red",
                newmenu = true,
                callback = function()
                    MENU:ClearOptions()
                    MENU:CreateRadialMenu()
        

                    MENU:AddOption({
                        name = "Сесть на корточки",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/ActSit1")	
                        end
                    })

                    MENU:AddOption({
                        name = "Сесть положив руку на ногу",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/ActSit2")	
                        end
                    })

                    MENU:AddOption({
                        name = "Сесть скрестив ноги",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/ActSit3")	
                        end
                    })

                    MENU:AddOption({
                        name = "Сесть скрестив ноги [2]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/ActSit4")	
                        end
                    })

                    MENU:AddOption({
                        name = "Сесть облокотившись на руку",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/ActSit5")
                        end
                    })

                    MENU:AddOption({
                        name = "Сесть положив руки на ноги",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/ActSit6")
                        end
                    })

                    MENU:AddOption({
                        name = "Прилечь на землю",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/ActSit7")
                        end
                    })

                    MENU:AddOption({
                        name = "Сон",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/actson")	
                        end
                    })

                    MENU:AddOption({
                        name = "Психоз [1]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/acttrans01")	
                        end
                    })

                    MENU:AddOption({
                        name = "Психоз [2]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/acttrans02")	
                        end
                    })

                    MENU:AddOption({
                        name = "Психоз [3]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/acttrans03")	
                        end
                    })

                    MENU:AddOption({
                        name = "Молиться [1]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/acttrans1")	
                        end
                    })

                    MENU:AddOption({
                        name = "Молиться [2]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/acttrans2")	
                        end
                    })

                    MENU:AddOption({
                        name = "Пьяный [01]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/actalkash3")	
                        end
                    })

                    MENU:AddOption({
                        name = "Пьяный [02]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/actalkash4")	
                        end
                    })

                    MENU:AddOption({
                        name = "Полу-сон",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/acttreboga")	
                        end
                    })             
                end
            })                                    
            MENU:AddOption({
                name = "Анимации [IDLE-2]",
                icon = "clock_red",
                newmenu = true,
                callback = function()
                    MENU:ClearOptions()
                    MENU:CreateRadialMenu()
            

                    MENU:AddOption({
                        name = "На стол 1",
                        icon = "emoticon_smile",
                         newmenu = false,
                        callback = function()
                             RunConsoleCommand ("say", "/Actbar1")	
                         end
                    })

                    MENU:AddOption({
                        name = "На стол 2",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actbar2")
                        end
                    })
					
                    MENU:AddOption({
                        name = "На стол 3",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actbar3")
                        end
                    })				
                    
                    MENU:AddOption({
                        name = "На стол 4",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actbar4")	
                        end
                    })

                    MENU:AddOption({
                        name = "На стол 5",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actbar5")	
                        end
                    })

                    MENU:AddOption({
                        name = "На стол 6",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actbar6")	
                        end
                    })

                    MENU:AddOption({
                        name = "К стене 1",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actstena1")	
                        end
                    })

                    MENU:AddOption({
                        name = "К стене 2",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actstena2")	
                        end
                    })

                    MENU:AddOption({
                        name = "К стене 3",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actalkash1")	
                        end
                    })

                    MENU:AddOption({
                        name = "К стене 4",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actalkash2")	
                        end
                    })

                    MENU:AddOption({
                        name = "Танцы [1]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actdancee1")	
                        end
                    }) 

                    MENU:AddOption({
                        name = "Танцы [2]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actdancee2")	
                        end
                    })

                    MENU:AddOption({
                        name = "Танцы [3]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actdancee3")	
                        end
                    })

                    MENU:AddOption({
                        name = "Танцы [4]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actdancee4")	
                        end
                    })

                    MENU:AddOption({
                        name = "Осмотр земли с оружием",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actpoisk6")	
                        end
                    })

                    MENU:AddOption({
                        name = "Приветствие",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/acthello")	
                        end
                    })

                    MENU:AddOption({
                        name = "Приветствие [2]",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/acthello2")	
                        end
                    })


                    MENU:AddOption({
                        name = "Приветствие с оружием",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/acthello3gun")	
                        end
                    })

                end
         })

            MENU:AddOption({
                name = "Анимации [Стойки]",
                icon = "clock_red",
                newmenu = true,
                callback = function()
                    MENU:ClearOptions()
                    MENU:CreateRadialMenu()
            

                    MENU:AddOption({
                        name = "«ПОСТ»",
                        icon = "emoticon_smile",
                         newmenu = false,
                        callback = function()
                             RunConsoleCommand ("say", "/Actstoikaslakreta2")	
                         end
                    })

                    MENU:AddOption({
                        name = "«ПОСТ-2»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actstoikaslakreta")
                        end
                    })
					
                    MENU:AddOption({
                        name = "«ОСМОТР-1»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actisppug3")
                        end
                    })				
                    
                    MENU:AddOption({
                        name = "«ОСМОТР-2»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/actisppug2")	
                        end
                    })

                    MENU:AddOption({
                        name = "«ОСМОТР-3»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/actisppug1")	
                        end
                    })

                    MENU:AddOption({
                        name = "«ГЕРОЙ»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actstandthoo")	
                        end
                    })

                    MENU:AddOption({
                        name = "«ОТДЫХ»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actstandthree")	
                        end
                    })

                    MENU:AddOption({
                        name = "«Крест рук»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actstandtwo")	
                        end
                    })

                    MENU:AddOption({
                        name = "Разминка",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actrazminka")	
                        end
                    })

                    MENU:AddOption({
                        name = "«Болтовня»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actboltaet")	
                        end
                    })

                    MENU:AddOption({
                        name = "Стойка часового с оружием",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actohrana4")	
                        end
                    })

                    MENU:AddOption({
                        name = "Стойка с оружием",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actohrana3")	
                        end
                    })

                    MENU:AddOption({
                        name = "Стойка скрестив руки",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actkrestruki")	
                        end
                    })

                    MENU:AddOption({
                        name = "«НАЁМНИК»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actohrana2")	
                        end
                    })

                    MENU:AddOption({
                        name = "«НАЁМНИК-2»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actohrana1")	
                        end
                    })

                    MENU:AddOption({
                        name = "«Браток»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actrukikarman")	
                        end
                    })

                    MENU:AddOption({
                        name = "«Пояс»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actpoyas")	
                        end
                    })

                    MENU:AddOption({
                        name = "«Смотр»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actsmotrim1")	
                        end
                    })

                    MENU:AddOption({
                        name = "«СМИРНО»",
                        icon = "emoticon_smile",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actchest2")	
                        end
                    })

                end
         })


            MENU:AddOption({
                name = "Анимации [Действия]",
                icon = "clock_red",
                newmenu = true,
                callback = function()
                    MENU:ClearOptions()
                    MENU:CreateRadialMenu()
            

                    MENU:AddOption({
                        name = "«ПРИСЕДАНИЯ»",
                        icon = "tag",
                         newmenu = false,
                        callback = function()
                             RunConsoleCommand ("say", "/Actprisyad")	
                         end
                    })

                    MENU:AddOption({
                        name = "Страх с пистолетом [2]",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actsmotrim2")	
                        end
                    })
                    
                    MENU:AddOption({
                        name = "Угроза [2]",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actgorloknifetw")	
                        end
                    })

                    MENU:AddOption({
                        name = "Дурак",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actvisok")	
                        end
                    })

                    MENU:AddOption({
                        name = "«ОТЖИМАНИЯ»",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actotzhim1")
                        end
                    })
					
                    MENU:AddOption({
                        name = "«ОТЖИМАНИЯ НА КУЛАКАХ»",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actotzhim2")
                        end
                    })				
                    
                    MENU:AddOption({
                        name = "Покреститься",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/actbogsnami")	
                        end
                    })

                    MENU:AddOption({
                        name = "Грабеж с пистолетом",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actgrabej1")	
                        end
                    })

                    MENU:AddOption({
                        name = "Смех",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actsmeh")	
                        end
                    })

                    MENU:AddOption({
                        name = "Грабеж с автоматом",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actgrabej2")	
                        end
                    })

                    MENU:AddOption({
                        name = "Замеры радиации",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/actdetector2")	
                        end
                    })

                end
         })



            MENU:AddOption({
                name = "Анимации [Действия 2]",
                icon = "clock_red",
                newmenu = true,
                callback = function()
                    MENU:ClearOptions()
                    MENU:CreateRadialMenu()
            

                  MENU:AddOption({
                        name = "Осмотр и приветствие",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/acthelpsidya")	
                        end
                    })

                    MENU:AddOption({
                        name = "Страх с пистолетом",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
                            RunConsoleCommand ("say", "/Actsmotrim3")	
                        end
                    })

                    MENU:AddOption({
                        name = "Сдаться [1]",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actsdatsa1")	
                        end
                    })

                    MENU:AddOption({
                        name = "Сдаться [2]",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actsdatsa2")	
                        end
                    })

                    MENU:AddOption({
                        name = "Отдать честь",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actchest1")	
                        end
                    })

                    MENU:AddOption({
                        name = "Угроза",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actgorloknife")	
                        end
                    })


                    MENU:AddOption({
                        name = "Отдать команду группе",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actalert3")	
                        end
                    })

                    MENU:AddOption({
                        name = "Страх с оружием",
                        icon = "tag",
                        newmenu = false,
                        callback = function()
						    RunConsoleCommand ("say", "/actalert2")	
                        end
                    })

                end
         })



                                end
                            })

                            MENU:AddOption({
                                name = "Походка",
                                icon = "clock_red",
                                newmenu = true,
                                callback = function()
                                    MENU:ClearOptions()
                                    MENU:CreateRadialMenu()
                            

                                    MENU:AddOption({
                                        name = "Обычная",
                                        icon = "emoticon_smile",
                                        newmenu = false,
                                        callback = function()
                                            RunConsoleCommand ("say", "/CharMovementSeq 1")	
                                        end
                                    })

                                    MENU:AddOption({
                                        name = "Бандитская",
                                        icon = "emoticon_smile",
                                        newmenu = false,
                                        callback = function()
                                            RunConsoleCommand ("say", "/CharMovementSeq 2")	
                                        end
                                    })

                                    MENU:AddOption({
                                        name = "Тактическая",
                                        icon = "emoticon_smile",
                                        newmenu = false,
                                        callback = function()
                                            RunConsoleCommand ("say", "/CharMovementSeq 3")	
                                        end
                                    })

                                    MENU:AddOption({
                                        name = "Ранен",
                                        icon = "emoticon_smile",
                                        newmenu = false,
                                        callback = function()
                                            RunConsoleCommand ("say", "/CharMovementSeq 4")	
                                        end
                                    })

                                    if client:IsAdmin() then
                                        MENU:AddOption({
                                            name = "Зомбированная",
                                            icon = "emoticon_smile",
                                            callback = function()
                                                RunConsoleCommand ("say", "/CharMovementSeq 5")	
                                            end
                                        })
                                    end

                                end
                            })
                        end
                    })




                    MENU:AddOption({
                        name = "Сменить уровень разговора",
                        icon = "user",
                        newmenu = true,
                        callback = function()
                            MENU:ClearOptions()
                            MENU:CreateRadialMenu()

                            MENU:AddOption({
                                name = "Шёпот",
                                icon = "user_orange",
                                callback = function()
                                    VoiceDistance(1)
                                end
                            })

                            MENU:AddOption({
                                name = "Разговорный",
                                icon = "user_gray",
                                callback = function()
                                    VoiceDistance(2)
                                end
                            })

                            MENU:AddOption({
                                name = "Крик",
                                icon = "user",
                                callback = function()
                                    VoiceDistance(3)
                                end
                            })
                        end
                    })
                    MENU:AddOption({
                         name = "Открыть меню представлений",
                         icon = "user",
                         callback = function()
                            vgui.Create("fkname_recognitionmenu")
                         end
                    })

                    MENU:AddOption({
                        name = "Включить третье лицо",
                        icon = "user",
                        callback = function()
                           RunConsoleCommand("ix_togglethirdperson")
                        end
                   })
                    -- MENU:AddOption({
                    --     name = "Выбросить деньги",
                    --     icon = "money_delete",
                    --     callback = function()
                    --         DrawArgsBox("Введи количество", "Выбросить", "", "", false, function(amount) ix.command.Send("DropMoney", amount) end)
                    --     end
                    -- })
                    

                    -- MENU:AddOption({
                    --     name = "Передать деньги",
                    --     icon = "money_delete",
                    --     callback = function()
                    --         DrawArgsBox("Введи количество", "Передать", "", "", false, function(amount) ix.command.Send("GiveMoney", amount) end)
                    --     end
                    -- })
                    
                    
                    if not client:IsAdmin() then
                        MENU:AddOption({
                            name = "Вызвать администратора",
                            icon = "star",
                            callback = function()
                                Derma_StringRequest("Подать жалобу", "Максимально подробно опиши свою проблему", "", function(text)
                                    RunConsoleCommand ("say", "!report" .. text)
                                end)
                            end
                        })
                    end

                    MENU:AddOption({
                        name = "Предложить обмен",
                        icon = "user_edit",
                        callback = function()
                            RunConsoleCommand ("say", "/trade")
                        end
                    })

                    MENU:AddOption({
                        name = "Сменить описание",
                        icon = "user_edit",
                        callback = function()
                            RunConsoleCommand ("say", "/CharDesc")
                        end
                    })

                    MENU:AddOption({
                        name = "Дискорд-сервер",
                        icon = "page_add",
                        callback = function()
                            gui.OpenURL("https://discord.gg/MNk7SaQc4v")
                        end
                    })

                    MENU:AddOption({
                        name = "Выбросить деньги",
                        icon = "money_delete",
                        callback = function()
                            DrawArgsBox("Введи количество", "Выбросить", "", "", false, function(amount) ix.command.Send("DropMoney", amount) end)
                        end
                    })
    

                    MENU:AddOption({
                        name = "Передать деньги",
                        icon = "money_delete",
                        callback = function()
                            DrawArgsBox("Введи количество", "Передать", "", "", false, function(amount) ix.command.Send("GiveMoney", amount) end)
                        end
                    })

                    if client:IsAdmin() then
                        MENU:AddOption({
                            name = "Админ-опции",
                            icon = "lock_open",
                            newmenu = true,
                            callback = function()
                                MENU:ClearOptions()
                                MENU:CreateRadialMenu()

                                MENU:AddOption({
                                    name = "Логи",
                                    icon = "page_key",
                                    callback = function()
                                        RunConsoleCommand("say", "!blogs")
                                    end
                                })

                                MENU:AddOption({
                                    name = "Admin-menu",
                                    icon = "cog",
                                    callback = function()
                                        RunConsoleCommand ("say", "!menu")
                                    end
                                })

                                MENU:AddOption({
                                    name = "Посмотреть Инвентарь Игрока",
                                    icon = "cog",
                                    callback = function()
                                        Derma_StringRequest("Посмотреть инвентарь", "Введи имя игрока", "", function(text)
                                            RunConsoleCommand ("say", "/checkinventory "..text)
                                        end)
                                    end
                                })

                                -- MENU:AddOption({
                                --     name = "ScreenGrab",
                                --     icon = "cog",
                                --     callback = function()
                                --         RunConsoleCommand ("screengrab")
                                --     end
                                -- })
                            end
                        })
                    end
                    Cooldown = CurTime() + 0.1
                end
            end
        end
    --end)
    end
end

if SERVER then
    ix.util.Include("sv_plugin.lua")
end