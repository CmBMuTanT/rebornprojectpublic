
function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Refract = 0
	self.Forward = data:GetNormal()

	self.ShellForwardMod = 12
    
	if not IsValid(self.WeaponEnt) then return end
	local owner = self.WeaponEnt.Owner
	if !owner or !IsValid(owner) or !owner:Alive() then return end
	local visible = !owner:ShouldDrawLocalPlayer()
	local smokepos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	local emitter = ParticleEmitter(smokepos)

	if self.WeaponEnt.ShellForwardMod != nil then
		self.ShellForwardMod = self.ShellForwardMod + self.WeaponEnt.ShellForwardMod 
	end

	local dynlight = DynamicLight(self:EntIndex())
	dynlight.Pos = self.Position
	dynlight.Size = 128
	dynlight.Decay = 4000
	dynlight.R = 255
	dynlight.G = 180
	dynlight.B = 50
	dynlight.Brightness = 4
	dynlight.DieTime = CurTime() + 0.01
	
	
		for i = 1, 2 do
			local particle = emitter:Add( "effects/smoke/smoke_particle_"..math.Rand(1, 5), smokepos )
				particle:SetVelocity( 1600*self.Forward + 50 * VectorRand() )
				particle:SetAirResistance( 400 )
				particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
				particle:SetDieTime( math.Rand( 3, 4 ) )
				particle:SetStartAlpha( math.Rand( 1, 6 ) )
				particle:SetEndAlpha( 0 )
				
				particle:SetStartSize(6)
				particle:SetEndSize(64)
				
				particle:SetRoll( math.Rand( 0, 1 ) )
				particle:SetRollDelta( 0.1 )
		end
		
		for i = 1, 3 do
			local particle = emitter:Add( "sprites/flamelet"..math.Rand(1, 5), smokepos+self.Forward*20  )
				particle:SetVelocity( 800*self.Forward )
				particle:SetAirResistance( 40 )
				--particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
				particle:SetDieTime( 0.3 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(0)
				particle:SetEndSize(math.Rand( 20, 40 ))
				particle:SetRoll( math.Rand( 0, 180 ) )
				particle:SetRollDelta( math.Rand( -3, 3 ) )
				particle:SetCollide( true )
				--particle:SetColor( 128,128, 128 )
		end

		for i = 1, 3 do
			local particle = emitter:Add( "effects/muzzleflash3", smokepos+self.Forward*30  )
				particle:SetVelocity( 600*self.Forward )
				particle:SetAirResistance( 40 )
				--particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
				particle:SetDieTime( 0.35 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(0)
				particle:SetEndSize(math.Rand( 40, 50 ))
				particle:SetRoll( math.Rand( 0, 180 ) )
				particle:SetRollDelta( math.Rand( -3, 3 ) )
				particle:SetCollide( true )
		end

		for i = 1, 3 do
			local particle = emitter:Add( "sprites/flamelet"..math.Rand(1, 5), smokepos+self.Forward*10 )
				particle:SetVelocity( 700*self.Forward )
				particle:SetAirResistance( 40 )
				--particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
				particle:SetDieTime( 0.3 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(20)
				particle:SetEndSize(0)
				particle:SetRoll( math.Rand( 0, 180 ) )
				particle:SetRollDelta( math.Rand( 0, 0 ) )
				--particle:SetCollide( true )
				particle:SetStartLength(100)
				particle:SetEndLength(50)
				--particle:SetColor( 128,128, 128 )
		end
		
		for i = 1, 2 do
			local particle = emitter:Add( "effects/spark", smokepos+VectorRand()*2 )
				particle:SetVelocity( 600*self.Forward  )
				particle:SetAirResistance( 100 )
				particle:SetGravity( 200 * VectorRand() )
				particle:SetDieTime( 1 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(3)
				particle:SetEndSize(0)
				particle:SetStartLength(3)
				particle:SetEndLength(5)
				particle:SetBounce(2)
				--particle:SetRoll( math.Rand( 0, 180 ) )
				--particle:SetRollDelta( math.Rand( 0, 0 ) )
				--particle:SetColor( 252, 150, 3 )
		end

		for i = 1, 5 do
			local particle = emitter:Add( "sprites/light_glow02_add_noz", smokepos+self.Forward*-40 )
				particle:SetVelocity( 100*self.Forward  )
				particle:SetAirResistance( 200 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(30)
				particle:SetEndSize(0)
				particle:SetStartLength(150)
				particle:SetEndLength(200)
				--particle:SetRoll( math.Rand( 0, 180 ) )
				--particle:SetRollDelta( math.Rand( 0, 0 ) )
				particle:SetColor( 55, 55, 255 )
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
	local owner = self.WeaponEnt:GetOwner() or nil
	if owner != nil and !owner:Alive() then self:Remove() end
	local visible = !owner:ShouldDrawLocalPlayer()
	local Muzzle = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	if !self.WeaponEnt or !IsValid(self.WeaponEnt) or !Muzzle then return end
	
end
