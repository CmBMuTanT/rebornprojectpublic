local PLUGIN = PLUGIN

include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

local garbageModels = {
	Model("models/props_junk/garbage128_composite001a.mdl"),
	Model("models/props_junk/garbage128_composite001b.mdl"),
	Model("models/props_junk/TrashCluster01a.mdl"),
	Model("models/props_junk/garbage128_composite001d.mdl")
}

function ENT:Initialize()
	self:SetModel(table.Random(garbageModels))
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(MOVETYPE_NONE)
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(120)
		phys:Sleep()
	end
	
	self:SetSpawnType(1)
end

function ENT:SetSpawnType(entType)
	if (entType == TYPE_WATERCAN or entType == TYPE_SUPPLIES) then
		self:SetDTInt(1, entType)
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

function ENT:OnFailed(client, reason)
	client:SetAction()

	if reason then
		client:NotifyLocalized(reason)
	end

	client.ixTrash = nil
	self.searching = nil
end

function ENT:OnSuccess(client)
	local character = client:GetCharacter()
	local chance = ix.config.Get("Trash Search Chance", 30)
	local maxItems = ix.config.Get("Trash Search Max Items", 3)
	local multiplier = ix.config.Get("Trash Search Multiplier", 0.75)

	if math.Rand(0, 100) <= chance then
		local itemCount = math.Clamp(math.ceil(math.Rand(0, maxItems * multiplier)), 1, maxItems)

		for i = 1, itemCount do 
			local itemID = table.Random(PLUGIN.lootTable)
			local item = ix.item.Get(itemID)

			if item then
				if !character:GetInventory():Add(itemID) then
					ix.item.Spawn(itemID, client)
				end
				
				client:NotifyLocalized("Вы нашли: " ..string.utf8lower(item.name))
			end
		end
	else
		client:NotifyLocalized("Вам ничего не удалось найти.")
	end

	client.ixTrash = nil
	self.searching = nil
	
	SafeRemoveEntity(self)
end

function ENT:Use(client)
	if client.ixTrash or self.searching then
		return
	end

	if self.nextUse and CurTime() < self.nextUse then
		return
	end

	self.nextUse = CurTime() + 0.5

	if client:IsRestricted() then
		return
	end

	if !client:Crouching() then
		client:NotifyLocalized("Вы должны присесть чтобы начать рыться в мусоре.")
		return
	end

	self.searching = client
	client.ixTrash = self

	local cleantime = ix.config.Get("Trash Search Time", 10)
	client:SetAction("Вы роетесь в мусоре...", cleantime)

	local uniqueID = "ixTrashSearch"..client:UniqueID()
	local data = {}
	data.filter = client
	timer.Create(uniqueID, 0.1, cleantime / 0.1, function()
		if (IsValid(client) and IsValid(self)) then
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96

			if (util.TraceLine(data).Entity != self or client:IsRestricted() or client:GetVelocity():LengthSqr() > 0) then
				timer.Remove(uniqueID)

				self:OnFailed(client)
			elseif !client:Crouching() then
				timer.Remove(uniqueID)

				self:OnFailed(client, "Вы должны присесть чтобы начать рыться в мусоре.")
			elseif (timer.RepsLeft(uniqueID) == 0) then
				self:OnSuccess(client)
			end
		else
			timer.Remove(uniqueID)

			self:OnFailed(client, "Мусор был убран до того как вы успели его собрать.")
		end
	end)
end

function ENT:CanTool(player, trace, tool)
	return false
end