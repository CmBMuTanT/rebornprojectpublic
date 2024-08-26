
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["fedorov_mag1"] = {
		default = true
	},
	["fedorov_mag2"] = {
		default = false
	}
}

SWEP.ZatvorBone = "Weapon_bolt"
SWEP.UseZatvorBone = true

SWEP.EmptyReload = true
SWEP.ChamberedRound = true

SWEP.GaySightAttack = true

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RELOAD_EMPTY,
	["holster"] = ACT_VM_HOLSTER,
	["idle"] = ACT_VM_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Автомат Фёдорова"
SWEP.Author			= "naimina7"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/v_fedorov_avtomat.mdl"
SWEP.WorldModel		= "models/weapons/w_fedorov_avtomat.mdl"

SWEP.IronsightPos = Vector(-3.15, 0, 0.959)
SWEP.IronsightAng = Vector(0.5, 4, -2)
SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

--SWEP.AttPos = Vector(4.421, -7.84, -2.412)
--SWEP.AttAng = Vector(33.769, 23.92, 14.774)

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1.2

SWEP.Primary.Damage			= 38  
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 0.14

SWEP.Primary.ClipSize		= 25 ---1
SWEP.Primary.DefaultClip	= 25 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_avtomat"

SWEP.UseHands = true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.MaxRandomSound			= 3
SWEP.RandomSoundFileType	= ".wav"
SWEP.PrimarySound			= "weapons/tfa_ww1_fedorov/bar_a1.wav"

SWEP.RandomSilSound			= true
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/2012_shoot_sil"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.ReloadAmmoDelay = 1.65

SWEP.ZatvorVector = Vector(0, 0, -15)

function SWEP:OnDeploy()
	--[[local vm = self.Owner:GetViewModel()
	PrintTable(vm:GetBodyGroups())
	for i = 0, vm:GetBoneCount() - 1 do
        print( i, vm:GetBoneName( i ) )
    end]]
end
