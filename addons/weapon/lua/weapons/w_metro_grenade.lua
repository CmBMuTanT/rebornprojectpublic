
--SWEP.Base = "new_base"

SWEP.PrintName = "Граната"

SWEP.Category = "METRO BASE"

SWEP.Instructions	= ""
SWEP.Author			= "hoobsug"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/metro/weapons/bombs/v_bomb.mdl" 
SWEP.WorldModel = ""
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 4
SWEP.SlotPos = 0
 
SWEP.UseHands = true

SWEP.HoldType = "rpg" 

SWEP.FiresUnderwater = false

SWEP.DrawCrosshair = false

SWEP.DrawAmmo = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "metro_granate"

SWEP.Primary.Sound = ""

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:SetupDataTables()

	self:NetworkVar( "Bool", 1, "Holster" )
	self:NetworkVar( "Float", 2, "HolsterDelay" )
	self:NetworkVar( "Float", 3, "NextReload" )
	
	self:SetHolster( false )
	self:SetHolsterDelay( 0 )
	self:SetNextReload( 0 )
	
end

function SWEP:Deploy()

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	
	--[[local vm = self.Owner:GetViewModel()
	for k, v in pairs(vm:GetSequenceList()) do
		print(vm:GetSequenceActivityName(vm:LookupSequence(v)))
	end]]
	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon:SequenceDuration())
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Weapon:SequenceDuration())
	self.idledelay = CurTime() + self.Weapon:SequenceDuration()

	self:SetHoldType( self.HoldType )
	
	self:SetHolster(false)
	self:SetNextReload( 0 )
	
	return true
end


function SWEP:FireProjectile()
	local ent = ents.Create( "metro_grenade1" )
	if ( IsValid( ent ) ) then
		local Forward = self.Owner:EyeAngles():Forward()
		local Right = self.Owner:EyeAngles():Right()
		local Up = self.Owner:EyeAngles():Up()
		ent:SetPos( self.Owner:GetShootPos() + (Forward * (28+(self.Owner:GetVelocity():LengthSqr()*0.0001))) + Right * 8 + Up * -4)
		ent:SetAngles( self.Owner:GetAimVector():Angle() )
		ent:Spawn()
		ent:Activate()
		ent:GetPhysicsObject():ApplyForceCenter( self.Owner:GetAimVector()*(20000) )
	end
end

SWEP.Throwing = false
SWEP.ThrowDelay = 0

function SWEP:PrimaryAttack()

	if !self:CanPrimaryAttack() then return end

	--self:EmitSound(Sound(self.Primary.Sound))
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
	self.ThrowDelay = CurTime() + 0.5
	self.Throwing = true
	
	self.Owner:ViewPunch( Angle( -3, 0, math.random(-1, 1) ) )
	self:SetNextPrimaryFire( CurTime() + self.Weapon:SequenceDuration()+1 )
	self:SetNextReload( CurTime() + self.Weapon:SequenceDuration() )
	self.idledelay = CurTime() + 0.3

	self:TakePrimaryAmmo(1)
	
end

function SWEP:SecondaryAttack()


end

function SWEP:Think()

	if SERVER then
		if self.idledelay < CurTime() and !self:GetHolster() and self:GetNextPrimaryFire() < CurTime() and self:GetNextReload() < CurTime() then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			self.idledelay = CurTime() + self.Weapon:SequenceDuration()
		end
		
		if self.Throwing and self.ThrowDelay < CurTime() then
			self:FireProjectile()
			self.Throwing = false
		end
		
	end

	if self:GetHolster() and self:GetHolsterDelay() < CurTime() then
		if not IsFirstTimePredicted() then return end
		if SERVER then 
			self.Owner:SelectWeapon(self.ChangeTo)
		end
	else
		if self:GetNextReload() < CurTime() and self:Clip1() <= 0 and self.Weapon:Ammo1() > 0 then 
			if not IsFirstTimePredicted() then return end
			self:Reload()
		end
	end
end

function SWEP:Reload()
	if self:Clip1() <= 0 and self.Weapon:Ammo1() > 0 then
		self.Owner:SetAmmo( self.Weapon:Ammo1() - 1, self.Primary.Ammo )
		self.Weapon:SetClip1( self.Weapon:Clip1()+1 )
	end
end

function SWEP:CanPrimaryAttack()

	if ( self:Clip1() <= 0 ) then

		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false

	end

	return true

end

function SWEP:Holster(wep)
	if not IsFirstTimePredicted() then return end
	if self:IsValid() and self.Owner:IsValid() then
		
		if IsValid(wep) and self:GetNextPrimaryFire() < CurTime() and !self:GetHolster() then
			--self.idledelay = 0
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
