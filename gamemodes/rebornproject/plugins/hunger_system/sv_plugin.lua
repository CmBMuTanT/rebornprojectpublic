local HUNGER_ID, DRUNK_ID, THIRST_ID = "hunger", "drunk", "thirst"

local boost = { -- Буст переменные
	base = .3, -- Множитель к шансу готовки (.3 = 0.3)
	chance = 1.5, -- Шанс на успешную готовку
	exp = .1 -- Множитель опыта к обновлению аттрибута
}

local Drunk = {}
Drunk.Say = { -- ic
	"Эх, раз... Да ещё раз... Да ещё много-много раз! Ик!",
	"Хо-р-р-шо пошла...",
	"А как лесное лихо трахаеца никто, ик, не видел? Могу рассказать!",
	"О,видите птицу? А факел видите? С-час буим, ик, делать, ик-бля, чудо-птицу... Этого... Феникса, во!..",
	"Ну-с, между первой и второй - перерывчик не большой... Или какая это у нас?",
	"А де-е-евица-а-а из Викова-а-аро... Ык!... Любит то-о-лька... За амба-а-аром!",
	"А у второ-о-ой из Викова-а-аро не в чести ложи-и-итца да-а-аром!",
	"А у третьей нету пра-а-авил, лишь бы кто-о-о-нибудь, да вста-а-авил!"
}

Drunk.Emotes = { -- me
	"неприлично рыгает на всю округу.",
	"задорно распевает деревенские частушки.",
	"выражает одной отрыжкой весь философский смысл бытия.",
	"неумело, но свободно, выкрикивает что-то на старославянском.",
	"смотрит вокруг с очень глупой улыбкой, растянутой во всю ширь лица.",
	"демонстрирует свои скудные танцевальные навыки парой кривых движений.",
	"выкрикивает что-то про Красную Линию и политику  Рейха, но что конкретно - Вам не понятно.",
	"распевает шуточные песни о ваське и грибах.",
	"оглядывается вокруг с эротическим взглядом и кривой кокетливой улыбкой."
}

local playerMeta = FindMetaTable("Player")

function playerMeta:MakeQualityFood(attrib_id)
	local skill = self:GetCharacter():GetAttribute(attrib_id, 0)
	local qcap = 100 / #COOKLEVEL
	local chancedice = math.Clamp(skill*boost.base + math.random(1, 100) * (skill/ix.config.Get("maxAttributes", 100)*boost.chance), 0, 100)
	local f_quality = math.Clamp(math.abs(math.floor(chancedice/qcap) ), 1, #COOKLEVEL)
	local exp = (1-(f_quality/#COOKLEVEL))*boost.exp

	self:GetCharacter():UpdateAttrib(attrib_id, 15)
	
	return f_quality
end

--[[ Hunger ]]
function playerMeta:SetHungerVar(amount)
	self:SetNetVar(HUNGER_ID, amount or CurTime(), self)
end
function playerMeta:AddHungerVar(amount)
	local curHunger = CurTime() - self:GetHungerVar()
	local config = ix.config.Get("hungrySeconds", 1100)
	
	amount = math.Clamp((amount / 100) * config, -config, config)
	
	self:SetHungerVar(CurTime() - math.Clamp(math.min(curHunger, config) - amount, 0, config))
end

--[[ Thirst ]]
function playerMeta:SetThirstVar(amount)
	self:SetNetVar(THIRST_ID, amount or CurTime(), self)
end

function playerMeta:AddThirstVar(amount)
	local curThirst = CurTime() - self:GetThirstVar()
	local config = ix.config.Get("thirstySeconds", 3000)

	amount = math.Clamp((amount / 100) * config, -config, config)

	self:SetThirstVar(CurTime() - math.Clamp(math.min(curThirst, config) - amount, 0, config))
end

--[[ Drunk ]]
function playerMeta:SetDrunkVar(amount)
	self:SetNetVar(DRUNK_ID, amount, self)
end

function playerMeta:AddDrunkVar(amount)
	local curDrunk = math.max(self:GetDrunkVar() - CurTime(), 0)
	local config = ix.config.Get("drunkySeconds", 200)
	
	amount = math.Clamp((amount / 100) * config, -config, config)
	
	self:SetDrunkVar(CurTime() + math.Clamp(math.min(curDrunk, config) + amount, 0, config))
end

function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()
	
	local savedVar = math.Clamp(CurTime() - client:GetHungerVar(), 0, ix.config.Get("hungrySeconds", 1100))
	character:SetData(HUNGER_ID, savedVar)
	
	if (client:GetDrunkVar() ~= 0) then
		savedVar = math.Clamp(client:GetDrunkVar() - CurTime(), 0, ix.config.Get("drunkySeconds", 200))
		character:SetData(DRUNK_ID, savedVar)
	end
	
	savedVar = math.Clamp(CurTime() - client:GetThirstVar(), 0, ix.config.Get("thirstySeconds", 3000))
	character:SetData(THIRST_ID, savedVar)
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	if (character:GetData(HUNGER_ID)) then
		client:SetHungerVar(CurTime() - character:GetData(HUNGER_ID))
	else
		client:SetHungerVar()
	end
	
	if (character:GetData(DRUNK_ID)) then
		client:SetDrunkVar(CurTime() + character:GetData(DRUNK_ID))
	else
		client:SetDrunkVar(nil)
	end
	
	if (character:GetData(THIRST_ID)) then
		client:SetThirstVar(CurTime() - character:GetData(THIRST_ID))
	else
		client:SetThirstVar()
	end
end

function PLUGIN:PlayerDeath(client)
	client.refillHungerSys = true
end

function PLUGIN:PlayerSpawn(client)
	if (client.refillHungerSys) then
		client:SetHungerVar()
		client:SetThirstVar()
		client:SetDrunkVar(nil)

		client.refillHungerSys = nil
	end
end
local hungerTime, drunkTime, thirstTime = CurTime(), CurTime(), CurTime()
function PLUGIN:PlayerPostThink(client)
	if (hungerTime < CurTime()) then
		local percent = (1 - client:GetHungerPercent())
		
		if (client:Alive() and (percent <= 0 and (1 - client:GetThirstPercent()) <= 0)) then
			client:Kill()
			thirstTime = CurTime() + ix.config.Get("thirstTime", 7)
			return
		end

		if (percent <= 0) then
			if (client:Alive() and client:Health() <= 0) then
				client:Kill()
			else
				client:SetHealth(math.Clamp(client:Health() - 1, 0, client:GetMaxHealth()))
			end
		end

		hungerTime = CurTime() + ix.config.Get("hungerTime", 30)
	end
	
	if (thirstTime < CurTime()) then
		local percent = (1 - client:GetThirstPercent())
		
		if (client:Alive() and (percent <= 0 and (1 - client:GetHungerPercent()) <= 0)) then
			client:Kill()
			thirstTime = CurTime() + ix.config.Get("thirstTime", 7)
			return
		end

		if (percent <= 0) then
			if (client:Alive() and client:Health() <= 0) then
				client:Kill()
			else
				client:SetHealth(math.Clamp(client:Health() - 1, 0, client:GetMaxHealth()))
			end
		end

		thirstTime = CurTime() + ix.config.Get("thirstTime", 7)
	end
	
	if ((client.nextDrunk or 0) < CurTime() and not IsValid(client.ixRagdoll) and client:GetDrunkVar(true) > 30) then
		if math.random(1, 2) == 1 then
			ix.chat.Send(client, "me", Drunk.Emotes[math.random(#Drunk.Emotes)])
		else
			--hook.Run("PlayerSay", client, Drunk.Say[math.random(#Drunk.Say)])
			ix.chat.Send(client, "ic", Drunk.Say[math.random(#Drunk.Say)])
		end
		
		client.nextDrunk = CurTime() + math.random(30, 60)
	end
	
	if (drunkTime < CurTime()) then
		if (IsValid(client) and client:Alive() and not IsValid(client.ixRagdoll)) then
			local percent = client:GetDrunkVar(true)
			if (percent >= 90) then
				client:SetRagdolled(true, math.random(30, 180) + percent)
			end
			percent = nil
		end
		
		drunkTime = CurTime() + 1
	end
end