local PLUGIN = PLUGIN

AddCSLuaFile()

ENT.Base             = "base_gmodentity"
ENT.Type             = "anim"
ENT.PrintName        = "Loot Cabinet"
ENT.Author            = "Riggs"
ENT.Purpose            = "Allows you to take loot from it."
ENT.Instructions    = "Press E"
ENT.Category         = "LOCKPICK LOOT"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

if ( SERVER ) then
    function ENT:Initialize()
        self:SetModel("models/props_wasteland/controlroom_filecabinet001a.mdl")
        self:PhysicsInit(SOLID_VPHYSICS) 
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableMotion(false)
        end
    end

    function ENT:SpawnFunction(ply, trace)
        local angles = ply:GetAngles()

        local entity = ents.Create("ix_loot_filecabinet")
        entity:SetPos(trace.HitPos)
        entity:SetAngles(Angle(0, (entity:GetPos() - ply:GetPos()):Angle().y - 180, 0))
        entity:Spawn()
        entity:Activate()

        return entity
    end
    
    function ENT:OnTakeDamage()
        return false
    end
    
    function ENT:AcceptInput(Name, Activator, Caller)
        if (Name == "Use" and Caller:IsPlayer()) then
            --PLUGIN:SearchLootContainer(self, Caller)
            local character = Activator:GetCharacter()
            local inv = character:GetInventory()
            local item = inv:HasItem("hairpin")

            if !item then Activator:Notify("Вам необходима шпилька для взлома!") return end

            local lockpickAngle = self:GetNWInt("LockPick_Angle") or 0
            local lockDifficulty = self:GetNWInt("Berkark_LockDifficulty")

            self:SetNWInt("LockPick_Angle", math.random(-90, 90)) -- всегда разные значения оставим
            self:SetNWString("Berkark_LockDifficulty", 1)


            Activator.LastTargetLockPickDoor = self

            net.Start("SendLockAngleToClient")
            net.Send(Activator)

            Activator:ConCommand("+duck")
        end
    end
end