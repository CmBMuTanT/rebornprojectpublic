
-------------------------------
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
-------------------------------
ENT.Speed = 500
ENT.PlyEnt = nil
ENT.Damage = 0
ENT.Gravity = -5

----------------
-- Initialize --
----------------
function ENT:Initialize()
	
	self.Entity:SetModel( "models/redux/weapons/pipebomp.mdl" )
	self.Entity:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self.Entity:SetMoveType( MOVETYPE_FLYGRAVITY )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	
	self.Entity:GetPhysicsObject():SetMass(25)

	self.Entity:DrawShadow(false)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:EnableGravity(false)
		phys:Wake()
	end
	
	--self.FlyDir = self:GetAngles():Forward()
	--self:GetPhysicsObject():SetVelocity(self:GetAngles():Forward()*self.Speed)
	--self.Entity:SetModel( "models/crossbow_bolt.mdl" )
end

function ENT:Explode()

	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetPos() )
	util.Effect( "Explosion", effectdata, true, true )
		
	util.BlastDamage( self, self, self:GetPos(), 130, 65 )
	self:Remove()
	
end

function ENT:PhysicsCollide(data, physobj)

	if data.HitEntity != self.PlyEnt then
		local dmginfo = DamageInfo()
		local attacker = self.PlyEnt
		if !IsValid(attacker) then attacker = self end
		
		self:Explode()

	end

end

function ENT:PhysicsUpdate( phys )
	local phys = self:GetPhysicsObject()
	phys:ApplyForceCenter( Vector( 0, 0, phys:GetMass()*self.Gravity ) )
end

function ENT:Think()
	--self:GetPhysicsObject():SetVelocity(self.FlyDir*self.Speed)
	--self:SetPos(self:GetPos()+self:GetForward()*self.Speed*FrameTime())
end
------------
-- On use --
------------
function ENT:Use( activator, caller )
	local ply = activator
end
