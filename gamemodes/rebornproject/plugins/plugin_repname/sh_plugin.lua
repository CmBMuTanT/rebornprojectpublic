local PLUGIN = PLUGIN
PLUGIN.name = "Reputation"
PLUGIN.author = "hoobsung"
PLUGIN.desc = "Система Репутации"

PLUGIN.repDefs = {
	{"Совсем зелёный", 0},
	{"Новичок", 20},
    {"Бывалый", 40},
	{"Опытный", 60},
	{"Ветеран", 90},
	{"Прирожденный охотник", 130},
	{"Мастер", 200},
	{"Легендарный охотник", 350},
	{"Легендарный сталкер", 300},
}

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")

function playerMeta:getReputation()
	return (self:GetNetVar("reputation")) or 0
end

function playerMeta:getRepName()
	return (self:GetNetVar("repOverride")) or 0
end

function playerMeta:addReputation(amount)
	self:SetNetVar("reputation", self:getReputation() + amount)
end

function playerMeta:setReputation(amount)
	self:SetNetVar("reputation", amount)
end

function playerMeta:getCurrentRankName()
	local rep = self:GetNetVar("reputation") or 0

	if self:getRepName() != 0 then
		return self:getRepName()
	end
	
	for i = 1, #PLUGIN.repDefs do
		if PLUGIN.repDefs[i][2] > rep then
			return PLUGIN.repDefs[i-1][1]
		end
	end

	return PLUGIN.repDefs[#PLUGIN.repDefs][1]
end

function playerMeta:getArbitraryRankName(rep)
	for i = 1, #PLUGIN.repDefs do
		if PLUGIN.repDefs[i][2] > rep then
			return PLUGIN.repDefs[i-1][1]
		end
	end

	return PLUGIN.repDefs[#PLUGIN.repDefs][1]
end

function PLUGIN:PopulateCharacterInfo(client, character, container)
	local recognize = LocalPlayer():GetCharacter():DoesRecognize(character)
	local text = client:getCurrentRankName() or nil
	
	if (text) then
		local repnametext = container:AddRow("reputation")
		repnametext:SetText(text)
		repnametext:SetTextColor(Color(138, 43, 226))
		repnametext:SizeToContents()
	end
end

-- Register HUD Bars.
if (SERVER) then
	local PLUGIN = PLUGIN
	
	function PLUGIN:CharacterPreSave(character)
		character:SetData("reputation", character.player:getReputation())
		character:SetData("repOverride", character.player:getRepName())
	end

	function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)	
		if (character:GetData("reputation")) then
			client:SetNetVar("reputation", character:GetData("reputation"))
		else
			client:SetNetVar("reputation", 0)
		end

		if (character:GetData("repOverride")) then
			client:SetNetVar("repOverride", character:GetData("repOverride"))
		else
			client:SetNetVar("repOverride", 0)
		end
	end
end

ix.command.Add("charsetreputation", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, target, reputation)
		local target = ix.util.FindPlayer(target)
		local reputation = tonumber(reputation)

		target:setReputation(reputation)

		if client == target then
            client:Notify("Вы установили свою репутацию "..reputation)
        else
            client:Notify("Вы установили "..target:Name().."'Репутация к "..reputation)
            target:Notify(client:Name().." Установил вашу репутацию на "..reputation)
        end
	end
})

ix.command.Add("charaddreputation", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, target, reputation)
		local target = ix.util.FindPlayer(target)
		local reputation = tonumber(reputation)

		target:addReputation(reputation)

		if client == target then
            client:Notify("Вы добавили"..reputation.." Вашей репутации.")
        else
            client:Notify("Вы добавили"..reputation.." к "..target:Name().."'репутация.")
            target:Notify(client:Name().." добавил "..reputation.." вашей репутации.")
        end
	end
})

ix.command.Add("charcheckreputation", {
	adminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, target)
		local target = ix.util.FindPlayer(target)

		if target then 
        	client:Notify(target:Name() .. " имеет "..target:getReputation().." репутация.")
    	else
            client:Notify("Игрок не найден")
        end
	end
})

ix.command.Add("charrepnameset", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.string
	},
	OnRun = function(self, client, target, name)
		local target = ix.util.FindPlayer(target)
		local reputation = name

		target:SetNetVar("repOverride", reputation)

		if client == target then
            client:Notify("Настраиваемый набор рангов.")
        else
            client:Notify("Настраиваемый набор рангов.")
            target:Notify(client:Name().." установил ваше имя репутации.")
        end
	end
})

ix.command.Add("charrepnameremove", {
	adminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, target)
		local target = ix.util.FindPlayer(target)

		target:SetNetVar("repOverride", 0)

		if client == target then
            client:Notify("Пользовательское ранговое имя удалено")
        else
            client:Notify("Пользовательское ранговое имя удалено")
            target:Notify(client:Name().." удалил ваше имя репутации.")
        end
	end
}) 

hook.Add( "OnNPCKilled", "PlusRepOnNPCKilled", function( npc, attacker, inflictor )
	if attacker:IsPlayer() then
		attacker:addReputation(1)
	end
end)
