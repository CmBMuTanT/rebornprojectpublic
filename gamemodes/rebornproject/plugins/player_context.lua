local PLUGIN = PLUGIN

PLUGIN.name = "Player context menu"
PLUGIN.author = "chelog"
PLUGIN.description = "Opens context menu when aiming on player"

-- if (CLIENT) then

-- 	function PLUGIN:CreateMove(cmd)
-- 		if cmd:KeyDown(IN_USE) then
-- 			if lastPressed ~= true then
-- 				local ply = LocalPlayer()
-- 			--	if ply:IsFallover() then return end

-- 				local tr = {}
-- 				tr.start = ply:GetShootPos()
-- 				tr.endpos = tr.start + ply:GetAimVector() * 84
-- 				tr.filter = ply
-- 				tr = util.TraceLine(tr)

-- 				local ent = tr.Entity
-- 				if IsValid(ent) and ent:IsPlayer() then
-- 					self:OpenMenu(ent)
-- 					onPlayer = true
-- 				end
-- 			end

-- 			lastPressed = true
-- 		elseif lastPressed == true then
-- 			lastPressed = false
-- 			onPlayer = false
-- 		end

-- 		if onPlayer then
-- 			cmd:RemoveKey(IN_USE)
-- 		end
-- 	end

-- 	function DrawArgsBox(strTitle, strBtn, strDefaultText, strSecondDefaultText, secondText, fnEnter)
-- 		secondText = secondText or false

-- 		local w, h
-- 		local number

-- 		if secondText then
-- 			w, h = 250, 200
-- 			number = 3
-- 		else
-- 			w, h = 250, 100
-- 			number = 2.35
-- 		end

-- 		local Window = vgui.Create ("DFrame")
-- 		Window:SetTitle (strTitle)
-- 		Window:ShowCloseButton(true)
-- 		Window:MakePopup()
-- 		Window:SetSize (w, h)
-- 		Window:Center()
-- 		Window:SetKeyboardInputEnabled(true)
-- 		Window:SetMouseInputEnabled(true)
		
-- 		local width, height = Window:GetSize()

-- 		local TextEntr = vgui.Create("ixTextEntry", Window)
-- 		TextEntr:SetFont("ixMenuButtonFont")
-- 		TextEntr:Dock(TOP)
-- 		TextEntr:SetSize(width, height / number)
-- 		TextEntr:SetText(strDefaultText || "")

-- 		local TextEntr2 = vgui.Create("ixTextEntry", Window)
-- 		TextEntr2:SetFont("ixMenuButtonFont")
-- 		TextEntr2:Dock(TOP)
-- 		TextEntr2:SetSize(width, height / number)
-- 		TextEntr2:SetText(strSecondDefaultText || "")
-- 		TextEntr2:DockMargin(0, 5, 0, 0)
-- 		if !secondText then
-- 			TextEntr2:Hide()
-- 		end

-- 		local Btn = vgui.Create ("DButton", Window)
-- 		Btn:SetText(strBtn)
-- 		Btn:Dock(BOTTOM)
-- 		Btn.DoClick = function ()
-- 				if secondText then
-- 					fnEnter( TextEntr:GetValue(), TextEntr2:GetValue() )
-- 				else
-- 					fnEnter( TextEntr:GetValue() )
-- 				end
-- 				Window:Remove()
-- 		end
-- 	end
-- 	function PLUGIN:OpenMenu(ply)

-- 		if not ply:GetCharacter() then return end
-- 		if not ply:Alive() then return end

-- 		local client = LocalPlayer()
-- 		if client:GetPos():DistToSqr(ply:GetPos()) > (200 * 200) then return end

-- 		local Menu = DermaMenu()

-- 		local character = client:GetCharacter()
-- 		local clientFactionTable = ix.faction.Get(client:Team())

-- 		local subMoney, moneyOpt = Menu:AddSubMenu( "Деньги" )
-- 		moneyOpt:SetIcon( "icon16/money.png" )
-- 		local moneyGive = subMoney:AddOption( "Передать", function() DrawArgsBox("Введи количество", "Передать", "", "", false, function(a) RunConsoleCommand ("say", "/GiveMoney "..tostring(a)) end) end):SetIcon( "icon16/money_add.png" )
-- 		local moneyDrop = subMoney:AddOption( "Выбросить", function() DrawArgsBox("Введи количество", "Выбросить", "", "", false, function(a) RunConsoleCommand ("say", "/DropMoney "..tostring(a)) end) end):SetIcon( "icon16/money_delete.png" )

-- 		if not client:IsAdmin() then
-- 			local PlayerTicketOpt = Menu:AddOption( "Подать жалобу", function()
-- 				Derma_StringRequest("Жалоба на игрока " .. ply:SteamName() .. " " .. ply:SteamID(), "Опиши проблему, которая возникла с этим игроком", "", function(text)
-- 					RunConsoleCommand ("say", "!report " .. "Жалоба на " .. ply:SteamName() .. " (" .. ply:SteamID() .. ")" .. ": " .. text)
-- 				end)
-- 			end):SetIcon( "icon16/star.png" )
-- 		end





-- 		Menu:AddSpacer()

-- 		--==========================================================
-- 		Menu:AddOption( "Обыскать игрока", function()
-- 			RunConsoleCommand("say", "/search")
-- 		end):SetIcon("icon16/paste_plain.png")
-- 		Menu:AddSpacer()
-- 		--==========================================================

--[[
https://youtu.be/YXjx-Kaj5RM?t=861
Владик
а?
Надо код просмотреть, Влад, возьми кодеров 
а?
Код надо просмотреть, в сборке, просмотри
Чего надо?
ТЫ МЕНЯ СЛЫШИШЬ НЕТ?
я не слышу я дебил
ВЫЙДИ ИЗ ПЕРЕГОВОРОВ ЕБАННЫЙ В РОТ БЛЯТЬ
Ярик...
Да?
Че там?
Код пожалуйста просмотри, проверить на бэкдоры и эксплойты от твоих дебилов срочно блять, как всегда блять
В сборке все нормально...
ТЫ МЕНЯ СЛЫШИШЬ ЧТО Я ГОВОРЮ? ЕБАННЫЙ В РОТ ВЫЙДИ ИЗ ПЕРЕГОВОРОВ БЛЯТЬ
ну дальше?
Код посмотри с кодерами там, бэкдоры, эксплойты
Чего надо Ярик?
ТЫ ПИЗДЕЦ ТЫ ЧЕ СУКА ИЗДЕВАЕШЬСЯ
]]
		--==========================================================
		-- local requester = client:GetNetVar('passportRequester')
		-- local count = 0
		-- if requester then
		-- 	if not requester:IsPlayer() or requester ~= ply then return end
		-- 	local PlayerShowPassport, PlayerShowPassportOpt = Menu:AddSubMenu( "Показать паспорт" )
		-- 	local clientFaction = ix.faction.Get(client:Team()).index

		-- 	PlayerShowPassportOpt:SetIcon("icon16/page_white_paste.png")
			
		-- 	for k, v in pairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
		-- 		if v.isPassport then
		-- 			count = count + 1
		-- 			PlayerShowPassport:AddOption(v.name .. ' (' .. v:GetData('name', "Неизвестный") .. ')',  function()
		-- 				netstream.Start('ixValidateOpenPassport', ply, v:GetID())
		-- 			end)
		-- 		end
		-- 	end

		-- 	if count <= 0 then
		-- 		PlayerShowPassport:AddOption('У тебя нет паспорта',  function() end)
		-- 	end
		-- end

-- 		Menu:Open()
-- 		Menu:MakePopup()
-- 		Menu:Center()
-- 	end
     
-- end
