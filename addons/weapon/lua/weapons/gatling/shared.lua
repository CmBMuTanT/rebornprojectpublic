
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["gatling_upgrade"] = {
		default = false
	},
	["gatling_stvol"] = {
		default = false
	}
}

SWEP.UseMagBulletsBodyroup = true
SWEP.MagBulletsBodyroup = 3

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = false
SWEP.ChamberedRound = false

--SWEP.MagGroupOffset = 2
SWEP.ReloadAmmoDelay = 2

SWEP.MagGroupClipOffset = 6

SWEP.Chargeable = true
SWEP.ChargeTake = 0.4
SWEP.ChargeAdd = 10
SWEP.ChargeStrelkaBone = "gatling_roll_2"
SWEP.ChargeStrelkaMul = 2
SWEP.StrelkaOffset = -60

SWEP.StrelkaSinMul = 0

SWEP.ChargeInSound = "weapons/tikhar_pump_in.mp3"
SWEP.ChargeOutSound = "weapons/tikhar_pump_out.mp3"

SWEP.PumpSound = "weapons/gatling/gatling_wind_up.wav"
SWEP.PumpHardSound = "weapons/gatling/gatling_wind_up.wav"

SWEP.GaySightAttack = true

SWEP.SilentByDefault = false

SWEP.EffectShell = true
SWEP.ShellTexture = "effects/animated/animated_gilza_1"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RELOAD_EMPTY,
	["holster"] = ACT_VM_HOLSTER,
	["pump_start"] = ACT_VM_RECOIL1,
	["pump"] = ACT_VM_RECOIL2,
	["pump2"] = ACT_VM_RECOIL2,
	["pump_finish"] = ACT_VM_RECOIL3,
	["ruchka_start"] = ACT_VM_MISSCENTER,
	["ruchka_finish"] = ACT_VM_MISSRIGHT2,
	["idle"] = ACT_VM_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Гатлинг"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/gatling/v_gatling.mdl"
SWEP.WorldModel		= "models/w_weapons/w_gatling.mdl"

SWEP.Ironsights = false

SWEP.IronsightPos = Vector(-2.651, -2, 1.049)
SWEP.IronsightAng = Vector(-0.5, 0, 0)

--SWEP.IronsightPos = Vector(-2.488, -6.125, -8.23)
--SWEP.IronsightAng = Vector(28.804, 0.67, -2.01)

SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

--SWEP.AttPos = Vector(4.421, -7.84, -2.412)
--SWEP.AttAng = Vector(33.769, 23.92, 14.774)
SWEP.AttPos = Vector(10, -8, 0)
SWEP.AttAng = Vector(11.255, 38, 8.442)

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "physgun"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 2

SWEP.Primary.Damage			= 29
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.15
SWEP.Primary.Force			= 5

SWEP.Primary.Delay			= 0.1

SWEP.Primary.ClipSize		= 150 ---1
SWEP.Primary.DefaultClip	= 300 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_gat"

SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

SWEP.PrimarySound			= "weapons/gatling/gatling_close_shot_1.wav"
SWEP.Slot    = 3
SWEP.SlotPos = 3
SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.Windup = 0
SWEP.NextWindUp = 0
SWEP.Holding = false

SWEP.ShellForwardMod = 12

local drum_bone = nil


local drumroll = Angle(0, 0, 0)
local drmrltmp = Angle(0, 0, 0)

function SWEP:GetDrumBone()
	if drum_bone == nil then
		local vm = self.Owner:GetViewModel()
		drum_bone = vm:LookupBone("gatling_roll")
		--PrintTable(vm:GetBodyGroups())
	end
	return drum_bone
end

function SWEP:RollDrum()
--	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll + Angle(0, 45, 0)
end

function SWEP:ResetDrum()
	local vm = self.Owner:GetViewModel()
	local drum = self:GetDrumBone()
	vm:ManipulateBoneAngles(drum, Angle(0, 0, 0))
	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll
end

local nxt_engine_step = 0

function SWEP:SecondThink()

	if self.NextWindUp > CurTime() then
	
		self:SetOverheat(Lerp(FrameTime()*3, self:GetOverheat(), 1))
		
		if nxt_engine_step < CurTime() then
			self:EmitSound("weapons/engine_step_v2.wav", 75, 100, 1, CHAN_AUTO)
			nxt_engine_step = CurTime() + 0.3 - (0.2*self:GetOverheat())
		end
		
		if !self.Holding then
			self:PlayAnim("ruchka_start")
			self.Holding = true
		end
	else
	
		self:SetOverheat(Lerp(FrameTime()*5, self:GetOverheat(), 0))
		
		if self.Holding then
			if self:GetNextReload() < CurTime() then
				self:PlayAnim("ruchka_finish")
			end
			self:EmitSound("weapons/engine_step.wav", 75, 100, 1, CHAN_AUTO)
			self.Holding = false
		end
	end
	
	if CLIENT then
	
		local vm = self.Owner:GetViewModel()
		local drum = self:GetDrumBone()
		--local cur_shell = vm:LookupBone("uboinik_bullet_2")
		drmrltmp.y = drmrltmp.y + 3*(self:GetOverheat()*2)
		drumroll = LerpAngle(FrameTime()*6, drumroll, drmrltmp)
		vm:ManipulateBoneAngles(drum, drumroll)
		
	end
	
end

function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime() or (self.Chargeable and self:GetCharge() <= 0) then 
	return 
	end
		
		self.NextWindUp = CurTime() + 0.2
		self.idledelay = CurTime() + 0.5
		
		if self:GetOverheat() >= 0.95 then
			self:PlayAnim("fire")
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone)
		
			self.Owner:SetAnimation(PLAYER_ATTACK1)
		
			self:Muzzle()
		
			if self.RandomPrimarySound then
				self:EmitSound(self.PrimarySound.."_"..math.random(1, self.MaxRandomSound)..self.RandomSoundFileType)
			else
				self:EmitSound(self.PrimarySound)
			end
			
			if self.Chargeable then
				self:SetCharge(self:GetCharge()-self.ChargeTake)
			end
			
			self:TakePrimaryAmmo(self.Primary.TakeAmmo)
			self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
			self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
			self.idledelay = CurTime() + self:SequenceDuration()
			
			self:Recoil()
		end
end

function SWEP:SecondaryAttack()	
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime() or (self.Chargeable and self:GetCharge() <= 0) then 
	return 
	end
	--if self.NextWindUp < CurTime() then
	self.NextWindUp = CurTime() + 0.2
	self.idledelay = CurTime() + 0.5
	--end
	self.Weapon:SetNextSecondaryFire(CurTime()+0.1)
end
