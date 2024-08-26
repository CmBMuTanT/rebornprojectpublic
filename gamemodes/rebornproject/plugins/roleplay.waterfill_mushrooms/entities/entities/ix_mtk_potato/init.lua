local PLUGIN = PLUGIN

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:Initialize() 
    self:SetModel( "models/fallout 3/beans.mdl" )
    --self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    
    if (phys:IsValid()) then
        phys:Wake()
    end

    self:SetModelScale(0.6)
end

  function ENT:Use(activator)
        activator:PerformInteraction(ix.config.Get("itemPickupTime", 0.5), self, function(client)
            if self:GetModelScale() < 1 then return false end

            self:EmitSound("npc/barnacle/barnacle_crunch"..math.random(2, 3)..".wav")
            client:GetCharacter():GetInventory():Add("potato")
            self:Remove()
            return false
        end)
 end

    function ENT:Think()
        if !self:GetWatered() then return end
        local targetScale = 1
        local scale = self:GetModelScale()
        local time = CurTime()
        local speed = 0.01 / 1 -- 5 минут = 300
    
        scale = math.Approach(scale, targetScale, speed)
        self:SetModelScale(scale)
    
        if scale >= targetScale then return end
        self:NextThink(time + 4.5)
        return true
  end