
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
	
	self.Entity:SetModel( "models/attachments/other/arrow/w_arrow.mdl" )
	self.Entity:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self.Entity:SetMoveType( MOVETYPE_FLYGRAVITY )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	
	self.Entity:GetPhysicsObject():SetMass(10)

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

function ENT:PhysicsCollide(data, physobj)

	if data.HitEntity != self.PlyEnt then
	
		local dmginfo = DamageInfo()
		local attacker = self.PlyEnt
		if !IsValid(attacker) then attacker = self end
		dmginfo:SetAttacker(attacker)
		dmginfo:SetInflictor(self.Entity)
		dmginfo:SetDamageType(DMG_CLUB)
		dmginfo:SetDamage(self.Damage)
		dmginfo:SetDamageForce(self.Entity:GetForward()*12)
		dmginfo:SetDamagePosition(data.HitPos)
		data.HitEntity:TakeDamageInfo(dmginfo)
				
		if data.HitEntity:IsNPC() or data.HitEntity:IsPlayer() then
			self.Entity:EmitSound("weapons/arrow/flesh_1.wav")
		end
		
		if not data.HitEntity:IsWorld() then
			self.Entity:Remove()
		end
		
	end

end

ENT.Hit = false

function ENT:PhysicsUpdate( phys )

	local phys = self:GetPhysicsObject()
	phys:ApplyForceCenter( Vector( 0, 0, phys:GetMass()*self.Gravity ) )
	
	if !self.Hit then
		local tr = util.QuickTrace(self.Entity:GetPos(), self.Entity:GetForward()*45, self)
		
		if tr.Entity:IsWorld() then
			phys:EnableMotion(false)
			self.Entity:SetPos(tr.HitPos)
			
			self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			
			--local fx = EffectData()
			--fx:SetOrigin(tr.HitPos)
			--fx:SetNormal(tr.HitNormal)
			--fx:SetRadius(52)
			
			--util.Effect("StunstickImpact", fx)
			
			self:EmitSound("weapons/arrow/arrow_generic_"..math.Round(math.Rand(1, 3))..".wav")
			self.Hit = true
		end
	end
	
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
	if self.Hit then
		if !ply:IsPlayer() then return end
		ply:GiveAmmo( 1, "metro_arrow", false )
		self.Entity:Remove()
	end
end
