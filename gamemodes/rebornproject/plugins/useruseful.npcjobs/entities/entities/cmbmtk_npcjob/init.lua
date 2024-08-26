local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    
	self:SetModel("models/devcon/mrp/act/bandit_veteran.mdl")

    self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:DropToFloor()
	self:SetMoveType( MOVETYPE_NONE )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:SetUseType( SIMPLE_USE )

    local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end
end

local playerCooldowns = {}
local lastUsedTime = 0

local RandomItems = {
	["ammo_762x51"] = 15, -- uID предмета, шанс предмета
	["ammo_545x39"] = 25,
	["ammo_pistol"] = 25,
	["ammo_1270"] = 15,
	["canfood_conserve2"] = 10,
	["gasmaskfilter"] = 10,
	["binto2"] = 10,
}

local function ChooseRandomItem() -- функция вероятности
	local totalWeight = 0
	for item, weight in pairs(RandomItems) do
		totalWeight = totalWeight + weight
	end

	local randomNumber = math.random(1, totalWeight)
	local currentItem = nil

	for item, weight in pairs(RandomItems) do
		randomNumber = randomNumber - weight
		if randomNumber <= 0 then
			currentItem = item
			break
		end
	end

	return currentItem
end


function ENT:Use(activator, caller)
    local playerId = activator:UserID()
    local currentTime = CurTime()
	local character = activator:GetCharacter()
	local CharID = character:GetID()
	local AmoutWork = ix.config.Get("Amout of Work", 3)
	local CoolDown = ix.config.Get("Work Cooldown", 10)
	local progress = PLUGIN.WorkProgress
	
	if lastUsedTime + 5 > currentTime then return end
	lastUsedTime = currentTime

	if progress[CharID] then 
		if progress[CharID] >= AmoutWork then
			--local rand = math.random(ix.config.Get("PayMin", 1), ix.config.Get("PayMax", 7))  --денег больше не выдаем
			progress[CharID] = nil

			--activator:GetCharacter():GiveMoney(rand) --денег больше не выдаем

			--- выдаем айтем теперь
				local chosenItem = ChooseRandomItem()
				activator:Notify("Спасибо за работу! Держи: "..ix.item.Get(chosenItem).name)
				if !character:GetInventory():Add(chosenItem) then
					ix.item.Spawn(chosenItem, client)
				end
			---

			 if character:GetData("HasJob", false) == "garbage" then
				activator:StripWeapon("broom") -- сюда оружие швабры
			 end
			character:SetData("HasJob", false)
			activator:SetNetVar("HasJob", false)
			activator:SetNetVar("WorkTempProgress", 0)
			return
		end
	end

    if not playerCooldowns[playerId] or playerCooldowns[playerId] + CoolDown < currentTime and character:GetData("HasJob", false) == false then
		local plyrandomwork = PLUGIN.Works[math.random(#PLUGIN.Works)]
        self:EmitSound("trader/voice_2/trader_money_yes_1.mp3")
        playerCooldowns[playerId] = currentTime
		character:SetData("HasJob", plyrandomwork)
		activator:SetNetVar("HasJob", plyrandomwork)
		activator:Notify("Твоя задача это: "..plyrandomwork.." Как закончишь с ней, приходи ко мне обратно я выдам тебе зарплату.")

		 if plyrandomwork == "garbage" then
		 	activator:Give("broom") -- сюда оружие швабры
		 end
    else
		activator:Notify("У меня нет для тебя работы на данный момент.")
        self:EmitSound("trader/voice_2/trader_limit_5.mp3")
    end
end


hook.Add("PlayerDisconnected", "ClearCooldownOnDisconnect", function(player)
    playerCooldowns[player:UserID()] = nil
end)