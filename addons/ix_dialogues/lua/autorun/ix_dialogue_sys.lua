
include("ix_dialogue_editor.lua")
--nanana

if SERVER then
	util.AddNetworkString("ixDialogueMenu")
	util.AddNetworkString("ixDialogueCommand")
	
	net.Receive( "ixDialogueCommand", function( len, ply )
		
		local ent = net.ReadEntity()
		local cmd = net.ReadString()
		local args = net.ReadTable()
		
		if cmd == "trade" then
			ent:OpenTrade(ply)
		elseif cmd == "quest_request" then
			local rand = math.random(1, #ent.quests)
			local quest = ent.quests[rand] or nil
			
			local charid = ply:GetCharacter():GetID()
			
			if quest == nil then 
				cmd = "noquests"
				quest = {} 
			else
				if quest.blacklist and quest.blacklist[charid] != nil and (quest.blacklist[charid] == true or quest.blacklist[charid] > os.time()) then
					cmd = "noquests"
					quest = {} 
				else
					quest.id = rand
				end
			end
			
			net.Start( "ixDialogueCommand" )
				net.WriteEntity(ent)
				net.WriteString(cmd)
				net.WriteTable(quest)
			net.Send(ply)
		elseif cmd == "quest_accept" then
			local quest = ent.quests[args.id]
			if quest then
				ply:AddQuest(quest, ent)
			end
		elseif cmd == "quest_complete" then
			if ply:IsQuestComplete(ent:GetVendorID()) then
				ply:QuestFinish(ent)
			end
		elseif cmd == "quest_cancel" then
			ply:CancelQuest(ent)
		elseif cmd == "update_tables" then
			if CAMI.PlayerHasAccess(ply, "Helix - Manage Vendors", nil) then
				ent.dialogue = args.dialogue
				ent.quests = args.quests
				ent.npcsound = args.soundnpc
			end
		elseif cmd == "quest_dialogue_complete" then
			local quest = ply.quests[args.quest_id]
			if quest then
				for k, v in pairs(quest.tasks) do
					if v.vendor_id == args.vendor_id then
						v.finished = true
					end
				end
			end
		elseif cmd == "quest_dialogue_quit" then
			local quest = ply.quests[args.quest_id]
			PrintTable(quest)
			if quest then
				for k, v in pairs(quest.tasks) do
					if v.vendor_id == args.vendor_id then
						for k, v in ipairs(ents.FindByClass("ix_vendor")) do
							if v:GetVendorID() == args.quest_id then
								ply:QuestFinish(v, true)
								break
							end
						end
					end
				end
			end
		end
		
	end)
	
end

if CLIENT then

	local accent_color = Color(179, 102, 255, 255)--Color(177, 82, 24, 255)
	local white_color = Color(255,255,255,255)
	local green_color = Color(51, 255, 51, 255)
	local red_color = Color(255, 51, 51, 255)
	
	local panel = nil

	local function CheckQuestDialogue(quest_id, ent)
		local ply = LocalPlayer()
		if ply.quests then
			local quest = ply.quests[quest_id]
			if quest then
				for k, v in pairs(quest.tasks) do
					if v.vendor_id == ent:GetVendorID() then
						return true
					end
				end
			end
		end
		return false
	end

	local function DialogueMenu(ent, tbl)
		local ply = LocalPlayer()
		
		panel = vgui.Create( "DFrame" )
		panel:SetTitle( "" )
		panel:SetSize( ScrW()*0.6, ScrH() )
		panel:ShowCloseButton( true )
		panel:SetDraggable( false )
		panel:SetDeleteOnClose( true )
		
		panel:Center()
		panel:MakePopup()
		
		panel.ent = ent
		panel.tbl = tbl
		panel.first_time = true
		
		panel.Paint = function()
		
			draw.RoundedBox( 0, 0, 0, panel:GetWide(), panel:GetTall(), Color(0,0,0,200) )
				
			--draw.RoundedBox( 0, 0, 0, panel:GetWide(), 64, Color(0,0,0,255) )
			draw.RoundedBox( 0, 0, panel:GetTall()-180, panel:GetWide(), 180, Color(0,0,0,150) )
			draw.RoundedBox( 0, 0, panel:GetTall()-180, panel:GetWide(), 2, accent_color )
			
			--draw.SimpleText( "Верстак", "ixTitleFont", 32, 32, white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		
		end
		
		local text = vgui.Create( "RichText", panel )
		text:SetSize( panel:GetWide() - 128, panel:GetTall() - 252 )
		text:SetPos( 64, 64 )
		--text:SetVerticalScrollbarEnabled(false)
		--text:SetMouseInputEnabled(false)
		
		function text:PerformLayout()
			text:SetFontInternal( "ixSmallBoldFont" ) 
		end		
		
		function panel:AddDialogueLine(player, txt)
			if txt != "" then
				if player then
					text:InsertColorChange( green_color.r, green_color.g, green_color.b, green_color.a )
					text:AppendText(ply:GetName().."\n")
				else
					text:InsertColorChange( accent_color.r, accent_color.g, accent_color.b, accent_color.a )
					text:AppendText(ent:GetDisplayName().."\n")
				end
				text:InsertColorChange( 255, 255, 255, 255 )
				text:AppendText( "	"..txt.."\n" )
			end
		end
		
		function panel:PrintQuestDesc(tbl)
			text:InsertColorChange( accent_color.r, accent_color.g, accent_color.b, accent_color.a )
			text:AppendText(ent:GetDisplayName().."\n")

			text:InsertColorChange( 255, 255, 255, 255 )
			text:AppendText( "	ЗАДАНИЕ: " )
			
			text:InsertColorChange( accent_color.r, accent_color.g, accent_color.b, accent_color.a )
			text:AppendText(tbl.name.."\n\n")
			
			text:InsertColorChange( 255, 255, 255, 255 )
			text:AppendText( "	"..tbl.desc.."\n\n" )
			
			for k, v in pairs(tbl.tasks) do
				ttype = quest_task_types[v.task_type]
				if ttype then
					text:InsertColorChange( accent_color.r, accent_color.g, accent_color.b, accent_color.a )
					text:AppendText( "	"..ttype.desc..": \n" )
					if ttype.desc_func then
						ttype.desc_func(text, v)
					end
				end
			end
			
			if tbl.reward then
				text:InsertColorChange( green_color.r, green_color.g, green_color.b, green_color.a )
				text:AppendText( "\n	Награда: \n" )
				if tbl.reward.money then
					text:InsertColorChange( 255, 255, 255, 255 )
					text:AppendText( "		Деньги x "..tbl.reward.money.."\n" )
				end
				if tbl.reward.items then
					for k, v in pairs(tbl.reward.items) do
						local name = ix.item.list[v].name
						text:AppendText( "		"..name.."\n" )
					end
				end
			end
			
		end
		
		function panel:PrintRewardMsg(reward)
			text:InsertColorChange( green_color.r, green_color.g, green_color.b, green_color.a )
			text:AppendText("\n ПОЛУЧЕНА НАГРАДА:")
			
			if reward.money then
				text:InsertColorChange( 255, 255, 255, 255 )
				text:AppendText( "	Деньги x "..reward.money.."\n" )
			end
			
			if reward.items then
				for k, v in pairs(reward.items) do
					local name = ix.item.list[v].name
					text:AppendText( "	"..name.."\n" )
				end
			end
		end
		
		function panel:MakeButtons(tbl, isabranch)
			if panel.list != nil then panel.list:Remove() end
		
			panel.list = vgui.Create( "DScrollPanel", panel )
			local list = panel.list
			--list:Dock( FILL )
			--list:DockMargin( 16, 64, ScrW()-380, 16 )
			list:SetPos(0, panel:GetTall() - 170)
			list:SetSize(panel:GetWide(), 170)
			
			local button_index = 0
			local has_quit = false
			
			local function CreateButton(v)
				local button = list:Add( "DButton" )
				button:SetText("")
				button:SetPos(0, 0 + (40*button_index))
				button:SetSize( panel:GetWide(), 40 )
				
				button.CurBool = false
				
				if v.answer == "quit" or v.answer == "reset_buttons" or v.answer == "reset_print" then has_quit = true end
				
				local acommand = answer_commands[v.answer] 
				if acommand and acommand.make then acommand.make(panel, ent, v) end
				
				function button:DoClick()
				
					surface.PlaySound("ui/buttonclick.wav")
					local acommand = answer_commands[v.answer] 
					if acommand then
						if acommand.exec then acommand.exec(panel, ent, v) end
					else
						panel:AddDialogueLine(true, v.question)
						panel:AddDialogueLine(false, v.answer)
						surface.PlaySound(v.soundnpc)
					end
					
					if v.branch then
						panel:MakeButtons(v.branch, true)
					else
						if !acommand then
						
							local ntbl = {}
							
							for k, vv in pairs(tbl) do
								local qcommand = question_commands[vv.question] 
								if not qcommand and vv.answer != v.answer and vv.question != v.question then
									ntbl[k] = vv
								end
							end 
						
							panel:MakeButtons(ntbl, isabranch)
						end
					end
					--button:Remove()
				end
				
				button.OnCursorEntered = function() button.CurBool = true end
				button.OnCursorExited = function() button.CurBool = false end
			
				function button:Paint()
					if button.CurBool then
						draw.RoundedBox( 0, 0, 0, 5, 40, accent_color )
						draw.RoundedBox( 0, panel:GetWide()-5, 0, 5, 40, accent_color )
						draw.SimpleText( v.question, "ix3D2DSmallFont", 32, 20, accent_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					else
						draw.SimpleText( v.question, "ix3D2DSmallFont", 32, 20, white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					end
				end
				
				button_index = button_index+1
			end
			
			local has_quest_dialogue = false
			
			for k, v in pairs(tbl) do
				local qcommand = question_commands[v.question] 
				if qcommand then
					if qcommand.exec then qcommand.exec(panel, ent, v) end
				elseif string.sub(v.question, 1, 5) == "quest" then
					local quest_id = tonumber(string.sub(v.question, 6, 9))
					if CheckQuestDialogue(quest_id, ent) and !has_quest_dialogue then
						panel.quest_id = quest_id
						panel.vendor_id = ent:GetVendorID()
						has_quest_dialogue = true
						CreateButton({
							question = v.answer,
							answer = "",
							soundnpc = "",
							branch = v.branch
						})
					end
				elseif string.sub(v.question, 1, 5) != "quest" then
					CreateButton(v)
				end
			end
			
			if not has_quit then
				
				local b = {}
				
				if !isabranch then
					b.question = "Уйти"
					b.answer = "quit"
				else
					b.question = "Назад"
					b.answer = "reset_buttons"				
				end
				
				CreateButton(b)
			end
			
		end
		
		panel:MakeButtons(tbl, false)
		
	end
	
	net.Receive( "ixDialogueMenu", function(len)
	
		local ent = net.ReadEntity()
		local tbl = net.ReadTable()
	
		DialogueMenu(ent, tbl)
	end)
	
	net.Receive( "ixDialogueCommand", function(len)
	
		local ent = net.ReadEntity()
		local cmd = net.ReadString()
		local tbl = net.ReadTable() or {}
	
		local ply = LocalPlayer()

		if cmd == "sync_quests" then
			ply.quests = tbl
		return end
	
		if panel != nil and IsValid(panel) and (panel.ent == ent or panel.quest_id == ent:GetVendorID()) then
			if cmd == "quest_request" then
				panel:PrintQuestDesc(tbl)
				
				panel.quest_id = tbl.id
				
				local buttons = {
					[1] = {
						question = "Принять",
						answer = "quest_accept"
					},
					[2] = {
						question = "Отказ",
						answer = "reset_print"
					}
				}
				panel:MakeButtons(buttons, false)
			elseif cmd == "noquests" then
				panel:AddDialogueLine(false, "Сейчас нет заданий!")
			elseif cmd == "reward_msg" then
				panel:PrintRewardMsg(tbl)
			end
		end
	end)
	
end
