//
SWEP.Base = "hobogus_base_zig"

SWEP.AdminSpawnable = true

SWEP.AutoSwitchTo = true
SWEP.Slot = 2
SWEP.PrintName = "SIEG HAIL"
SWEP.Author = "Hobo_Gus"
SWEP.Spawnable = true
SWEP.AutoSwitchFrom = true
SWEP.Weight = 5
SWEP.DrawCrosshair = false
SWEP.CustomCrosshair = false
SWEP.CrossColor = Color( 0, 255, 0, 150 )
SWEP.Category = "Hobo_Gus"
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.Instructions = "HAIL"
SWEP.Contact = ""
SWEP.Purpose = "SIEG HAIL!!11!1!!"
SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.LaserSight = 0
SWEP.Dissolve = 1

SWEP.IronsightTime = 0.17
SWEP.DisableMuzzle = 1
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 85.318, 0) },
	["ValveBiped.Bip01_R_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 43.699, 0) },
	["ValveBiped.base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, -30, -30), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(45, 0, -65) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 45, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(15, 0, -3), angle = Angle(0, -45, 2) },
	["ValveBiped.Bip01_R_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 54.104, 0) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10.404, 35.375, 0) },
	["ValveBiped.Bip01_R_Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 6.243, 0) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(14.565, 41.618, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 0, 0), angle = Angle(0, 180, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -43.7, 0) }
}
SWEP.IronSightsPos = Vector(-7.52, -7, 1.629)
SWEP.IronSightsAng = Vector(-1, 0, 0)

//SWEP.PrimaryReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.PrimarySound = Sound("weapons/ar1/ar1_dist2.wav")

SWEP.Primary.Damage = 20
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Spread = 15
SWEP.Primary.Cone = 0.3
SWEP.IronCone = 0.1
SWEP.DefaultCone = 0.3
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1.2
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 3
SWEP.Tracer = 10
SWEP.CustomTracerName = "blu_pulse_tracer"
SWEP.ShotEffect = "blupulse_light"

SWEP.IronFOV = 70

--if CLIENT then



--end

function SWEP:SecondThink()

local ply = self.Owner
local FT = FrameTime()

local ang1 = ply:GetNWFloat("ang1")
local ang2 = ply:GetNWFloat("ang2")

if self.Owner:KeyDown(IN_ATTACK) then
ply:SetNWFloat("ang1", Lerp(FT*2, ang1, 1) )
ply:SetNWFloat("ang2", Lerp(FT*2, ang1, 45) )
else
ply:SetNWFloat("ang1", Lerp(FT*2, ang1, 0) )
ply:SetNWFloat("ang2", Lerp(FT*2, ang2, 0) )
end

	if IsValid(ply) and SERVER then
		
		local bone = ply:LookupBone("ValveBiped.Bip01_R_UpperArm")
		if bone then 
			ply:ManipulateBoneAngles( bone, Angle(45*ang1,-135*ang1,-45*ang1) )
		end
		local bone = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
		if bone then 
			ply:ManipulateBoneAngles( bone, Angle(0,0,-45*ang1) )
		end
		
	end

end

function SWEP:DoBones()
local FT = FrameTime()

local ply = self.Owner
local ang1 = ply:GetNWFloat("ang1")
local ang2 = ply:GetNWFloat("ang2")

	if IsValid(ply) then
		self.ViewModelBoneMods["ValveBiped.Bip01_R_Forearm"].angle = Angle(0, 45*ang1, 0)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = Angle(0, -45*ang1, 2)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].pos = Vector(0 , -15 +(15*ang1), -3)
	end
//self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = Angle(swingang/4, 0, 0)
end

function SWEP:Holster()
local ply = self.Owner
	if IsValid(ply) then
		
	if SERVER then
		self.ViewModelBoneMods["ValveBiped.Bip01_R_Forearm"].angle = Angle(0, 0, 0)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = Angle(0, 0, 0)
		
		local bone = ply:LookupBone("ValveBiped.Bip01_R_UpperArm")
		if bone then 
			ply:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
		local bone = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
		if bone then 
			ply:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
	end
	end
	
	if CLIENT and IsValid(self.Owner) and self.Owner:IsPlayer() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
return true
end


function SWEP:PrimaryAttack()

end

function SWEP:Reload()

end

SWEP.NxtSec = 0

function SWEP:SecondaryAttack()
//No ironsights, mothefucker, deal with it!
if self.NxtSec < CurTime() and self.Owner:KeyDown(IN_ATTACK) then
self.Weapon:EmitSound("sieg/heil1.mp3")
self.NxtSec = CurTime() + 2.3
end
end

function SWEP:QuadsHere()
end

SWEP.VElements = {
}
SWEP.WElements = {
}

print ('SIEGHAIL')