
SWEP.PrintName		= "Нож"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/metro_knife/v_metro_knife.mdl"
SWEP.WorldModel		= "models/metro_redux/other_exodus/knife_metro.mdl"

SWEP.HoldType		= "knife"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.DrawCrosshair = false

SWEP.DrawAmmo = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Primary.Sound = "weapons/iceaxe/iceaxe_swing1.wav"

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:SetupDataTables()

	self:NetworkVar( "Bool", 1, "Holster" )
	self:NetworkVar( "Float", 1, "HolsterDelay" )
	
	self:SetHolster( false )
	self:SetHolsterDelay( 0 )
	
end

function SWEP:Deploy()

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon:SequenceDuration())
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Weapon:SequenceDuration())
	self.idledelay = CurTime() + self.Weapon:SequenceDuration()
	
	--self:EmitSound("deusex_weapons/GEPGunSelect.wav", 100, 100)
	
	self:SetHoldType( self.HoldType )
	
	self:SetHolster(false)
	
	return true
end

function SWEP:PrimaryAttack()

	if !self:CanPrimaryAttack() then return end

	self:EmitSound(Sound(self.Primary.Sound))
	
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self.melee_delay = CurTime() + self.Weapon:SequenceDuration()*0.2
	self.melee_striking = true
	
	self.Owner:ViewPunch( Angle( 0.3, 0.3, 0 ) )
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
	
	self:EmitSound(self.Primary.Sound)
	
	self.idledelay = CurTime() + self.Weapon:SequenceDuration()
	
end

function SWEP:SecondaryAttack()	

end

function SWEP:CanPrimaryAttack()

	if self:GetNextPrimaryFire() > CurTime() or self:GetHolster() then return end
 
	return true
end

function SWEP:IsBehind(target)

	local dir = target:GetPos() - self.Owner:GetShootPos() 
	return target:GetAimVector():Dot(dir) > math.sin(30)
	
end

function SWEP:Think()

	if not self.Owner:IsPlayer() then return end
	
	if SERVER then 
		if self.melee_striking then
			if self.melee_delay < CurTime() then
				local tr = util.TraceHull( {
					start = self.Owner:GetShootPos(),
					endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 75 ),
					filter = self.Owner,
					mins = Vector( -10, -10, -10 ),
					maxs = Vector( 10, 10, 10 ),
					mask = MASK_SHOT_HULL
				} )
				
				if ( tr.Hit ) then
					local dmginfo = DamageInfo()
					dmginfo:SetDamageType(DMG_CLUB)
					dmginfo:SetAttacker(self.Owner)
					dmginfo:SetInflictor(self)
					dmginfo:SetDamage(1)
					
					local hittr = self.Owner:GetEyeTrace()
					
					util.Decal( "ManhackCut", hittr.HitPos + hittr.HitNormal, hittr.HitPos - hittr.HitNormal )
					
					
					self.Owner:ViewPunch( Angle( math.Rand(1,2), math.Rand(-1,1), 0 ) )

					if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
					
						if self:IsBehind(tr.Entity) then
							dmginfo:SetDamage(1)
						end
						
					
						dmginfo:SetDamageForce(self.Owner:GetForward()*4)

						self.Owner:EmitSound("weapons/knife/knife_hit"..math.random(1, 3)..".wav")
						
						local fx = EffectData()
						fx:SetEntity(tr.Entity) 
						fx:SetOrigin(tr.HitPos)
						fx:SetNormal(tr.HitNormal)
						fx:SetColor(tr.Entity:GetBloodColor())
						if tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH then
							util.Effect("BloodImpact", fx)
						end
						
					else
						self.Owner:EmitSound("weapons/knife/knife_hitwall1.wav")
						if IsValid(tr.Entity:GetPhysicsObject()) then
							tr.Entity:GetPhysicsObject():ApplyForceCenter(self.Owner:GetForward()*3000)
						end
					end
					
					tr.Entity:TakeDamageInfo(dmginfo)
				else
					self.Owner:ViewPunch( Angle( 0.5, 0, 0 ) )
				end
				
				self.melee_striking = false
				
			end
		end
	end
	
	if self:GetHolster() and self:GetHolsterDelay() < CurTime() then
		if not IsFirstTimePredicted() then return end
		if SERVER then 
			if self.OneShot and self:Clip1() == 0 then
				self.Owner:StripWeapon(self.Weapon:GetClass())
			else
				self.Owner:SelectWeapon(self.ChangeTo)
			end		
		end
	end	
	
end

function SWEP:Holster(wep)
	if not IsFirstTimePredicted() then return end
	if self:IsValid() and self.Owner:IsValid() then
		
		if IsValid(wep) and self:GetNextPrimaryFire() < CurTime() and !self:GetHolster() then
			self.idledelay = 0
			self.Weapon:SendWeaponAnim(ACT_VM_HOLSTER)
			self:SetNextPrimaryFire(CurTime() + self.Weapon:SequenceDuration() )
			self:SetNextSecondaryFire(CurTime() + self.Weapon:SequenceDuration() )
			self:SetHolster(true)
			--self:EmitSound(self.HolsterSound, 100, 100)
			self:SetHolsterDelay( CurTime() + self.Weapon:SequenceDuration() )
			if SERVER then self.ChangeTo = wep:GetClass() end
		elseif self:GetHolster() and self:GetHolsterDelay() <= CurTime() then
			if SERVER then self.ChangeTo = nil end
			return true
		end
	end
	return false
end
