
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {

    ["scope1"] = {
        bone = "saiga_base",
        pos = Vector(0.038, -3.9, 3), 
        ang = Angle(0, 0, -90),
        size = 1,
        IronsightPos = Vector(-2.97, 1, -0.45),
        IronsightAng = Vector(-0.5, 0, 0),
        second_attachment = "planka1"
    },
    ["scope2"] = {
        bone = "saiga_base",
        pos = Vector(0, -4.5, 3), 
        ang = Angle(180, -90, 0),
        size = 1,
        IronsightPos = Vector(-2.966, 1, -0.85),
        IronsightAng = Vector(0, 0, 0),
        second_attachment = "planka1"
    },
    ["scope3"] = {
        bone = "saiga_base",
        pos = Vector(-0.01, -4.5, 3), 
        ang = Angle(90, 0, -90),
        size = 1,
        IronsightPos = Vector(-3, 1, -0.86),
        IronsightAng = Vector(0, 0, 0),
        second_attachment = "planka1"
    },
    ["nv_scope"] = {
        bone = "saiga_base",
        pos = Vector(0, -4.5, 4), 
        ang = Angle(90, 0, -90),
        size = 1,
        IronsightPos = Vector(-2.966, 1, -0.85),
        IronsightAng = Vector(0, 0, 0),
        second_attachment = "planka1"
    },
    ["planka1"] = {
        bone = "saiga_base",
        pos = Vector(0.34, -2, 2.5), 
        ang = Angle(90, -90, 0),
        size = 1.2
    },
    ["default_silencer"] = {
        bone = "saiga_base",
        pos = Vector(0, -1.15, 30), 
        ang = Angle(90, 0, 0),
        size = 1
    },
    ["saiga_mag1"] = {
        default = true
    },
    ["saiga_mag2"] = {
        default = false
    },
	["laser_sight"] = {
		bone = "saiga_base",
		pos = Vector(1, -1.2, 18), 
		ang = Angle(90, 15, -90),
		size = 1.1
	}

}

SWEP.ZatvorBone = "saiga_zatvor"
SWEP.UseZatvorBone = true

SWEP.EmptyReload = true
SWEP.ChamberedRound = true

SWEP.ShellTexture = "effects/animated/animated_gilza_3"

SWEP.GaySightAttack = true

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.AnimOverrides = {	
	["drum"] = {
		["fire"] = ACT_VM_PRIMARYATTACK,
		["draw"] = ACT_VM_DRAW,
		["reload"] = ACT_VM_DETACH_SILENCER,
		["reload_empty"] = ACT_VM_HAULBACK,
		["holster"] = ACT_VM_HOLSTER
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RECOIL1,
	["holster"] = ACT_VM_HOLSTER
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Сайга"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/saiga/v_saiga.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_saiga.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-2.95, -2, 0.85)
SWEP.IronsightAng = Vector(-0.5, 0, 0)
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

SWEP.ReloadAmmoDelay = 1.3

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.BulletDistance			= 1000

SWEP.Primary.Recoil			= 1

SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 4
SWEP.Primary.Cone			= 0.5

SWEP.Primary.Delay			= 0.35

SWEP.Primary.ClipSize		= 10 ---1
SWEP.Primary.DefaultClip	= 30 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_shotgun"

SWEP.UseHands = false
SWEP.Slot    = 2
SWEP.SlotPos = 2
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.MaxRandomSound			= 3
SWEP.RandomSoundFileType	= ".mp3"
SWEP.PrimarySound			= "weapons/saiga_shoot_1.mp3"

SWEP.RandomSilSound			= false
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/rev_shoot_s_1.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

