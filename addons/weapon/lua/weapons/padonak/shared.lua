
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["padonak_mag1"] = {default = true},
	["padonak_mag2"] = {default = false},
	["padonak_handguard"] = {
		default = false,
		IronsightPos = Vector(-3.61, -4, 1.6),--Vector(-4.1, -4, 1.09)
		IronsightAng = Vector(0, 0, 0)
	},
	["padonak_priklad"] = {
		default = false,
		IronsightPos = Vector(-3.61, -4, 1.6),--Vector(-4.1, -4, 1.09)
		IronsightAng = Vector(0, 0, 0)
	},
	["padonak_autofire"] = {default = false},
	["padonak_barrel"] = {default = false},
	["padonok_silencer"] = {
		bone = "padonak_body",
		pos = Vector(0, -0.95, 13.5), 
		ang = Angle(90, 15, -90),
		size = 0.8
	},
	["laser_sight"] = {
		bone = "padonak_body",
		pos = Vector(1.2, -0.1, 5), 
		ang = Angle(90, 15, -90),
		size = 1.1
	},
    ["scope2"] = {
		bone = "padonak_body",
		pos = Vector(-0.015, -2.6, 4), 
		ang = Angle(0, 90, 180),
		size = 1.15,
		IronsightPos = Vector(-4.1, -1, 0.06),
		IronsightAng = Vector(0, 0, 0),
		anim_sight_overrides = {
			["handguard"] = {
				IronsightPos = Vector(-3.61, 1, 0.66),
				IronsightAng = Vector(0, 0, 0)			
			},
			["priklad"] = {
				IronsightPos = Vector(-3.61, 1, 0.66),
				IronsightAng = Vector(0, 0, 0)			
			}
		}
	}
}

SWEP.ZatvorBone = "padonak_zatvor"
SWEP.UseZatvorBone = true

SWEP.UseMagBulletsBodyroup = true
SWEP.MagBulletsBodyroup = 7
SWEP.MaxMagGroup = 5

SWEP.EmptyReload = true
SWEP.ChamberedRound = false

SWEP.GaySightAttack = true

SWEP.SilentByDefault = false

SWEP.EffectShell = true

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.AnimOverrides = {	
	["handguard"] = {
		["fire"] = ACT_VM_RECOIL2,
		["draw"] = ACT_VM_PULLBACK_HIGH,
		["reload_5"] = ACT_VM_MISSRIGHT2,
		["reload_10"] = ACT_VM_MISSCENTER,
		["reload_empty_5"] = ACT_VM_MISSLEFT2,
		["reload_empty_10"] = ACT_VM_MISSRIGHT,
		["holster"] = ACT_VM_THROW,
		["idle"] = ACT_VM_FIDGET
	},
	["priklad"] = {
		["fire"] = ACT_VM_RECOIL1,
		["draw"] = ACT_VM_PULLBACK_LOW,
		["reload_5"] = ACT_VM_SWINGHARD,
		["reload_10"] = ACT_VM_SWINGMISS,
		["reload_empty_5"] = ACT_VM_MISSCENTER2,
		["reload_empty_10"] = ACT_VM_HAULBACK,
		["holster"] = ACT_VM_PULLPIN,
		["idle"] = ACT_VM_PULLBACK
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload_5"] = ACT_VM_HITRIGHT2,
	["reload_10"] = ACT_VM_HITCENTER,
	["reload_empty_5"] = ACT_VM_HITLEFT2,
	["reload_empty_10"] = ACT_VM_HITRIGHT,
	["holster"] = ACT_VM_HOLSTER,
	["idle"] = ACT_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Падонок"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/padonak/v_padonak.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_padonak.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-4.1, -4, 1.09)
SWEP.IronsightAng = Vector(0, 0, 0)
--SWEP.IronsightPos = Vector(-2.651, -2, 0.6)
--SWEP.IronsightAng = Vector(-0.5, 0, 0)
SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

--SWEP.AttPos = Vector(4.421, -7.84, -2.412)
--SWEP.AttAng = Vector(33.769, 23.92, 14.774)
--SWEP.AttPos = Vector(4.609, -7.391, -1.305)
--SWEP.AttAng = Vector(32.564, 44.13, 22.826)

SWEP.ReloadBobMul	= 1
SWEP.ReloadAmmoDelay = 0.7

SWEP.HoldType		= "pistol"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1

SWEP.Primary.Damage			= 18  
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.3

SWEP.Primary.Delay			= 0.15

SWEP.Primary.ClipSize		= 5 ---1
SWEP.Primary.DefaultClip	= 10 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_pistol"

SWEP.UseHands = false
SWEP.Slot    = 1
SWEP.SlotPos = 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.PrimarySound			= "weapons/podonok/padonag_shot_close.mp3"

SWEP.RandomSilSound			= false
SWEP.SilencedSound	= "weapons/rev_shoot_s_1.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.Penetration = true


function SWEP:Reeload()

	if !IsFirstTimePredicted() then return false end
	if !self:CanReload() then return end
	
	self:OnReload()
	local vm = self.Owner:GetViewModel()
	local mag = self:GetInstalledAtt("mag")
	--if SERVER then self.Owner:EmitSound(self.ReloadSound) end
	--self.Owner:GetViewModel():SetPlaybackRate( 0.5 )
	
	local mag_name_fix = "5"
	
	if mag == "padonak_mag1" then
		mag_name_fix = "5"
	else
		mag_name_fix = "10"
	end
	
	local ammomath = 0
	local empty = false
	
		if self.Weapon != nil then
			self.Owner:SetAnimation(PLAYER_RELOAD)
		end
		
		if self:Clip1() <= 0 then
			self:PlayAnim("reload_empty_"..mag_name_fix)		
			empty = true
		else
			self:PlayAnim("reload_"..mag_name_fix)	
			empty = false
		end
	
	local delay = self:SequenceDuration()
	if self.ReloadAmmoDelay != 0 then
		delay = self.ReloadAmmoDelay
	end
	
	timer.Simple( delay, function() 
		if self.Weapon == nil then return end
		
		if self.Weapon:Ammo1() >= self.Primary.ClipSize - self.Weapon:Clip1() then
			if !empty and self.Weapon:Ammo1() >= self.Primary.ClipSize - self.Weapon:Clip1()+1 and self.ChamberedRound then
				ammomath = self.Primary.ClipSize - self.Weapon:Clip1()+1
				self.Owner:SetAmmo( self.Weapon:Ammo1() - ammomath, self.Primary.Ammo ) 
			else
				ammomath = self.Primary.ClipSize - self.Weapon:Clip1()
				self.Owner:SetAmmo( self.Weapon:Ammo1() - ammomath, self.Primary.Ammo ) 			
			end
		elseif self.Weapon:Ammo1() < self.Primary.ClipSize - self.Weapon:Clip1() then
			ammomath = self.Weapon:Ammo1()
			self.Owner:SetAmmo( 0, self.Primary.Ammo ) 		
		end	
		
		if ( self.ChamberedRound and self.Weapon:Clip1() >= self.Primary.ClipSize + 1 ) or ( !self.ChamberedRound and self.Weapon:Clip1() >= self.Primary.ClipSize ) then return end
		self.Weapon:SetClip1( self.Weapon:Clip1()+ammomath )
	end)

	self:SetRunning(false)
	self:SetNextReload( CurTime() + self:SequenceDuration() / vm:GetPlaybackRate() )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() / vm:GetPlaybackRate() )
	
end
