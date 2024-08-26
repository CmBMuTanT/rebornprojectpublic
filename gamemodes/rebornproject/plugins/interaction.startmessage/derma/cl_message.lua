local PLUGIN = PLUGIN

local PANEL = {}

hook.Add("PopulateHelpMenu", "ixHelpMenu", function(tabs)
    tabs["commands"] = nil
    tabs['plugins'] = nil
	tabs["flags"] = function(container)
		-- info text
		local info = container:Add("DLabel")
		info:SetFont("ixSmallFont")
		info:SetText(L("helpFlags"))
		info:SetContentAlignment(5)
		info:SetTextColor(color_white)
		info:SetExpensiveShadow(1, color_black)
		info:Dock(TOP)
		info:DockMargin(0, 0, 0, 8)
		info:SizeToContents()
		info:SetTall(info:GetTall() + 16)

		info.Paint = function(_, width, height)
			surface.SetDrawColor(ColorAlpha(derma.GetColor("Info", info), 160))
			surface.DrawRect(0, 0, width, height)
		end

		-- flags
		for k, v in SortedPairs(ix.flag.list) do
			local background = ColorAlpha(
				LocalPlayer():GetCharacter():HasFlags(k) and derma.GetColor("Success", info) or derma.GetColor("Error", info), 88
			)

			local panel = container:Add("Panel")
			panel:Dock(TOP)
			panel:DockMargin(0, 0, 0, 8)
			panel:DockPadding(4, 4, 4, 4)
			panel.Paint = function(_, width, height)
				derma.SkinFunc("DrawImportantBackground", 0, 0, width, height, background)
			end

			local flag = panel:Add("DLabel")
			flag:SetFont("ixMonoMediumFont")
			flag:SetText(string.format("[%s]", k))
			flag:Dock(LEFT)
			flag:SetTextColor(color_white)
			flag:SetExpensiveShadow(1, color_black)
			flag:SetTextInset(4, 0)
			flag:SizeToContents()
			flag:SetTall(flag:GetTall() + 8)

			local description = panel:Add("DLabel")
			description:SetFont("ixMediumLightFont")
			description:SetText(v.description)
			description:Dock(FILL)
			description:SetTextColor(color_white)
			description:SetExpensiveShadow(1, color_black)
			description:SetTextInset(8, 0)
			description:SizeToContents()
			description:SetTall(description:GetTall() + 8)

			panel:SizeToChildren(false, true)
		end
	end

	tabs["commands"] = function(container)
		-- info text
		local info = container:Add("DLabel")
		info:SetFont("ixSmallFont")
		info:SetText(L("helpCommands"))
		info:SetContentAlignment(5)
		info:SetTextColor(color_white)
		info:SetExpensiveShadow(1, color_black)
		info:Dock(TOP)
		info:DockMargin(0, 0, 0, 8)
		info:SizeToContents()
		info:SetTall(info:GetTall() + 16)

		info.Paint = function(_, width, height)
			surface.SetDrawColor(ColorAlpha(derma.GetColor("Info", info), 160))
			surface.DrawRect(0, 0, width, height)
		end

		-- commands
		for uniqueID, command in SortedPairs(ix.command.list) do
			if (command.OnCheckAccess and !command:OnCheckAccess(LocalPlayer())) then
				continue
			end

			local bIsAlias = false
			local aliasText = ""

			-- we want to show aliases in the same entry for better readability
			if (command.alias) then
				local alias = istable(command.alias) and command.alias or {command.alias}

				for _, v in ipairs(alias) do
					if (v:lower() == uniqueID) then
						bIsAlias = true
						break
					end

					aliasText = aliasText .. ", /" .. v
				end

				if (bIsAlias) then
					continue
				end
			end

			-- command name
			local title = container:Add("DLabel")
			title:SetFont("ixMediumLightFont")
			title:SetText("/" .. command.name .. aliasText)
			title:Dock(TOP)
			title:SetTextColor(ix.config.Get("color"))
			title:SetExpensiveShadow(1, color_black)
			title:SizeToContents()

			-- syntax
			local syntaxText = command.syntax
			local syntax

			if (syntaxText != "" and syntaxText != "[none]") then
				syntax = container:Add("DLabel")
				syntax:SetFont("ixMediumLightFont")
				syntax:SetText(syntaxText)
				syntax:Dock(TOP)
				syntax:SetTextColor(color_white)
				syntax:SetExpensiveShadow(1, color_black)
				syntax:SetWrap(true)
				syntax:SetAutoStretchVertical(true)
				syntax:SizeToContents()
			end

			-- description
			local descriptionText = command:GetDescription()

			if (descriptionText != "") then
				local description = container:Add("DLabel")
				description:SetFont("ixSmallFont")
				description:SetText(descriptionText)
				description:Dock(TOP)
				description:SetTextColor(color_white)
				description:SetExpensiveShadow(1, color_black)
				description:SetWrap(true)
				description:SetAutoStretchVertical(true)
				description:SizeToContents()
				description:DockMargin(0, 0, 0, 8)
			elseif (syntax) then
				syntax:DockMargin(0, 0, 0, 8)
			else
				title:DockMargin(0, 0, 0, 8)
			end
		end
	end

	tabs["FAQ"] = function(container)
        container.greyheader = container:Add("DLabel")
        container.greyheader:SetFont("ixSmallFont")
        container.greyheader:SetText("Ответы на частые вопросы!")
        container.greyheader:SetContentAlignment(5)
        container.greyheader:SetTextColor(color_white)
        container.greyheader:SetExpensiveShadow(1, color_black)
        container.greyheader:Dock(TOP)
        container.greyheader:DockMargin(0, 0, 0, 8)
        container.greyheader:SizeToContents()
        container.greyheader:SetTall(container.greyheader:GetTall() + 16)
        container.greyheader.Paint = function(_, width, height)
            surface.SetDrawColor(40, 40, 40)
            surface.DrawRect(0, 0, width, height)
        end

        container.BetaText = container:Add("DLabel")
        container.BetaText:SetFont("ixGuideSmallFont")
        container.BetaText:SetText("\n\n1. Где я появился? Вы появились на ВДНХ, ваша задача проста - выжить. \n\n2. Как заработать денег? Увы, наша экономика базируется на принципах бартерности и умений. То-есть, валюта здесь - это полезные вещи. Условим, 10 банок тушенки - на шлем, или наоборот.. Как получить первое снаряжение? Квесты, работа - или бесстрашные вылазки, с целью поискать полезных ресурсов.")
        container.BetaText:Dock(TOP)
        container.BetaText:SetTextColor(color_white)
        container.BetaText:SetExpensiveShadow(1, color_black)
        container.BetaText:SetWrap(true)
        container.BetaText:SetAutoStretchVertical(true)
        container.BetaText:SizeToContents()
        container.BetaText:DockMargin(10, 10, 0, 0)

  
	
	     container.BetaText = container:Add("DLabel")
        container.BetaText:SetFont("ixGuideSmallFont")
        container.BetaText:SetText("\n6. Разрешено-ли на сервере использование МГ-общения, и НРП в войс? - Нет, на сервере не приветствуется общение через дискорд, и другие средства связи. Так-же под запрет падает НРП-общени \n\n7. Как получить гражданство станции? Купить у лидера фракции")
        container.BetaText:Dock(TOP)
        container.BetaText:SetTextColor(color_white)
        container.BetaText:SetExpensiveShadow(1, color_black)
        container.BetaText:SetWrap(true)
        container.BetaText:SetAutoStretchVertical(true)
        container.BetaText:SizeToContents()
        container.BetaText:DockMargin(10, 10, 0, 0)

    end

	tabs["Важно"] = function(container)
        container.greyheader = container:Add("DLabel")
        container.greyheader:SetFont("ixSmallFont")
        container.greyheader:SetText("Здравствуй сталкер! Ознакомься пожалуйста в важной информацией перед началом игры!")
        container.greyheader:SetContentAlignment(5)
        container.greyheader:SetTextColor(color_white)
        container.greyheader:SetExpensiveShadow(1, color_black)
        container.greyheader:Dock(TOP)
        container.greyheader:DockMargin(0, 0, 0, 8)
        container.greyheader:SizeToContents()
        container.greyheader:SetTall(container.greyheader:GetTall() + 16)
        container.greyheader.Paint = function(_, width, height)
            surface.SetDrawColor(40, 40, 40)
            surface.DrawRect(0, 0, width, height)
        end

        container.BetaText = container:Add("DLabel")
        container.BetaText:SetFont("ixGuideSmallFont")
        container.BetaText:SetText("Добро пожаловать на проект МЕТРО 2033 | Qanon Project. Наш проект - является самым стабильным и популярным сервером в жанре Метро2033 среди стран-участниц СНГ. Более 4-х лет стабильной работы - не единственный наш плюс, которым мы можем похвастаться.")
        container.BetaText:Dock(TOP)
        container.BetaText:SetTextColor(color_white)
        container.BetaText:SetExpensiveShadow(1, color_black)
        container.BetaText:SetWrap(true)
        container.BetaText:SetAutoStretchVertical(true)
        container.BetaText:SizeToContents()
        container.BetaText:DockMargin(10, 10, 0, 0)

        container.SeriousRp = container:Add("DLabel")
        container.SeriousRp:SetFont("ixGuideSmallFont")
        container.SeriousRp:SetText("У нас MediumRP-проект с полным погружением и чтобы не получить проблем, для начала ознакомься с нашими правилами в дискорде")
        container.SeriousRp:Dock(TOP)
        container.SeriousRp:SetTextColor(Color(255, 95, 95))
        container.SeriousRp:SetExpensiveShadow(1, color_black)
        container.SeriousRp:SetWrap(true)
        container.SeriousRp:SetAutoStretchVertical(true)
        container.SeriousRp:SizeToContents()
        container.SeriousRp:DockMargin(10, 10, 0, 0)
    end

	tabs["Начало игры"] = function(container)
        container.greyheader = container:Add("DLabel")
        container.greyheader:SetFont("ixSmallFont")
        container.greyheader:SetText("Небольшая предыстория нашей вселенной!")
        container.greyheader:SetContentAlignment(5)
        container.greyheader:SetTextColor(color_white)
        container.greyheader:SetExpensiveShadow(1, color_black)
        container.greyheader:Dock(TOP)
        container.greyheader:DockMargin(0, 0, 0, 8)
        container.greyheader:SizeToContents()
        container.greyheader:SetTall(container.greyheader:GetTall() + 16)
        container.greyheader.Paint = function(_, width, height)
            surface.SetDrawColor(40, 40, 40)
            surface.DrawRect(0, 0, width, height)
        end

        container.HelloText = container:Add("DLabel")
        container.HelloText:SetFont("ixGuideSmallFont")
        container.HelloText:SetText("Наш сервер действует по-логике `Игроки сами строят свой путь`, каждый игрок и лидер - часть нашего лора. Начало игровой сессии - 2033год, когда SПАРТА находится в Д6 - а улей Чёрных все еще не разрушен. От этого - походы на поверхность, опасны. Многие фракции точат зубы на Комплекс-Д6, от этого SПАРТА каждый день готовится к обороне и наращивает военную силу.")
        container.HelloText:Dock(TOP)
        container.HelloText:SetTextColor(color_white)
        container.HelloText:SetExpensiveShadow(1, color_black)
        container.HelloText:SetWrap(true)
        container.HelloText:SetAutoStretchVertical(true)
        container.HelloText:SizeToContents()
        container.HelloText:DockMargin(10, 10, 0, 0)

        container.LoreText = container:Add("DLabel")
        container.LoreText:SetFont("ixGuideItalicFont")
        container.LoreText:SetText(" После ядерной войны 2012 года, Москва погрузилась во мрак и вся жизнь спустилась под землю. Население Москвы на грани вымирания, каждая станция желает выжить. Станции в результате междоусобных войн превратились в города-государства. Туннели между ними населяют страшные чудовища. И только сплатившись можно победить эту нечисть. .")
        container.LoreText:Dock(TOP)
        container.LoreText:SetTextColor(color_white)
        container.LoreText:SetExpensiveShadow(1, color_black)
        container.LoreText:SetWrap(true)
        container.LoreText:SetAutoStretchVertical(true)
        container.LoreText:SizeToContents()
        container.LoreText:DockMargin(10, 5, 0, 8)

        container.GuideText = container:Add("DLabel")
        container.GuideText:SetFont("ixGuideSmallFont")
        container.GuideText:SetText("Пожалуйста, старайтесь соблюдать РП-Обстановку на сервере. Желаем приятной и удачной игры!")
        container.GuideText:Dock(TOP)
        container.GuideText:SetTextColor(color_white)
        container.GuideText:SetExpensiveShadow(1, color_black)
        container.GuideText:SetWrap(true)
        container.GuideText:SetAutoStretchVertical(true)
        container.GuideText:SizeToContents()
        container.GuideText:DockMargin(10, 5, 0, 8)
    end
    
	tabs["Правила"] = function(container)
        container.greyheader = container:Add("DLabel")
        container.greyheader:SetFont("ixSmallFont")
        container.greyheader:SetText("Ты выходец со станции, ты появишься на безопасной станции, где ты сможешь начать свой собственный путь.")
        container.greyheader:SetContentAlignment(5)
        container.greyheader:SetTextColor(color_white)
        container.greyheader:SetExpensiveShadow(1, color_black)
        container.greyheader:Dock(TOP)
        container.greyheader:DockMargin(0, 0, 0, 8)
        container.greyheader:SizeToContents()
        container.greyheader:SetTall(container.greyheader:GetTall() + 16)
        container.greyheader.Paint = function(_, width, height)
            surface.SetDrawColor(40, 40, 40)
            surface.DrawRect(0, 0, width, height)
        end

        container.MainTitle = container:Add("DLabel")
        container.MainTitle:SetFont("ixGuideSmallFont")
        container.MainTitle:SetText("В свою очередь администрация проекта желает тебе удачи в твоих начинаниях, но обязательно ознакомься с правилами, так как не знание правил не освобождает тебя от ответственности.")
        container.MainTitle:Dock(TOP)
        container.MainTitle:SetTextColor(Color(255, 100, 100))
        container.MainTitle:SetExpensiveShadow(1, color_black)
        container.MainTitle:SetWrap(true)
        container.MainTitle:SetAutoStretchVertical(true)
        container.MainTitle:SizeToContents()
        container.MainTitle:DockMargin(10, 10, 0, 0)

        container.MainText = container:Add("DLabel")
        container.MainText:SetFont("ixGuideTinyFont")
        container.MainText:SetText("Еще раз желаем тебе удачной и продуктивной игры, с уважением - технический разработчик проекта, Null.")
        container.MainText:Dock(TOP)
        container.MainText:SetTextColor(color_black)
        container.MainText:SetExpensiveShadow(1, color_black)
        container.MainText:SetWrap(true)
        container.MainText:SetAutoStretchVertical(true)
        container.MainText:SizeToContents()
        container.MainText:DockMargin(10, 5, 0, 10)

        container.VoiceTitle = container:Add("DLabel")
        container.VoiceTitle:SetFont("ixGuideSmallFont")
        container.VoiceTitle:SetText("Правила проекта вы можете прочитать на нашем форуме/дискорде.")
        container.VoiceTitle:Dock(TOP)
        container.VoiceTitle:SetTextColor(Color(255, 100, 100))
        container.VoiceTitle:SetExpensiveShadow(1, color_black)
        container.VoiceTitle:SetWrap(true)
        container.VoiceTitle:SetAutoStretchVertical(true)
        container.VoiceTitle:SizeToContents()
        container.VoiceTitle:DockMargin(10, 25, 0, 10)

    end

	tabs["Сообщество"] = function(container)
        container.greyheader = container:Add("DLabel")
        container.greyheader:SetFont("ixSmallFont")
        container.greyheader:SetText("Наша медийная часть")
        container.greyheader:SetContentAlignment(5)
        container.greyheader:SetTextColor(color_white)
        container.greyheader:SetExpensiveShadow(1, color_black)
        container.greyheader:Dock(TOP)
        container.greyheader:DockMargin(0, 0, 0, 8)
        container.greyheader:SizeToContents()
        container.greyheader:SetTall(container.greyheader:GetTall() + 16)
        container.greyheader.Paint = function(_, width, height)
            surface.SetDrawColor(40, 40, 40)
            surface.DrawRect(0, 0, width, height)
        end

        container.discord = container:Add("DButton")
        container.discord:SetFont("ixMenuButtonFontSmall")
        container.discord:SetText("Discord")
        container.discord:SetContentAlignment(5)
        container.discord:SetTextColor(color_white)
        container.discord:SetExpensiveShadow(1, color_black)
        container.discord:Dock(TOP)
        container.discord:DockMargin(0, 0, 0, 8)
        container.discord:SizeToContents()
        container.discord:SetTall(container.discord:GetTall() + 24)
        container.discord.Paint = function(this, width, height)
            surface.SetDrawColor(Color(114, 137, 218))
            surface.DrawRect(0, 0, width, height)
        end
        container.discord.DoClick = function(this)
            gui.OpenURL('https://discord.gg/dtnVsYUpc5')
        end

        container.website = container:Add("DButton")
        container.website:SetFont("ixMenuButtonFontSmall")
        container.website:SetText("Правила")
        container.website:SetContentAlignment(5)
        container.website:SetTextColor(color_white)
        container.website:SetExpensiveShadow(1, color_black)
        container.website:Dock(TOP)
        container.website:DockMargin(0, 0, 0, 8)
        container.website:SizeToContents()
        container.website:SetTall(container.website:GetTall() + 24)
        container.website.Paint = function(this, width, height)
            surface.SetDrawColor(Color(44, 44, 44))
            surface.DrawRect(0, 0, width, height)
        end
        container.website.DoClick = function(this) 
            gui.OpenURL('https://qanonproject-forum.site/index.php?threads/%D0%9F%D1%80%D0%B0%D0%B2%D0%B8%D0%BB%D0%B0-%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B0.51/')
        end

        container.website = container:Add("DButton")
        container.website:SetFont("ixMenuButtonFontSmall")
        container.website:SetText("Сайт проекта")
        container.website:SetContentAlignment(5)
        container.website:SetTextColor(color_white)
        container.website:SetExpensiveShadow(1, color_black)
        container.website:Dock(TOP)
        container.website:DockMargin(0, 0, 0, 8)
        container.website:SizeToContents()
        container.website:SetTall(container.website:GetTall() + 24)
        container.website.Paint = function(this, width, height)
            surface.SetDrawColor(Color(44, 44, 44))
            surface.DrawRect(0, 0, width, height)
        end
        container.website.DoClick = function(this) 
            gui.OpenURL("https://metro-2033-qanon.ru")
        end


        container.steam = container:Add("DButton")
        container.steam:SetFont("ixMenuButtonFontSmall")
        container.steam:SetText("Steam")
        container.steam:SetContentAlignment(5)
        container.steam:SetTextColor(color_white)
        container.steam:SetExpensiveShadow(1, color_black)
        container.steam:Dock(TOP)
        container.steam:DockMargin(0, 0, 0, 8)
        container.steam:SizeToContents()
        container.steam:SetTall(container.steam:GetTall() + 24)
        container.steam.Paint = function(this, width, height)
            surface.SetDrawColor(Color(44, 44, 44))
            surface.DrawRect(0, 0, width, height)
        end
        container.steam.DoClick = function(this)
            gui.OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=2806336448')
        end

        container.vk = container:Add("DButton")
        container.vk:SetFont("ixMenuButtonFontSmall")
        container.vk:SetText("ВКонтакте")
        container.vk:SetContentAlignment(5)
        container.vk:SetTextColor(color_white)
        container.vk:SetExpensiveShadow(1, color_black)
        container.vk:Dock(TOP)
        container.vk:DockMargin(0, 0, 0, 8)
        container.vk:SizeToContents()
        container.vk:SetTall(container.vk:GetTall() + 24)
        container.vk.Paint = function(this, width, height)
            surface.SetDrawColor(Color(44, 44, 44))
            surface.DrawRect(0, 0, width, height)
        end
        container.vk.DoClick = function(this)
            gui.OpenURL('https://vk.com/gmodqanonproject')
        end
    end
end)

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(850, 700)
	self:Center()
    self:SetTitle("Помощь")
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)
    self:SetDraggable(false)
    self:ShowCloseButton(false)

    self:Add('ixHelpMenu')

	self:MakePopup()

    self.close = self:Add("ixMenuButton")
    self.close:Dock(BOTTOM)
    self.close:SetSize(100, 50)
    self.close:SetText("Закрыть")
    self.close.DoClick = function()
        self:Remove()
    end

	PLUGIN.panel = self
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
    ix.option.Set("showStartMessage", false)
end

vgui.Register("ixStartMessage", PANEL, "DFrame")