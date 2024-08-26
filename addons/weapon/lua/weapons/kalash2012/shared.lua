
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {

	["scope2"] = {
		bone = "2012_body",
		pos = Vector(0, -4.3, 5), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-3.18, -2, -0.3),
		IronsightAng = Vector(0, 0, 0)
	},
	["scope3"] = {
		bone = "2012_body",
		pos = Vector(0, -4.5, 3.5), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.18, -3, -0.4),
		IronsightAng = Vector(0, 0, 0)
	},
    ["nv_scope"] = {
		bone = "2012_body",
		pos = Vector(0, -4.4, 4.5), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.18, -3, -0.4),
		IronsightAng = Vector(0, 0, 0)
	},
	["scope_optics"] = {
		bone = "2012_body",
		pos = Vector(0, -4.5, -2), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.18, 3, -1.35),
		IronsightAng = Vector(0, 0, 0)
	},
	["default_silencer"] = {
		bone = "2012_body",
		pos = Vector(0, -0.6, 18), 
		ang = Angle(90, 0, 0),
		size = 1
	},
	["laser_sight"] = {
		bone = "2012_body",
		pos = Vector(1.2, -0.551, 3), 
		ang = Angle(90, 15, -90),
		size = 1.1
	},
	["fonarik_att"] = {
		bone = "2012_body",
		pos = Vector(1.2, -0.551, 3), 
		ang = Angle(90, 15, -90),
		size = 1.1
	}

}

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = true
SWEP.ChamberedRound = true

SWEP.GaySightAttack = true

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.AnimOverrides = {	
	["drum"] = {
		["fire"] = ACT_VM_PRIMARYATTACK,
		["draw"] = ACT_VM_DRAW,
		["reload"] = ACT_VM_RECOIL3,
		["reload_empty"] = ACT_VM_RECOIL2,
		["holster"] = ACT_VM_HOLSTER
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RELOAD_EMPTY,
	["holster"] = ACT_VM_HOLSTER
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Калаш 2012"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/ak_2012/v_ak_2012.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_ak_2012.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-3.2, -3, 0.5)
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
SWEP.ReloadAmmoDelay = 1.2

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1

SWEP.Primary.Damage			= 35
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 0.09

SWEP.Primary.ClipSize		= 40 ---1
SWEP.Primary.DefaultClip	= 40 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_avtomat"

SWEP.UseHands = false
SWEP.Slot    = 3
SWEP.SlotPos = 3
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.MaxRandomSound			= 3
SWEP.RandomSoundFileType	= ".mp3"
SWEP.PrimarySound			= "weapons/ak_standart_1.mp3"

SWEP.RandomSilSound			= true
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/2012_shoot_sil"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"


function SWEP:OnDeploy()

end
