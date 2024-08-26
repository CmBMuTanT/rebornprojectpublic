AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Spawnable = true
ENT.AdminOnly = false

ENT.Author	= "Dobytchick"
ENT.PrintName = "Лутбоксик"
ENT.Category = "metro"

if SERVER then
	function ENT:Initialize()
		self.random_res = ITEM_SPAWN.VIEWS[math.random(1, #ITEM_SPAWN.VIEWS)]

		self:SetModel(self.random_res.model)	
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local physobj = self:GetPhysicsObject()

		if (IsValid(physobj)) then
			physobj:EnableMotion(false)
			physobj:Sleep()
		end

		local inventory = ix.inventory.Create(self.random_res.inv_w, self.random_res.inv_h, self:EntIndex())
		inventory.noSave = true
		self.ixInventory = inventory

		for i=1,math.random(ITEM_SPAWN.MIN_COUNT, ITEM_SPAWN.MAX_COUNT) do
			inventory:Add(ITEM_SPAWN.ITEM_LIST[math.random(1, #ITEM_SPAWN.ITEM_LIST)])
		end
	end

	function ENT:Use(activator)

		local character = activator:GetCharacter()
		local inv = character:GetInventory()
		local item = inv:HasItem("hairpin")

		if !item then activator:Notify("Вам необходима шпилька для взлома!") return end

		local lockpickAngle = self:GetNWInt("LockPick_Angle") or 0
		local lockDifficulty = self:GetNWInt("Berkark_LockDifficulty")

		self:SetNWInt("LockPick_Angle", math.random(-90, 90)) -- всегда разные значения оставим
		self:SetNWString("Berkark_LockDifficulty", 1)

		-- if not lockDifficulty then 
		-- 	lockDifficulty = table.Random(table.GetKeys(SKYRIM_LOCKPICKING.Difficulties))
		-- 	print(lockDifficulty)
		-- 	self:SetNWString("Berkark_LockDifficulty", lockDifficulty)
		-- end

		activator.LastTargetLockPickDoor = self

		net.Start("SendLockAngleToClient")

		net.Send(activator)

		activator:ConCommand("+duck")
	end
end