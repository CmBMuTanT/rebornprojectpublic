
include('shared.lua')

function ENT:Initialize()
	
	pos = self:GetPos()

	self.emitter = ParticleEmitter( pos )
	
end

local spritemat = Material( "effects/yellowflare" )

function ENT:Draw()
	
	--if self:GetPlyEnt() != nil and LocalPlayer() != self:GetPlyEnt() then return end
	--if self.DrawModel then
		self.Entity:DrawModel()
	--else
	--	render.SetMaterial( spritemat ) 
	--	render.DrawSprite(self.Entity:GetPos(), 8, 8, Color( 255, 255, 255 ))
	--end
	
	--[[pos = self:GetPos()
	
	for i=1, 1 do
		local particle = self.emitter:Add( "particle/particle_smokegrenade", pos )
		
		//if (particle) then
			particle:SetVelocity(self:GetAngles():Forward()*-1)
			particle:SetDieTime( 1 )
			particle:SetStartAlpha( 70 )
			particle:SetEndAlpha( 0 )
			--particle:SetColor( 70, 255, 25 )
			particle:SetStartSize( 1 )
			particle:SetEndSize( 2 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-1, 1) )
			particle:SetAirResistance( 10 ) 
			--particle:SetStartLength(50)
			--particle:SetEndLength(50)
			--particle:SetCollide(true)
			--particle:SetBounce(0.1)
			--particle:SetGravity(VectorRand()* 100)
		//end
			
	end]]--
		
end
