
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.DontDamageNpcs = {
"npc_zombie"
}

function ENT:Initialize()
	self.Entity:SetModel( "models/props_lab/jar01b.mdl" )
	self.Entity:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:GetPhysicsObject():SetMass(5)
	self.Entity:GetPhysicsObject():SetDragCoefficient( 0)
	self.Entity:DrawShadow(false)

	local phys = self.Entity:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end

end

function ENT:SetEntityOwner(ent)
	self:SetOwner(ent)
	self.entOwner = ent
end

function ENT:PhysicsCollide(data, physobj)
	return true
end

function ENT:OnRemove()

end


function ENT:Think()
	local entes = ents.GetAll()
			local d = DamageInfo()
			d:SetDamage( math.random(0.5, 1) )
			d:SetAttacker( self.Entity )
			d:SetDamageType( DMG_RADIATION )
	for k, v in pairs(entes) do
		if v:GetPos().z >= self.Entity:GetPos().z-50 and !table.HasValue( self.DontDamageNpcs, v:GetClass() ) then
			if v:IsPlayer() or v:IsNPC() then
				v:TakeDamageInfo( d )
			end
		end
	end
end


