
local quest_think_time = 5												--как часто проверять квесты
local quest_cooldown = 60												--задержка квеста

quest_task_types = {
	["find_items"] = {
		desc = "Найти предметы",
		data = {
			items = {"item_class"}
		},
		desc_func = function(text, tbl)									--описание задачи
			for k, v in pairs(tbl.items) do
				local name = "ты ошибся предметом, иди переделывай"
				if ix.item.list[v] then
					name = ix.item.list[v].name
				end
				text:InsertColorChange( 255, 255, 255, 255 )
				text:AppendText( "		"..name.."\n" )
			end
		end,
		get_func = function(tbl, ply)									--вызывается когда игрок получил квест
		end,
		check_func = function(tbl, ply)									--проверка на выполнение задания
			local char = ply:GetCharacter()
			local inv = char:GetInventory()
			if inv:HasItems(tbl.items) then
				return true
			end
			return false
		end,
		complete_func = function(tbl, ply)								--вызывается когда квест сдан
			local char = ply:GetCharacter()
			local inv = char:GetInventory()
			for k, v in pairs(tbl.items) do
				local iitem = inv:HasItem(v)
				if !iitem.isTool then
					iitem:Remove()
				end
			end
		end,
		cancel_func = function(tbl, ply)								--вызывается при отмене квеста
		end
	},
	["kill_npc"] = {
		desc = "Убить НПС",
		data = {
			class = "npc_zombie",
			killcount = 5
		},
		desc_func = function(text, tbl)
			text:InsertColorChange( 255, 255, 255, 255 )
			text:AppendText( "		x"..tbl.killcount.." \n" )
		end,
		get_func = function(tbl, ply)
			ply:CacheKillQuest(tbl.giver_id)
		end,
		check_func = function(tbl, ply)
			if tbl.killcount <= 0 then
				return true
			end
			return false
		end,
		complete_func = function(tbl, ply)
			ply:UncacheKillQuest(tbl.giver_id)
		end,
		cancel_func = function(tbl, ply)
			ply:UncacheKillQuest(tbl.giver_id)
		end
	},
	["talk_to"] = {
		desc = "Поговорить с другим торговцем",
		data = {
			finished = false,
			vendor_id = 2
		},
		desc_func = function(text, tbl)
			local name = "другим торговцем"
			for k, v in ipairs(ents.FindByClass("ix_vendor")) do
				if v:GetVendorID() == tbl.vendor_id then
					name = v:GetDisplayName()
				end
			end
			text:InsertColorChange( 255, 255, 255, 255 )
			text:AppendText( "		Поговорить с " )
			text:InsertColorChange( 51, 255, 51, 255 )
			text:AppendText( name.." \n" )
		end,
		get_func = function(tbl, ply)
		end,
		check_func = function(tbl, ply)
			return tbl.finished 
		end,
		complete_func = function(tbl, ply)
		end,
		cancel_func = function(tbl, ply)
		end
	}
}

if SERVER then

	hook.Add("OnNPCKilled", "OnNPCKilledQuests", function(npc, ply, inflictor)
		if ply:IsPlayer() and ply.quests then
			local tbl = ply:GetQuestsDataTable()
			if tbl.killquests != nil then
				for k, v in pairs(tbl.killquests) do
					if ply.quests[k] then
						for i, t in pairs(v) do
							local task = ply.quests[k].tasks[i]
							if task and task.task_type == "kill_npc" and task.class == npc:GetClass() then
								task.killcount = task.killcount-1
							end
						end
					end
				end
			end
		end
	end)

	local meta = FindMetaTable("Player")
	
	--a table to store temporary stuff
	function meta:GetQuestsDataTable()
		if self.quests_data == nil then
			self.quests_data = {}
		end
		return self.quests_data
	end
	
	function meta:CacheKillQuest(quest_id)
		if self.quests then
			if self.quests_data == nil then self.quests_data = {} end
			local tbl = self.quests_data
			PrintTable(tbl)
			if tbl.killquests == nil then
				tbl.killquests = {}
			end
			tbl.killquests[quest_id] = {}
			
			--store which tasks need to be checked
			local quest = self.quests[quest_id]
			if quest then
				for i, t in pairs(quest.tasks) do
					if t.task_type == "kill_npc" then
						tbl.killquests[quest_id][i] = true
					end
				end
			end
			PrintTable(tbl.killquests)
		end
	end

	function meta:UncacheKillQuest(quest_id)
		local tbl = self.quests_data
		if tbl.killquests != nil then
			tbl.killquests[quest_id] = nil
		end
	end

	function meta:ResetQuests()
		meta.quests = {}
		meta.quests = meta.quests
		meta.quests_data = {}
		meta.quests_data = meta.quests_data
		net.Start( "ixDialogueCommand" )
			net.WriteEntity(nil)
			net.WriteString("sync_quests")
			net.WriteTable(meta.quests)
		net.Send(self)
	end

	function meta:AddQuest(tbl, giver)
		local ply = self
		
		local giver_id = giver:GetVendorID()
		
		if ply.quests == nil then
			ply.quests = {}
		end
		
		if ply.quests[giver_id] != nil then
			ply:Notify("Вы уже взяли задание у "..giver:GetDisplayName())
		return end
		
		local q = table.Copy(tbl)
		q.giver_id = giver_id
		ply.quests[giver_id] = q
		
		for k, v in pairs(q.tasks) do
			local ttype = quest_task_types[v.task_type]
			v.giver_id = q.giver_id or giver_id
			if ttype and ttype.get_func then
				ttype.get_func(v, ply)
			end
		end
		
		ply:Notify("Вы получили задание от "..giver:GetDisplayName())
		
		net.Start( "ixDialogueCommand" )
			net.WriteEntity(nil)
			net.WriteString("sync_quests")
			net.WriteTable(ply.quests)
		net.Send(ply)
	end
	
	function meta:QuestFinish(giver, force)
		local ply = self
		
		local id = giver:GetVendorID()
				
		if ply.quests and ply.quests[id] then
			local quest = ply.quests[id]
			if quest.complete or force then
			
				for i, q in pairs(giver.quests) do
					if q.quest_id == quest.quest_id then
						if q.blacklist == nil then q.blacklist = {} end
						local charid = ply:GetCharacter():GetID()
						if quest.one_time and q.one_time then
							q.blacklist[charid] = true
						else
							local delay = quest_cooldown
							if q.delay then delay = q.delay*60 end 
							q.blacklist[charid] = os.time()+delay
						end
					end
				end

				for k, v in pairs(ply.quests[id].tasks) do
					local ttype = quest_task_types[v.task_type]
					if ttype and ttype.complete_func then
						ttype.complete_func(v, ply)
					end
				end
			
				ply:Notify("Задание выполнено!")
			
				local reward = ply.quests[id].reward
				
				local char = ply:GetCharacter()
				local inv = char:GetInventory()
				
				if reward.money then
					char:SetMoney(char:GetMoney()+reward.money)
				end
				if reward.items then
					for k, v in pairs(reward.items) do
						inv:Add(v, 1)
					end
				end
				
				ply.quests[id] = nil
				
				net.Start( "ixDialogueCommand" )
					net.WriteEntity(giver)
					net.WriteString("reward_msg")
					net.WriteTable(reward)
				net.Send(ply)
				
				ply:CheckQuests()
			end
		end
	end
	
	function meta:IsQuestComplete(id)
		local ply = self
		ply:CheckQuests()
		if ply.quests and ply.quests[id] then
			if ply.quests[id].complete then
			return true end
		end
		return false
	end
	
	function meta:CancelQuest(giver)
		local ply = self
		
		local giver_id = giver:GetVendorID()
		
		if ply.quests and ply.quests[giver_id] then
			
			for k, v in pairs(ply.quests[giver_id].tasks) do
				local ttype = quest_task_types[v.task_type]
				if ttype and ttype.cancel_func then
					ttype.cancel_func(v, ply)
				end
			end
			
			ply.quests[giver_id] = nil
			ply:Notify("Задание от "..giver:GetDisplayName().." отменено!")
			
			ply:CheckQuests()
		end
	end
	
	function meta:CheckQuests()
		local ply = self
		
		if ply.quests == nil then return end
		
		for k, v in pairs(ply.quests) do
			v.complete = true
			for i, t in pairs(v.tasks) do
				local ttype = quest_task_types[t.task_type]
				t.quest_id = v.quest_id or k
				
				if ttype and ttype.check_func then
					t.complete = ttype.check_func(t, ply)
				end
				
				if !t.complete then
					v.complete = false
				end
				
			end
		end
		
		net.Start( "ixDialogueCommand" )
			net.WriteEntity(nil)
			net.WriteString("sync_quests")
			net.WriteTable(ply.quests)
		net.Send(ply)
		
	end
	
	hook.Add("PlayerPostThink", "PlayerPostThinkQuests", function(ply)
		if ply.next_quest_think == nil or ply.next_quest_think < CurTime() then
			ply:CheckQuests()
			ply.next_quest_think = CurTime() + quest_think_time
		end
	end)
	
end
