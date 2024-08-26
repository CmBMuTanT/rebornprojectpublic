local PLUGIN = PLUGIN

include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

util.AddNetworkString("Openchatter")

function ENT:Initialize()

	self:SetModel( "models/metro_redux/other_exodus/radio_station.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )     
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(120)
		phys:Wake()
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

function ENT:OnFailed(client, reason)

end

function ENT:OnSuccess(client)
end

function ENT:Use(client)
	if self.nextUse and CurTime() < self.nextUse then
		return
	end

	self.nextUse = CurTime() + 0.5


	net.Start("Openchatter")
		net.WriteEntity(client)
	net.Send(client)
	
	return
end

function ENT:CanTool(player, trace, tool)
	return false
end