
if SERVER then
	util.AddNetworkString("ixDialogueEditor")
end

if CLIENT then
	
local function CommandServer(cmd, ent, args)
	if args == nil then args = {} end
	net.Start( "ixDialogueCommand" )
		net.WriteEntity(ent)
		net.WriteString(cmd)
		net.WriteTable(args)
	net.SendToServer()
end

question_commands = {
		["default"] = {
			exec = function(panel, ent, atbl)
				if panel.first_time then
					panel:AddDialogueLine(false, atbl.answer)
					surface.PlaySound(atbl.soundnpc)
					panel.first_time = false
				end
			end,
			desc = "срабатывает всего один раз, пропускает вопрос и пишет ответ нпс"
		},
		["skip"] = {
			exec = function(panel, ent, atbl)
				panel:AddDialogueLine(false, atbl.answer)
				surface.PlaySound(atbl.soundnpc)
				local b = atbl.branch or {}
				panel:MakeButtons(b, true)
			end,
			desc = "пропускает вопрос и пишет ответ"
		}
}

answer_commands = {
		["quit"] = {
			exec = function(panel, ent, atbl)
				panel:Close()
			end,
			icon = "icon16/comment_delete.png",
			desc = "закрыть меню"
		},
		["reset_buttons"] = {
			exec = function(panel, ent, atbl)
				panel:MakeButtons(panel.tbl, false)
			end,
			icon = "icon16/arrow_left.png",
			desc = "сбросить до начального диалога"
		},
		["reset_print"] = {
			exec = function(panel, ent, atbl)
				panel:AddDialogueLine(true, atbl.question)
				surface.PlaySound(atbl.soundnpc)
				panel:MakeButtons(panel.tbl, false)
			end,
			icon = "icon16/arrow_left.png",
			desc = "сбросить до начального диалога и выдать реплику игрока"
		},
		["trade"] = {
			exec = function(panel, ent, atbl)
				panel:Close()
				CommandServer("trade", ent)
				surface.PlaySound(atbl.soundnpc)
			end,
			icon = "icon16/cart.png",
			desc = "открыть меню вендора"
		},
		["quest_request"] = {
			make = function(panel, ent, atbl)
				local ply = LocalPlayer()
				
				if ply.quests then
					local quest = ply.quests[ent:GetVendorID()]
					if quest then
						atbl.last_question = atbl.question
						if quest.complete then
							atbl.question = "Сдать задание"
							atbl.answer = "quest_complete"
						else
							atbl.question = "Отменить задание"
							atbl.answer = "quest_cancel_ask"
						end
					elseif atbl.last_question then
						atbl.question = atbl.last_question
						atbl.answer = "quest_request"
					end
				end
				
			end,
			exec = function(panel, ent, atbl)
				CommandServer("quest_request", ent)
				surface.PlaySound(atbl.soundnpc)
			end,
			icon = "icon16/find.png",
			desc = "запросить квест"
		},
		["quest_accept"] = {
			exec = function(panel, ent, atbl)
				CommandServer("quest_accept", ent, {id = panel.quest_id})
				panel.quest_id = nil
				panel:Close()
			end,
			desc = "принять квест"
		},
		["quest_complete"] = {
			exec = function(panel, ent, atbl)
				panel:MakeButtons({}, false)
				CommandServer("quest_complete", ent)
			end,
			icon = "icon16/arrow_left.png",
			desc = "завершает квест и выдает награду"
		},
		["quest_cancel"] = {
			exec = function(panel, ent, atbl)
				panel:Close()
				CommandServer("quest_cancel", ent)
			end,
			desc = "отменяет квест этого вендора"
		},
		["quest_cancel_ask"] = {
			exec = function(panel, ent, atbl)
				local tbl = {
					[1] = {
						question = "Отменить задание",
						answer = "quest_cancel"
					},
					[2] = {
						question = "Назад",
						answer = "reset_buttons"
					}
				}
				panel:MakeButtons(tbl, false)
			end,
			desc = "запросить подтверждение отмены квеста"
		},
		["quest_dialogue_complete"] = {
			exec = function(panel, ent, atbl)
				CommandServer("quest_dialogue_complete", ent, {quest_id = panel.quest_id, vendor_id = panel.vendor_id})
				panel:Close()
			end,
			desc = "завершение диалога для квеста"
		},
		["quest_dialogue_quit"] = {
			exec = function(panel, ent, atbl)
				CommandServer("quest_dialogue_quit", ent, {quest_id = panel.quest_id, vendor_id = panel.vendor_id})
				panel:MakeButtons({}, false)
			end,
			desc = "выполняет квест который открыл этот диалог и выдает награду"
		}
	}

	local function PickItem(parent, tbl)
		local panel = vgui.Create( "DFrame", parent )
		panel:SetTitle( "выбор предмета" )
		panel:SetSize( 512, 512 )
		panel:ShowCloseButton( true )
		panel:SetDraggable( true )
		panel:SetDeleteOnClose( true )
		
		panel:SetPos(ScrW()/2-100, ScrH()/2-100)
		panel:MakePopup()
		
		local list = vgui.Create( "DScrollPanel", panel )
		list:Dock( FILL )
		list:DockMargin( 0, 0, 0, 64 )
		
		for k, v in pairs(ix.item.list) do
			local item = list:Add("DButton")
			PrintTable(v)
			item:SetText( v.name.." ["..v.uniqueID.."]" )
			item:Dock(TOP)
			function item:DoClick()
				surface.PlaySound("ui/buttonclick.wav")
				tbl[#tbl+1] = v.uniqueID
				panel:Close()
				parent:RefreshList()
			end
		end
		
	end

	local function PickTrader(parent, k, tbl)
		local panel = vgui.Create( "DFrame", parent )
		panel:SetTitle( "выбор торговца" )
		panel:SetSize( 512, 512 )
		panel:ShowCloseButton( true )
		panel:SetDraggable( true )
		panel:SetDeleteOnClose( true )
		
		panel:SetPos(ScrW()/2-100, ScrH()/2-100)
		panel:MakePopup()
		
		local list = vgui.Create( "DScrollPanel", panel )
		list:Dock( FILL )
		list:DockMargin( 0, 0, 0, 64 )
		
		for k, v in pairs(ents.FindByClass("ix_vendor")) do
			local item = list:Add("DButton")
			item:SetText( v:GetDisplayName().." ["..v:GetVendorID().."]"  )
			item:Dock(TOP)
			function item:DoClick()
				surface.PlaySound("ui/buttonclick.wav")
				tbl.vendor_id = v:GetVendorID()
				panel:Close()
				--parent:RefreshList()
			end
		end
		
	end

	local function TableEditor(parent, tbl, ttype)
		local panel = vgui.Create( "DFrame", parent )
		panel:SetTitle( "редактор таблиц" )
		panel:SetSize( 512, 512 )
		panel:ShowCloseButton( true )
		panel:SetDraggable( true )
		panel:SetDeleteOnClose( true )
		
		panel:SetPos(ScrW()/2-200, ScrH()/2-200)
		panel:MakePopup()
	
		if ttype == "items" then
			local add = vgui.Create( "DButton", panel )
			add:SetText( "Добавить предмет" )
			add:SetSize( 128, 32 )
			add:SetPos(16, panel:GetTall() - (48))
			function add:DoClick()
				PickItem(panel, tbl)
			end
		end
		
		function panel:RefreshList()
			if IsValid(panel.list) then panel.list:Remove() end
			panel.list = vgui.Create( "DScrollPanel", panel )
			local list = panel.list
			list:Dock( FILL )
			list:DockMargin( 0, 0, 0, 64 )
			for k, v in pairs(tbl) do
				local var = list:Add( "DPanel" )
				var:SetText("")
				var:Dock(TOP)
				
				local name = k
				
				if ttype == "chars" then
					if ix.char.loaded[k] then
						name = ix.char.loaded[k]:GetName()
					end
				elseif ttype == "items" then
					if ix.item.list[v] then
						name = ix.item.list[v].name
					else
						name = "Нет такого предмета!"
					end
				end
				
				local lbl = vgui.Create( "DLabel", var )
				lbl:SetText( name )
				lbl:SizeToContents()
				lbl:SetPos(16, 0)
				
				local delete = vgui.Create( "DImageButton", var )
				delete:Dock(RIGHT)
				delete:DockMargin( 0, 0, 8, 8 )
				delete:SetImage( "icon16/application_delete.png" )
				delete:SetSize( 16, 16 )
				function delete:DoClick()
					v = nil
					tbl[k] = nil
					parent:Save()
					panel:RefreshList()
				end
			end
		end
		
		panel:RefreshList()
		
	end

	data_editors = {
		["items"] = {
			name = "Предметы",
			func = function(panel, data)
				TableEditor(panel, data, "items")
			end
		},
		["vendor_id"] = {
			name = "ID торговца",
			func = function(panel, data, k, d)
				PickTrader(panel, k, d)
			end
		},
		["killcount"] = {
			name = "Количество убийств"
		},
		["class"] = {
			name = "Класс НПС"
		},
		["finished"] = {
			name = "Завершен ли диалог"
		}
	}

	local function DialogueEditor(trader, tbl, qtbl)
	
		local ply = LocalPlayer()
		
		local panel = nil
		local epanel = nil
		local dtree = nil
		local root = nil
		local dialogue_mode = true
		
		local max_quest_id = 0
		
		local function RefreshList(save)
			if dtree != nil then
				dtree:Remove()
				dtree = nil
			end
			dtree = vgui.Create( "DTree", panel )
			dtree:Dock( FILL )
			dtree:DockMargin( 0, 0, 0, 64 )
			MakeNodes(tbl)
			root:ExpandRecurse(true)

			if save then
				panel:Save()
			end
		end
		
		local function EditQuestion(tbl, parent, k, branch)
			if IsValid(epanel) then epanel:Remove() end
			epanel = vgui.Create( "DFrame", panel )
			epanel:SetTitle( "neurastenia7" )
			epanel:SetSize( 512, 650 )
			epanel:ShowCloseButton( true )
			epanel:SetDraggable( true )
			epanel:SetDeleteOnClose( true )
			
			--panel:Center()
			epanel:SetPos(ScrW()- 512, ScrH()/2-325)
			epanel:MakePopup()
			
			local question = nil
			local answer = nil
			local soundnpc = nil
			
			local richtext = vgui.Create( "RichText", epanel )
			richtext:SetPos( 16, epanel:GetTall() - 350 )
			richtext:SetSize( epanel:GetWide()-32, 300 )
			richtext:InsertColorChange( 255, 255, 255, 255 )
			function richtext:PerformLayout()
				richtext:SetFontInternal( "ixSmallBoldFont" ) 													
			end
			
			richtext:AppendText("ID этого торговца - ")
			richtext:InsertColorChange( 51, 255, 51, 255 )
			richtext:AppendText(trader:GetVendorID())
			richtext:InsertColorChange( 255, 255, 255, 255 )
			richtext:AppendText(" \n")
			
			if k != 0 then
				if !branch then
					richtext:AppendText("Если ветка под ответом уже есть, добавление новой её сбросит \n")
										
					local posy = 96
				
					if parent.tbl and parent.tbl.question then
						richtext:AppendText("\nВверху показаны реплики ведущие к этой ветке \n")
						local lbl = vgui.Create( "DLabel", epanel )
						lbl:SetColor(Color(100, 100, 100, 255))
						lbl:SetText( "Игрок: "..parent.tbl.question )
						lbl:SizeToContents()
						lbl:SetPos(16, 40)
						
						local lbl = vgui.Create( "DLabel", epanel )
						--lbl:SetFont( "ixSmallBoldFont" )
						lbl:SetColor(Color(100, 100, 100, 255))
						lbl:SetText( "NPC: "..parent.tbl.answer )
						lbl:SizeToContents()
						lbl:SetPos(16, 80)
					end

					richtext:AppendText("\nКоманды вместо вопроса: \n")
					
						richtext:InsertColorChange( 51, 255, 51, 255 )
						richtext:AppendText("quest1")
						richtext:InsertColorChange( 255, 255, 255, 255 )
						richtext:AppendText(" - ветка квестового диалога \n")
					for k, v in pairs(question_commands) do
						richtext:InsertColorChange( 51, 255, 51, 255 )
						richtext:AppendText(k)
						richtext:InsertColorChange( 255, 255, 255, 255 )
						richtext:AppendText(" - "..v.desc.."\n")
					end
				
					richtext:AppendText("\nКоманды вместо ответа: \n")
					for k, v in pairs(answer_commands) do
						richtext:InsertColorChange( 51, 255, 51, 255 )
						richtext:AppendText(k)
						richtext:InsertColorChange( 255, 255, 255, 255 )
						richtext:AppendText(" - "..v.desc.."\n")
					end
					
					local lbl = vgui.Create( "DLabel", epanel )
					lbl:SetFont( "ixSmallBoldFont" )
					lbl:SetText( "Реплика игрока" )
					lbl:SizeToContents()
					lbl:SetPos(8, posy+32)
					
					question = vgui.Create( "DTextEntry", epanel)
					question:SetPos(16, posy+64)
					question:SetSize(epanel:GetWide()-32, 32)
					question:SetText(tbl.question)
					question:SetPlaceholderText("Вопрос")
					question:SetFont( "ixSmallBoldFont" )
					question:SetPaintBackground(false)

					local lbl = vgui.Create( "DLabel", epanel )
					lbl:SetFont( "ixSmallBoldFont" )
					lbl:SetText( "Ответ нпс" )
					lbl:SizeToContents()
					lbl:SetPos(8, posy+96)

					answer = vgui.Create( "DTextEntry", epanel)
					answer:SetPos(16, posy+128)
					answer:SetSize(epanel:GetWide()-32, 32)
					answer:SetText(tbl.answer)
					answer:SetPlaceholderText("Ответ")
					answer:SetFont( "ixSmallBoldFont" )
					answer:SetPaintBackground(false)

					soundnpc = vgui.Create( "DTextEntry", epanel)
					soundnpc:SetPos(16, posy+156)
					soundnpc:SetSize(epanel:GetWide()-32, 32)
					soundnpc:SetText(tbl.soundnpc)
					soundnpc:SetPlaceholderText("Саунд")
					soundnpc:SetFont( "ixSmallBoldFont" )
					soundnpc:SetPaintBackground(false)
				else
					richtext:AppendText("Добавить ответы в ветку диалога / удалить ветку \n\nПри добавлении или удалении ответа происходит автоматическое сохранение. \n")
				end
			else
				richtext:AppendText("Добавить реплики в основную ветку диалога \n")
				richtext:InsertColorChange( 51, 255, 51, 255 )
				richtext:AppendText("\nКвестовые диалоги ")
				richtext:InsertColorChange( 255, 255, 255, 255 )
				richtext:AppendText("проверяются по команде вопроса ")
				richtext:InsertColorChange( 51, 255, 51, 255 )
				richtext:AppendText("questN")
				richtext:InsertColorChange( 255, 255, 255, 255 )
				richtext:AppendText(", где N это ID торговца давшего задание (пример: quest1). \nПосмотреть ID каждого торговца можно в редакторе диалогов. \nОтвет будет использован для текста кнопки")
			end

			local add = vgui.Create( "DButton", epanel )
			if branch or k == 0 then
				add:SetText( "Добавить ответ" )
			else
				add:SetText( "Добавить ветку" )
			end
			add:SetSize( 128, 32 )
			add:SetPos(16, epanel:GetTall() - (48))
			function add:DoClick()
				surface.PlaySound("ui/buttonclick.wav")
				if branch then
					tbl.branch[#tbl.branch+1] = {
						question = "Вопрос",
						answer = "Ответ",
						soundnpc = ""
					}
				else
					if k == 0 then
						tbl[#tbl+1] = {
							question = "Вопрос",
							answer = "Ответ",
							soundnpc = ""
						}
					else
						tbl.branch = {
							[1] = {
								question = "Вопрос",
								answer = "Ответ",
								soundnpc = ""
							}
						}
					end
				end
				
				RefreshList(true)
			end
			
			if k != 0 then
				local save = vgui.Create( "DButton", epanel )
				save:SetText( "Сохранить" )
				save:SetSize( 128, 32 )
				save:SetPos(150, epanel:GetTall() - (48))
				function save:DoClick()
					surface.PlaySound("ui/buttonclick.wav")
					if k != 0 then
						tbl.question = question:GetValue()
						tbl.answer = answer:GetValue()
						tbl.soundnpc = soundnpc:GetValue()
					end
					epanel:Close()
					RefreshList(true)
				end
			
				local del = vgui.Create( "DButton", epanel )
				del:SetText( "Удалить" )
				del:SetSize( 128, 32 )
				del:SetPos(284, epanel:GetTall() - (48))
				function del:DoClick()
					surface.PlaySound("ui/buttonclick.wav")
					if k != 0 then
						if branch then
							if tbl.branch then
								tbl.branch = nil
							end
						else

							local tbl = {}
							
							if parent.tbl.branch then
								tbl = parent.tbl.branch
							else
								tbl = parent.tbl
							end
							
							tbl[k] = nil
							
							local i = 1
							
							local new_tbl = {}
							
							for q, v in pairs(tbl) do
								if k != i then
									new_tbl[i] = v
									i = i + 1
								end
							end
							
							parent.tbl = new_tbl
							
						end
					else
						tbl = {}
					end
					
					epanel:Close()
				
					RefreshList(true)
					
				end
			end
		end
			
		function MakeNodes(tbl, last_node, branch)
		
			local ply = LocalPlayer()
			
			local parent = nil
			
			if last_node != nil then
				if branch then
					parent = last_node:AddNode( "Ветка", "icon16/arrow_branch.png" )
					parent.tbl = last_node.tbl
					parent.DoClick = function()
						EditQuestion(last_node.tbl, last_node, 1, true)
					end
				else
					parent = last_node
				end
			else
				parent = dtree:AddNode( "Диалоги" )
				parent.tbl = tbl
				
				parent.DoClick = function()
					EditQuestion(tbl, parent, 0, false)
				end
			
				root = parent
			end
			
			local node = nil
			
			for k, v in pairs(tbl) do
			
					local icon = "icon16/comments.png"
					
					if answer_commands[v.answer] and answer_commands[v.answer].icon then
						icon = answer_commands[v.answer].icon
					end
			
					node = parent:AddNode( v.question, icon )
					node.tbl = v
					node.DoClick = function()
						EditQuestion(v, parent, k, false)
					end
				if v.branch != nil then
					MakeNodes(v.branch, node, true)
				end
			end
			
		end
		
		local function RefreshQuestList(save)
			if dtree != nil then
				dtree:Remove()
				dtree = nil
			end
		
			dtree = vgui.Create( "DScrollPanel", panel )
			local list = dtree
			list:Dock( FILL )
			list:DockMargin( 0, 0, 0, 64 )
			
			for k, v in pairs(qtbl) do
			
				if v.quest_id == nil then
					v.quest_id = k
				end
				
				if v.quest_id > max_quest_id then max_quest_id = v.quest_id end
				
				local quest = list:Add( "DPanel" )
				quest:SetText("")
				quest:SetPos(0, -164 + (170*k))
				quest:SetSize( panel:GetWide(), 164 )
				quest:SetBackgroundColor(Color(150, 150, 150, 255))
				
				local lbl = vgui.Create( "DLabel", quest )
				--lbl:SetColor(Color(100, 100, 100, 255))
				lbl:SetText( v.name.." [Задач: "..#v.tasks.."] ID: "..v.quest_id )
				lbl:SizeToContents()
				lbl:SetPos(16, 8)
				
				local desc = vgui.Create( "RichText", quest )
				desc:SetSize( quest:GetWide()-16, 90 )
				desc:SetPos( 0, 30 )
				--function desc:PerformLayout()
				--	desc:SetFontInternal( "ixSmallBoldFont" ) 
				--end		
				
				desc:AppendText(v.desc)
				
				local del = vgui.Create( "DButton", quest )
				del:SetText( "Удалить" )
				del:SetSize( 128, 32 )
				del:SetPos(quest:GetWide() - 144, quest:GetTall() - (48))
				function del:DoClick()
					if IsValid(epanel) then epanel:Remove() end
					local tbl = {}
					
					for i, q in pairs(qtbl) do
						if i != k then
							tbl[#tbl+1] = q
						end
					end
					
					qtbl = tbl
					
					RefreshQuestList(true)
				end
				
				local edit = vgui.Create( "DButton", quest )
				edit:SetText( "Редактировать" )
				edit:SetSize( 128, 32 )
				edit:SetPos(quest:GetWide() - 282, quest:GetTall() - (48))
				function edit:DoClick()
					EditQuest(false, v)
				end
				
			end
			
			if save then
				panel:Save()
			end
			
		end
		
		local function RefreshTaskDataList(parent, data)
			if IsValid(panel.list) then parent.list:Remove() end
			parent.list = vgui.Create( "DScrollPanel", parent )
			local list = parent.list
			list:Dock( FILL )
			list:DockMargin( 0, 8, 0, 64 )
			
			for k, v in pairs(data) do
				if k != "task_type" then
					local data_editor = data_editors[k]
					local task = list:Add( "DPanel" )
					task:SetBackgroundColor(Color(150, 150, 150, 255))
					task:Dock(TOP)
					local lbl = vgui.Create( "DLabel", task )
					local txt = k
					if data_editor then
						txt = data_editor.name
					end
					lbl:SetText( txt )
					lbl:SizeToContents()
					lbl:Dock(LEFT)
					lbl:DockMargin( 16, 0, 0, 0 )
					
					if data_editor and data_editor.func then
						local edit = vgui.Create( "DImageButton", task )
						edit:Dock(RIGHT)
						edit:DockMargin( 0, 0, 8, 8 )
						edit:SetSize( 16, 16 )
						edit:SetImage( "icon16/application_edit.png" )
						function edit:DoClick()
							data_editor.func(panel, v, k, data)
						end
					else
						if isbool(v) then
							local checkbox = vgui.Create( "DCheckBox", task )
							checkbox:Dock(RIGHT)
							checkbox:DockMargin( 0, 0, 8, 8 )
							checkbox:SetValue( v )
							function checkbox:OnChange(b)
								data[k] = b
							end
						elseif isnumber(v) then
							local num = vgui.Create("DNumberWang", task)
							num:Dock(RIGHT)
							num:DockMargin( 0, 0, 8, 0 )
							num:SetMin(0)
							num:SetMax(999)
							num:SetValue(v)
							num.OnValueChanged = function(self)
								data[k] = self:GetValue()
							end
						elseif isstring(v) then
							local str = vgui.Create( "DTextEntry", task)
							str:Dock(RIGHT)
							str:DockMargin( 0, 0, 8, 0 )
							str:SetPaintBackground(true)
							str:SetText(v)
							function str:OnChange()
								data[k] = str:GetValue()
							end
						end
					end
				end
			end
		end
		
		local function TaskEdit(epanel, quest, new, task, taskid)
		
			if task == nil then
				task = {}
			end
			
			local panel = vgui.Create( "DFrame", epanel )
			panel:SetTitle( "task editor" )
			panel:SetSize( 512, 256 )
			panel:ShowCloseButton( true )
			panel:SetDraggable( true )
			panel:SetDeleteOnClose( true )
			
			panel:SetPos(ScrW()/2-256, ScrH()/2-200)
			panel:MakePopup()
			
			--kinda crimg but it all looks relatively fancy ingame
			local taskshit = {}
			
			local type_list = vgui.Create( "DComboBox", panel )
			type_list:Dock(TOP)
			type_list:SetValue( "Тип задачи" )
			for k, v in pairs(quest_task_types) do
				type_list:AddChoice( v.desc )
				taskshit[v.desc] = {task_type = k}
			end
			
			type_list.OnSelect = function( self, index, value )
				if not task.task_type or (task.task_type and taskshit[value].task_type != task.task_type) then
					task = {}
					local data = table.Copy(quest_task_types[taskshit[value].task_type].data)
					for k, v in pairs(data) do
						task[k] = v
					end
					task.task_type = taskshit[value].task_type
					RefreshTaskDataList(panel, task)
				end
			end
			
			local save = vgui.Create( "DButton", panel )
			save:SetText( "Сохранить" )
			save:SetSize( 128, 32 )
			save:SetPos( 16, panel:GetTall() - (48))
			
			function save:DoClick()
				surface.PlaySound("ui/buttonclick.wav")
				if task.task_type then
					if new then
						quest.tasks[#quest.tasks+1] = task
					else
						quest.tasks[taskid] = task
					end
					panel:Close()
					epanel:RefreshTaskList()
				end
			end
			
			if not new then
				RefreshTaskDataList(panel, task)
				if task.task_type then type_list:SetValue( quest_task_types[task.task_type].desc ) end
			end
			
		end
		
		function EditQuest(new, quest)
			if IsValid(epanel) then epanel:Remove() end
			local quest = quest
			
			if quest == nil then
				local qid = max_quest_id+1
				quest = {
					name = "Новый квест",
					desc = "Описание задачи",
					quest_id = qid,
					one_time = false,
					tasks = {},
					reward = {
						money = 100,
						items = {}
					}
				}
			end
			
			epanel = vgui.Create( "DFrame", panel )
			epanel:SetTitle( "quest" )
			epanel:SetSize( 512, 400 )
			epanel:ShowCloseButton( true )
			epanel:SetDraggable( true )
			epanel:SetDeleteOnClose( true )
			
			epanel:SetPos(ScrW()/2-256, ScrH()/2-325)
			epanel:MakePopup()

			local name = vgui.Create( "DTextEntry", epanel)
			name:SetPos(16, 48)
			name:SetSize(epanel:GetWide()-32, 32)
			name:SetFont( "ixSmallBoldFont" )
			name:SetPaintBackground(true)
			name:SetText(quest.name)

			local desc = vgui.Create( "DTextEntry", epanel)
			desc:SetPos(16, 96)
			desc:SetSize(epanel:GetWide()-32, 32)
			desc:SetFont( "ixSmallBoldFont" )
			desc:SetPaintBackground(true)
			desc:SetText(quest.desc)
			
			local onetime = vgui.Create( "DCheckBoxLabel", epanel )
			onetime:SetPos( 25, 142 )
			onetime:SetText("Один раз")
			onetime:SetValue( quest.one_time )
			onetime:SizeToContents()
			
			function onetime:OnChange(b)
				quest.one_time = b
			end

			local lbl = vgui.Create( "DLabel", epanel )
			lbl:SetText( "Задержка (мин):" )
			lbl:SizeToContents()
			lbl:SetPos(110, 142)

			local num = vgui.Create("DNumberWang", epanel)
			num:SetPos(200, 142)
			num:SetSize(80, 26)
			num:SetMin(1)
			num:SetMax(9999)

			num:SetValue(quest.delay or 1)
			
			num.OnValueChanged = function(self)
				quest.delay = self:GetValue()
			end
			
			local lbl = vgui.Create( "DLabel", epanel )
			lbl:SetText( "Награда:" )
			lbl:SizeToContents()
			lbl:SetPos(290, 142)
			
			local num = vgui.Create("DNumberWang", epanel)
			num:SetPos(340, 142)
			num:SetSize(80, 26)
			num:SetMin(0)
			num:SetMax(10000)
			
			num:SetValue(quest.reward.money or 0)
			
			num.OnValueChanged = function(self)
				quest.reward.money = self:GetValue()
			end

			local reward_items = vgui.Create( "DButton", epanel )
			reward_items:SetText( "Предметы" )
			reward_items:SetSize( 64, 32 )
			reward_items:SetPos( 430, 142)
			
			function reward_items:DoClick()
				surface.PlaySound("ui/buttonclick.wav")
				TableEditor(panel, quest.reward.items, "items")
			end
			
	
			local addtask = vgui.Create( "DButton", epanel )
			addtask:SetText( "Добавить задание" )
			addtask:SetSize( 128, 32 )
			addtask:SetPos( 154, epanel:GetTall() - (48))
			
			function addtask:DoClick()
				surface.PlaySound("ui/buttonclick.wav")
				TaskEdit(epanel, quest, true)
			end
			
			if quest.blacklist then
				local blacklist_edit = vgui.Create( "DButton", epanel )
				blacklist_edit:SetText( "Blacklist" )
				blacklist_edit:SetSize( 128, 32 )
				blacklist_edit:SetPos( 292, epanel:GetTall() - (48))
				
				function blacklist_edit:DoClick()
					surface.PlaySound("ui/buttonclick.wav")
					TableEditor(panel, quest.blacklist, "chars")
				end
			end
			
			local save = vgui.Create( "DButton", epanel )
			save:SetText( "Сохранить" )
			save:SetSize( 128, 32 )
			save:SetPos( 16, epanel:GetTall() - (48))
			
			function save:DoClick()
				if #quest.tasks <= 0 then return end
				surface.PlaySound("ui/buttonclick.wav")
				quest.name = name:GetValue()
				quest.desc = desc:GetValue()
				if new then
					qtbl[#qtbl+1] = quest
				else

				end
				epanel:Close()
				RefreshQuestList(true)
			end
			
			function epanel:RefreshTaskList()
			
				if IsValid(epanel.list) then epanel.list:Remove() end
				epanel.list = vgui.Create( "DScrollPanel", epanel )
				local list = epanel.list
				list:Dock( FILL )
				list:DockMargin( 0, 164, 0, 64 )
				
				for k, v in pairs(quest.tasks) do
				
					local task = list:Add( "DPanel" )
					task:SetBackgroundColor(Color(150, 150, 150, 255))
					task:Dock(TOP)
					local lbl = vgui.Create( "DLabel", task )
					lbl:SetText( quest_task_types[v.task_type].desc )
					lbl:SizeToContents()
					lbl:Dock(LEFT)
					lbl:DockMargin( 16, 0, 0, 0 )
					
					local delete = vgui.Create( "DImageButton", task )
					delete:Dock(RIGHT)
					delete:DockMargin( 0, 0, 8, 8 )
					delete:SetImage( "icon16/application_delete.png" )
					delete:SetSize( 16, 16 )
					function delete:DoClick()
						local tbl = {}
						for i, q in pairs(quest.tasks) do
							if k != i then
								tbl[#tbl+1] = q
							end
						end
						quest.tasks = tbl
						epanel:RefreshTaskList()
					end
					
					local edit = vgui.Create( "DImageButton", task )
					edit:Dock(RIGHT)
					edit:DockMargin( 0, 0, 8, 8 )
					edit:SetImage( "icon16/application_edit.png" )
					edit:SetSize( 16, 16 )
					function edit:DoClick()
						TaskEdit(epanel, quest, false, v, k)
					end
					
				end
				
			end
			epanel:RefreshTaskList()
		end
		
		panel = vgui.Create( "DFrame" )
		panel:SetTitle( "Редактор хуяктор" )
		panel:SetSize( 400, ScrH() )
		panel:ShowCloseButton( true )
		panel:SetDraggable( false )
		panel:SetDeleteOnClose( true )
		
		--panel:Center()
		panel:SetPos(0, 0)
		panel:MakePopup()
		
		function panel:Save()
			local args = {}
			args.dialogue = tbl
			args.quests = qtbl
			CommandServer("update_tables", trader, args) 
		end
		
		local switch = vgui.Create( "DButton", panel )
		switch:SetText( "Квесты" )
		switch:SetSize( 128, 32 )
		switch:SetPos(16, panel:GetTall() - (48))
		function switch:DoClick()
			surface.PlaySound("ui/buttonclick.wav")
			if IsValid(epanel) then epanel:Remove() end
			if dialogue_mode then
				root:Remove()
				RefreshQuestList(false)
				switch:SetText("Диалоги")
				
				panel.new_quest = vgui.Create( "DButton", panel )
				local newq = panel.new_quest
				newq:SetText( "Новый квест" )
				newq:SetSize( 128, 32 )
				newq:SetPos( 152, panel:GetTall() - (48))
				
				function newq:DoClick()
					surface.PlaySound("ui/buttonclick.wav")
					EditQuest(true)
				end
				
				dialogue_mode = false
			else
				if IsValid(panel.new_quest) then panel.new_quest:Remove() end
				RefreshList(false)
				switch:SetText( "Квесты" )
				dialogue_mode = true
			end
		end
		
		RefreshList(false)
		
	end

	net.Receive( "ixDialogueEditor", function(len)
	
		local ent = net.ReadEntity()
		local tbl = net.ReadTable()
		local qtbl = net.ReadTable()
		
		DialogueEditor(ent, tbl, qtbl)
	end)
	
end
