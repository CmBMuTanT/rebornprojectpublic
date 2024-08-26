util.AddNetworkString('ShitLVLUP')

local playerMeta = FindMetaTable("Player")

function playerMeta:AddExp(amount)
	local exp = self:GetLocalVar("exp", 0) + amount

	local nextLvl = (self:GetNetVar("lvl", 1) + 1)
	if (nextLvl >= ix.config.Get("maxLvl")) then
		return
	end

	self:SetLocalVar("exp", exp)

	local lvlam = (nextLvl / 2 * (nextLvl - 1) * 150 + (nextLvl - 1) * 50)

	if (exp >= lvlam) then
		self:SetNetVar("lvl", nextLvl)
		self:EmitSound("fosounds/fix/ui_levelup.mp3")

		timer.Simple(1, function()
			self:SetLocalVar("AttribPoints", self:GetLocalVar("AttribPoints", 0) + 5)
			self:Notify("У вас повысился уровень напишите в чат /UseScore")
		end)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	client:SetNetVar("lvl", character:GetData("lvl", 1))
	client:SetLocalVar("exp", character:GetData("exp", 0))
	
	local points = character:GetData("AttribPoints", 0)
	client:SetLocalVar("AttribPoints", points)
	
	if (points > 0) then
		client:Notify("У вас есть очки атрибутов " .. points .. " в чат /UseScore")
	end
	
	timer.Create("LvlUpOnTime"..client:SteamID64(),10 * 60,0,function()
		if IsValid(client) and client:GetCharacter() then
			client:AddExp(15)
			client:Notify("Вы получили 15 опыта за игру на сервере")
		end
	end)
end

function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()

	character:SetData("lvl", client:GetNetVar("lvl", 1))
	character:SetData("exp", client:GetLocalVar("exp", 0))
	character:SetData("AttribPoints", client:GetLocalVar("AttribPoints", 0))
end

net.Receive('ShitLVLUP', function(len, client)
	local attributes = net.ReadTable()
	if table.IsEmpty(attributes) then return end

	local character = client:GetCharacter()
	if (!character) then
		return
	end
	local attrib_points = client:GetLocalVar("AttribPoints", 0)
	if attrib_points < 1 then return end

	local attrib_value = 0
	for k in pairs(ix.attributes.list) do
		if attrib_points < 1 then
			break
		end

		attrib_value = attributes[k]

		if attrib_value and attrib_value > 0 then
			attrib_points = math.max(attrib_points - attrib_value, 0)
			character:UpdateAttrib(k, attrib_value)
		end
	end

	client:SetLocalVar('AttribPoints', attrib_points)

	attrib_value = nil
	attrib_points = nil
	attributes = nil
end)

function PLUGIN:OnNPCKilled(npc, ent)

    local class = npc:GetClass()

    if IsValid(ent) and ent:IsPlayer() then
		if (class == "npc_vj_arachnid") then   -- (class == "класс нпс")
			ent:AddExp(30)                                      -- (AddExp(кол-во EXP))
			ent:Notify("Вы получили следующее кол-во опыта - 30")-- Notify("Вы получили следующее кол-во опыта - кол-во XP")
		elseif (class == "npc_vj_arachind_2") then
			ent:AddExp(25)
			ent:Notify("Вы получили следующее кол-во опыта - 25")
			
		elseif (class == "npc_vj_lurker") then
			ent:AddExp(15)
			ent:Notify("Вы получили следующее кол-во опыта - 15")
			
			elseif (class == "npc_vj_lurker") then
			ent:AddExp(30)
			ent:Notify("Вы получили следующее кол-во опыта - 30")
			
			elseif (class == "npc_vj_lurker3") then
			ent:AddExp(50)
			ent:Notify("Вы получили следующее кол-во опыта - 50")
			
		elseif (class == "npc_vj_nosalis") then
			ent:AddExp(30)
			ent:Notify("Вы получили следующее кол-во опыта - 30")
			
			elseif (class == "npc_vj_nosalis") then
			ent:AddExp(50)
			ent:Notify("Вы получили следующее кол-во опыта - 50")
			
			elseif (class == "npc_vj_nosalis3") then
			ent:AddExp(80)
			ent:Notify("Вы получили следующее кол-во опыта - 80")
			
		elseif (class == "npc_vj_nosalis_female") then
			ent:AddExp(33)
			ent:Notify("Вы получили следующее кол-во опыта - 33") 
		elseif (class == "npc_vj_nosalis_mom") then
			ent:AddExp(2500)
			ent:Notify("Вы получили следующее кол-во опыта - 2500")
		elseif (class == "npc_vj_black_m") then
			ent:AddExp(150)
			ent:Notify("Вы получили следующее кол-во опыта - 200")
		elseif (class == "npc_vj_black_m2") then
			ent:AddExp(100)
			ent:Notify("Вы получили следующее кол-во опыта - 100")
		elseif (class == "npc_vj_black_m4") then
			ent:AddExp(110)
			ent:Notify("Вы получили следующее кол-во опыта - 110")
		elseif (class == "npc_vj_black_m3") then
			ent:AddExp(120)
			ent:Notify("Вы получили следующее кол-во опыта - 120")
		elseif (class == "npc_vj_watcher") then
			ent:AddExp(55)
			ent:Notify("Вы получили следующее кол-во опыта - 55")
		elseif (class == "npc_vj_dmvj_spider_queen") then
			ent:AddExp(5000)
			ent:Notify("Вы получили следующее кол-во опыта - 5000")
		elseif (class == "npc_vj_dmvj_facehugger") then
			ent:AddExp(15)
			ent:Notify("Вы получили следующее кол-во опыта - 15")
		elseif (class == "npc_mutant_librarian") then
			ent:AddExp(86)
			ent:Notify("Вы получили следующее кол-во опыта - 86")
		elseif (class == "vj_mutant_biblio2") then
			ent:AddExp(65)
			ent:Notify("Вы получили следующее кол-во опыта - 65")
		elseif (class == "npc_vj_dmvj_spider") then
			ent:AddExp(30)
			ent:Notify("Вы получили следующее кол-во опыта - 30")
		elseif (class == "vj_mutant_ameba") then
			ent:AddExp(10)
			ent:Notify("Вы получили следующее кол-во опыта - 10")
		elseif (class == "vj_mutant_biomasa") then
			ent:AddExp(20)
			ent:Notify("Вы получили следующее кол-во опыта - 20")
		elseif (class == "vj_mutant_bear2") then
			ent:AddExp(80)
			ent:Notify("Вы получили следующее кол-во опыта - 80")
		elseif (class == "vj_mutant_bear") then
			ent:AddExp(80)
			ent:Notify("Вы получили следующее кол-во опыта - 80")
		elseif (class == "vj_mutant_boar") then	
			ent:AddExp(15)
			ent:Notify("Вы получили следующее кол-во опыта - 15")
		elseif (class == "vj_mutant_boar3") then		
			ent:AddExp(25)
			ent:Notify("Вы получили следующее кол-во опыта - 25")
		elseif (class == "vj_mutant_boar2") then	
			ent:AddExp(35)
			ent:Notify("Вы получили следующее кол-во опыта - 35")
		elseif (class == "vj_mutant_morlok") then		
			ent:AddExp(45)
			ent:Notify("Вы получили следующее кол-во опыта - 45")
	    elseif (class == "vj_mutant_zombi4") then	
			ent:AddExp(20)
			ent:Notify("Вы получили следующее кол-во опыта - 20")
		elseif (class == "vj_mutant_dog") then	
			ent:AddExp(10)
			ent:Notify("Вы получили следующее кол-во опыта - 10")
		elseif (class == "vj_mutant_frog") then	
			ent:AddExp(10)
			ent:Notify("Вы получили следующее кол-во опыта - 10")
		elseif (class == "vj_mutant_shadow2") then	
			ent:AddExp(35)
			ent:Notify("Вы получили следующее кол-во опыта - 35")
		elseif (class == "vj_mutant_mimikria2") then
			ent:AddExp(45)
			ent:Notify("Вы получили следующее кол-во опыта - 45")
		elseif (class == "vj_mutant_biblio3") then
			ent:AddExp(35)
			ent:Notify("Вы получили следующее кол-во опыта - 35")
		elseif (class == "vj_mutant_taran") then
			ent:AddExp(50)
			ent:Notify("Вы получили следующее кол-во опыта - 50")
		elseif (class == "vj_mutant_spider") then
			ent:AddExp(15)
			ent:Notify("Вы получили следующее кол-во опыта - 15")
		elseif (class == "vj_mutant_rat") then
			ent:AddExp(5)
			ent:Notify("Вы получили следующее кол-во опыта - 5")
		elseif (class == "vj_mutant_rotan") then
			ent:AddExp(30)
			ent:Notify("Вы получили следующее кол-во опыта - 30")
		elseif (class == "vj_mutant_biblio") then
            ent:AddExp(60)
		    ent:Notify("Вы получили следующее кол-во опыта - 60")	
		end
	end
end