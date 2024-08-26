AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

ENT.Damage = 10

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" )
	//self.Entity:PhysicsInit( SOLID_NONE ) 
	self.Entity:SetMoveType( MOVETYPE_NONE ) 
	self.Entity:SetSolid( SOLID_NONE )
	
	self.Entity:SetKeyValue("rendercolor", "150 255 150") 
	self.Entity:SetKeyValue("renderamt", "0") 
	self.Entity:DrawShadow(false)
	
	self.DustSize = 200
	self.DustChange = 0
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Think()
   for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 1400 ) ) do	
		
		if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 1300 ) then
		 local dir = v:GetPos() - self:GetPos()
   
		  v:SetVelocity(dir * -0.01)

	if(self.DustChange < CurTime() )then
       self.DustChange = CurTime() + 1.6
      self.DustSize = self.DustSize + 5

		local shake = ents.Create("env_shake")
		shake:SetKeyValue("duration", 3)
		shake:SetKeyValue("amplitude", 6)
		shake:SetKeyValue("radius", 1400) 
		shake:SetKeyValue("frequency", 800)
		shake:SetPos(self.Entity:GetPos())
		shake:Spawn()
		shake:Fire("StartShake","","0.6") 
        shake:Fire("kill", "", 1)
		
	local hurt = ents.Create( "point_hurt" )
	hurt:SetKeyValue("targetname", "pointhurt" ) 
	hurt:SetKeyValue("DamageRadius", 1400 )
	hurt:SetKeyValue("Damage",  0 )
	hurt:SetKeyValue("DamageDelay", 90000000000000000000 )
	hurt:SetKeyValue("DamageType", "CHEMICAL" )
	hurt:SetPos( self.Entity:GetPos() )
	hurt:Spawn()
	hurt:Fire("turnon", "", 0)
	hurt:Fire("turnoff", "", 1)
	hurt:Fire("kill", "", 0)
	end
end
end
end