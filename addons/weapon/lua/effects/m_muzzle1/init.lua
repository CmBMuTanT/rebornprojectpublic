
function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Refract = 0
	self.Forward = data:GetNormal()

	self.ShellForwardMod = 12

	if not IsValid(self.WeaponEnt) then return end

	local AddVel = self.WeaponEnt:GetOwner():GetVelocity()
	local owner = self.WeaponEnt.Owner
	if !owner or !IsValid(owner) or !owner:Alive() then return end
	local visible = !owner:ShouldDrawLocalPlayer()
	local smokepos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	local emitter = ParticleEmitter(smokepos)

	if self.WeaponEnt.ShellForwardMod != nil then
		self.ShellForwardMod = self.ShellForwardMod + self.WeaponEnt.ShellForwardMod 
	end


	if !self.WeaponEnt:GetSilencer() and !self.WeaponEnt.SilentByDefault then
		local dynlight = DynamicLight(self:EntIndex())
		dynlight.Pos = self.Position
		dynlight.Size = 128
		dynlight.Decay = 4000
		dynlight.R = 255
		dynlight.G = 180
		dynlight.B = 50
		dynlight.Brightness = 4
		dynlight.DieTime = CurTime() + 0.01
	end
	
			for i = 1, 2 do
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
			end
		
		if !self.WeaponEnt:GetSilencer() and !self.WeaponEnt.SilentByDefault then
			for i = 1, 3 do
				local particle = emitter:Add( "effects/fire/default_muzzle", smokepos )
					particle:SetVelocity( Vector(0,0,0) )
					particle:SetAirResistance( 400 )
					--particle:SetGravity( Vector(0, 0, math.Rand(100, 400) ) )
					particle:SetDieTime( 0.05 )
					particle:SetStartAlpha( 255 )
					particle:SetEndAlpha( 0 )
					particle:SetStartSize(1)
					particle:SetEndSize(math.Rand( 5, 20 ))
					particle:SetRoll( math.Rand( 0, 180 ) )
					particle:SetRollDelta( math.Rand( 0, 0 ) )
					--particle:SetColor( 128,128, 128 )
			end
		end
		
		for i = 1, math.Rand( 1, 3 ) do
			local particle = emitter:Add( "effects/spark", smokepos )
				particle:SetVelocity( 116 * VectorRand()  )
				particle:SetAirResistance( 200 )
				particle:SetGravity( 116 * VectorRand() )
				particle:SetDieTime( math.Rand( 0.1, 0.3 ) )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize(1)
				particle:SetEndSize(0)
				particle:SetStartLength(1)
				particle:SetEndLength(math.Rand( 1, 2 ))
				--particle:SetRoll( math.Rand( 0, 180 ) )
				--particle:SetRollDelta( math.Rand( 0, 0 ) )
				--particle:SetColor( 252, 150, 3 )
		end
		
			if self.WeaponEnt.EffectShell then
				local particle = emitter:Add( self.WeaponEnt.ShellTexture, smokepos+owner:EyeAngles():Forward()*-self.ShellForwardMod )
				particle:SetVelocity( 600 * owner:EyeAngles():Right() + 50 * VectorRand() )
				--particle:SetAirResistance( 0 )
				particle:SetGravity( Vector(0, 0, -600 ) )
				particle:SetDieTime( 0.6 )
				particle:SetStartAlpha( 255 )
				--particle:SetEndAlpha( 0 )
					
				particle:SetStartSize(4)
				particle:SetEndSize(4)
				
				particle:SetCollide(true)
				
				particle:SetBounce(0.2)
				particle:SetRoll( math.Rand( 0, 180 ) )
				particle:SetRollDelta( math.Rand( 0, 0 ) )
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
