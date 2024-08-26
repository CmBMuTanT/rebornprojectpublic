local PLUGIN = PLUGIN

include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/sawblade001a.mdl")
	self:SetNoDraw(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(MOVETYPE_NONE)
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Sleep()
	end

	local uniqueID = "ixTrashSpawner"..self:EntIndex()
	timer.Create(uniqueID, 1, 0, function()
		if !IsValid(self) then
			timer.Remove(uniqueID)
			return
		end

		self:RespawnTick()
	end)
end

function ENT:SpawnFunction(client, trace)
	if !trace.Hit then return end

	local SpawnPos = trace.HitPos
	local SpawnAng = (SpawnPos - (SpawnPos + trace.HitNormal)):Angle()
	SpawnAng:RotateAroundAxis(SpawnAng:Right(), 90)
	SpawnAng:RotateAroundAxis(SpawnAng:Up(), client:EyeAngles().y)
	
	local ent = ents.Create("ix_trashspawner")
	ent:SetPos(SpawnPos)
	ent:SetAngles(SpawnAng)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:SpawnTrash()
	if IsValid(self.trash) then
		self.trash:RemoveCallOnRemove("NextTrashSpawn")
		self.trash:Remove()
		self.trash = nil
	end

	local trash = ents.Create("ix_garbage")
	trash:SetAngles(self:GetAngles())
	trash:Spawn()
	trash:Activate()
	
	local max = trash:OBBMaxs()
	trash:SetPos(self:GetPos() + Vector(0, 0, max.z * 0.5))
	
	trash.spawner = self
	trash:CallOnRemove("NextTrashSpawn", function(this) 
		local offset = math.random(0, ix.config.Get("Trash Spawner Respawn Variation", 30))
		local time = ix.config.Get("Trash Spawner Respawn Time", 60) + offset
		

		this.spawner:SetNetVar("ixNextTrashSpawn", CurTime() + (time * 60))
	end)

	self.trash = trash
	self:SetNetVar("ixNextTrashSpawn", -1)
end

function ENT:OnRemove()
	if IsValid(self.trash) then
		self.trash:RemoveCallOnRemove("NextTrashSpawn")
		self.trash:Remove()
		self.trash = nil
	end

	timer.Remove("ixTrashSpawner"..self:EntIndex())
end

function ENT:RespawnTick()
	if IsValid(self.trash) then
		return
	end

	local time = self:GetNetVar("ixNextTrashSpawn", 0)

	if (time > 0 and CurTime() >= time) or time <= 0 then
		self:SpawnTrash()
	end
end