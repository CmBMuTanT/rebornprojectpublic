local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    
	self:SetModel("models/devcon/mrp/act/bandit_light_2.mdl")

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

function ENT:Use(activator, caller)
   netstream.Start(activator, "Obmen:OpenMenu", PLUGIN.TempItemsToTrade)
end
