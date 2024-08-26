
function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Refract = 0
	self.Forward = data:GetNormal()
	if !self.WeaponEnt or !IsValid(self.WeaponEnt) then return end
	local owner = self.WeaponEnt.Owner
	if !owner or !IsValid(owner) or !owner:Alive() then return end
	local visible = !owner:ShouldDrawLocalPlayer()
	local smokepos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	local emitter = ParticleEmitter(smokepos)

		local dynlight = DynamicLight(self:EntIndex())
		dynlight.Pos = self.Position
		dynlight.Size = 128
		dynlight.Decay = 4000
		dynlight.R = 150
		dynlight.G = 180
		dynlight.B = 255
		dynlight.Brightness = 4
		dynlight.DieTime = CurTime() + 0.01
	
			--[[for i = 1, 2 do
				local particle = emitter:Add( "effects/smoke/smoke_particle_"..math.Rand(1, 5), smokepos )
					particle:SetVelocity( 120 * i * data:GetNormal() + 50 * VectorRand() )
					particle:SetAirResistance( 400 )
					particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
					particle:SetDieTime( math.Rand( 3, 4 ) )
					particle:SetStartAlpha( math.Rand( 1, 6 ) )
					particle:SetEndAlpha( 0 )
					
					particle:SetStartSize(6)
					particle:SetEndSize(64)
					
					particle:SetRoll( math.Rand( 0, 1 ) )
					particle:SetRollDelta( 0.1 )
			end]]--
		
		for i = 1, 3 do
			local particle = emitter:Add( "particle/particle_glow_02", smokepos )
				particle:SetVelocity( Vector(0,0,0) )
				particle:SetAirResistance( 400 )
				--particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
				particle:SetDieTime( 0.05 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(1)
				particle:SetEndSize(math.Rand( 10, 30 ))
				particle:SetRoll( math.Rand( 0, 180 ) )
				particle:SetRollDelta( math.Rand( 0, 0 ) )
				
		end
		
		for i = 1, 3 do
			local particle = emitter:Add( "particle/particle_glow_03_additive", smokepos )
				particle:SetVelocity( owner:EyeAngles():Forward()*5 )
				particle:SetAirResistance( 400 )
				--particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
				particle:SetDieTime( 0.05 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(math.Rand( 30, 50 ))
				particle:SetEndSize(1)
				particle:SetRoll( 0 )
				particle:SetRollDelta( 0 )
				particle:SetStartLength(10)
				particle:SetEndLength(math.Rand( 150, 170 ))
				
		end

		local particle = emitter:Add( "particle/particle_glow_03_additive", smokepos )
			particle:SetVelocity( owner:EyeAngles():Forward()*400 )
			particle:SetAirResistance( 100 )
			--particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
			particle:SetDieTime( 0.15 )
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize(10)
			particle:SetEndSize(1)
			particle:SetRoll( 0 )
			particle:SetRollDelta( 0 )
			particle:SetStartLength(10)
			particle:SetEndLength(100)
		
		for i = 1, 15 do
			local particle = emitter:Add( "effects/spark", smokepos )
				particle:SetVelocity( 15 * VectorRand()+ (owner:EyeAngles():Forward()*500) )
				particle:SetAirResistance( 0 )
				particle:SetGravity( (math.Rand( 100, 400 ) * VectorRand()) )
				particle:SetDieTime( 0.3 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(5)
				particle:SetEndSize(0)
				particle:SetStartLength(1)
				particle:SetEndLength(math.Rand( 2, 4 ))
				--particle:SetRoll( math.Rand( 0, 180 ) )
				--particle:SetRollDelta( math.Rand( 0, 0 ) )
				particle:SetColor( 150, 180, 255 )
		end
			
	emitter:Finish()
end

function EFFECT:Think()
	self.Refract = self.Refract + FrameTime()
	if not IsValid(self.WeaponEnt) or self.WeaponEnt == nil or !self.WeaponEnt:GetOwner():Alive() then
		self:Remove()
	end
	if self.Refract >= 0.3 then return false end
	return true
end

function EFFECT:Render()

	if self.WeaponEnt == nil then self:Remove() end
	local owner = self.WeaponEnt:GetOwner()
	if !owner:Alive() then self:Remove() end
	local visible = !owner:ShouldDrawLocalPlayer()
	local Muzzle = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	if !self.WeaponEnt or !IsValid(self.WeaponEnt) or !Muzzle then return end
	
end
