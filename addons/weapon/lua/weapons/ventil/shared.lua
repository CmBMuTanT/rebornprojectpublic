
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["scope_optics"] = {
		bone = "ventil_base",
		pos = Vector(-0, -3.9, 4), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.85, 3, 0.1),
		IronsightAng = Vector(0, 0, 0)
	},
	["scope1"] = {
        bone = "ventil_base",
        pos = Vector(0, -3.2, 10),
        ang = Angle(0, 0, -90),
        size = 1,
        IronsightPos = Vector(-3.88, -2, 1.5),
        IronsightAng = Vector(-0.5, 0, 0),
        second_attachment = "planka2"
    },
	["scope2"] = {
		bone = "ventil_base",
		pos = Vector(0, -3.8, 10), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-3.87, -2, 1.17),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka2"
	},
	["scope3"] = {
		bone = "ventil_base",
		pos = Vector(0, -4, 9), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.87, -2, 0.9),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka2"
	},
	["nv_scope"] = {
		bone = "ventil_base",
		pos = Vector(0, -3.8, 10), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.87, -2, 1.1),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka2"
	},
	["laser_sight"] = {
		bone = "ventil_base",
		pos = Vector(1.2, -1.7, 13), 
		ang = Angle(90, 0, -90),
		size = 1.1
	},
	["planka2"] = {
		bone = "ventil_base",
		pos = Vector(-0.03, -2.7, 9), 
		ang = Angle(90, -90, 0),
		size = 1.2
	},
	["mag_ventil_default"] = {
        default = true
    },
	["mag_ventil_ex"] = {
        default = false
    }
}

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = false
SWEP.ChamberedRound = false

SWEP.GaySightAttack = false

SWEP.SilentByDefault = false

SWEP.EffectShell = false

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.AnimOverrides = {	
	["drum"] = {
		["fire"] = ACT_VM_PRIMARYATTACK,
		["draw"] = ACT_VM_DRAW,
		["reload"] = ACT_VM_ATTACH_SILENCER,
		["reload_empty"] = ACT_VM_DETACH_SILENCER,
		["holster"] = ACT_VM_HOLSTER,
		["idle"] = ACT_IDLE
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_SWINGHARD,
	["holster"] = ACT_VM_HOLSTER,
	["idle"] = ACT_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Вентиль"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/ventil/v_ventil.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_ventil.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-3.901, -2, 2.059)
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
SWEP.ReloadAmmoDelay = 0.8

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 5

SWEP.Primary.Damage			= 125 
SWEP.Primary.Force			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 1.1

SWEP.Primary.ClipSize		= 5 ---1
SWEP.Primary.DefaultClip	= 5 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_sniper"

SWEP.UseHands = false
SWEP.Slot    = 4
SWEP.SlotPos = 4
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.PrimarySound			= "weapons/ventil/ventil_base_shot.wav"

SWEP.RandomSilSound			= true
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/gold_shoot_sil_0.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.Penetration = true

function SWEP:OnDeploy()

end
