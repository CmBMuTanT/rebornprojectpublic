
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
}


SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = false
SWEP.ChamberedRound = false
SWEP.UseMagBulletsBodyroup = false
SWEP.MagBulletsBodyroup = 4
--SWEP.ReloadBobMul = 0.5
SWEP.MagGroupClipOffset = 6

SWEP.GaySightAttack = true
SWEP.UseProjectiles = true
SWEP.Projectile = "metro_grenade1"

SWEP.AnimOverrides = {	
	["drum"] = {
		["fire"] = ACT_VM_PRIMARYATTACK,
		["draw"] = ACT_VM_DRAW,
		["reload"] = ACT_VM_RECOIL3,
		["reload_empty"] = ACT_VM_RELOAD,
		["holster"] = ACT_VM_HOLSTER
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["idle"] = ACT_VM_IDLE,
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["holster"] = ACT_VM_HOLSTER,
	["reload_2"] = ACT_VM_RELOAD_EMPTY,
	["reload_1"] = ACT_VM_RELOAD,
	["reload_0"] = ACT_VM_RECOIL2

}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Medved"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/medved/v_medved.mdl"
SWEP.WorldModel		= "models/w_weapons/w_medved.mdl"

SWEP.IronsightPos = Vector(-3.6, 0, 0.2)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

SWEP.InMenu = false

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "shotgun"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.BulletDistance			= 1000

SWEP.Primary.Recoil			= 5

SWEP.Primary.Damage			= 1 
SWEP.Primary.NumShots		= 10
SWEP.Primary.Cone			= 1
SWEP.Slot    = 4
SWEP.SlotPos = 4
SWEP.Primary.Delay			= 0.3

SWEP.Primary.ClipSize		= 3 ---1
SWEP.Primary.DefaultClip	= 6 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_granate"

SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrimarySound			= "weapons/ubo_1.mp3"
SWEP.DryFireSound			= "weapons/ubo_dry_fire_0.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

function SWEP:SetupDataTables()

	self:NetworkVar( "Bool", 1, "AimBool" )
	self:NetworkVar( "Float", 1, "NextReload" )
	self:NetworkVar( "Bool", 2, "Holster" )
	self:NetworkVar( "Float", 2, "Charge" )
	self:NetworkVar( "Bool", 3, "Running" )
	self:NetworkVar( "Bool", 4, "Silencer" )
	self:NetworkVar( "Float", 3, "Recoil" )
	self:NetworkVar( "Float", 4, "Overheat" )
	
	self:NetworkVar( "Float", 5, "HolsterDelay" )
	self:NetworkVar( "Bool", 5, "Deployed" )
	self:NetworkVar( "Bool", 6, "Charging" )
	self:NetworkVar( "Float", 6, "NxtPump" )
	
	self:NetworkVar( "Bool", 10, "Safe" )
	
	self:SetAimBool( false )
	self:SetNextReload( 0 )
	self:SetCharge( 100 )
	self:SetHolster( false )
	self:SetRunning( false )
	self:SetSilencer( false )
	self:SetRecoil( 0 )
	self:SetOverheat( 0 )
	
	self:SetHolsterDelay( 0 )
	self:SetDeployed( false )
	self:SetCharging( false )
	
	self:SetNxtPump( 0 )

	self:NetworkVar( "Bool", 7, "Reloading" )
	self:NetworkVar( "Bool", 8, "Started" )
	self:NetworkVar( "Bool", 9, "Second" )
	
	self:SetReloading(false)
	self:SetStarted(false)
	self:SetSecond(false)
	
	self:SetSafe( false )
	
end

function SWEP:OnDeploy()

	--local vm = self.Owner:GetViewModel()
	
	--for k, v in pairs(vm:GetSequenceList()) do
	--	print( v.." = "..vm:GetSequenceActivityName(vm:LookupSequence(v)) )
	--end
	
	--PrintTable(vm:GetBodyGroups())
	
end

SWEP.NextReset = 0
SWEP.ToReset = false


local drumroll = Angle(0, 0, 0)
local drmrltmp = Angle(0, 0, 0)

function SWEP:RollDrum()
	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll - Angle(120, 0, 0)
	local vm = self.Owner:GetViewModel()
	local bgroup = (3-self:Clip1())
	vm:SetBodygroup(6-bgroup, 1)
end

function SWEP:ResetDrum()
	local vm = self.Owner:GetViewModel()
	local drum = vm:LookupBone("roll")
	vm:ManipulateBoneAngles(drum, Angle(0, 0, 0))
	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll
	vm:SetBodygroup(2, 0)
	vm:SetBodygroup(3, 0)
	vm:SetBodygroup(4, 0)
end



function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime() or self:GetSafe() then return end
	
		self.SightsConeMul = math.Clamp(self.SightsConeMul, 0, 1)
				
		if self:GetAimBool() then
			--if self.GaySightAttack then
			--	self:CallOnClient("GayAttack", "1")
			--else
			--end
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone*self.SightsConeMul)
		else
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone)
		end
		
		self:PlayAnim("fire")
		
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:CallOnClient("RollDrum", "1")
		
		if SERVER then self.Owner:EmitSound(self.PrimarySound) end

		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		self.idledelay = CurTime() + self:SequenceDuration()
		
		self:Recoil()
end

function SWEP:SecondThink()

	local vm = self.Owner:GetViewModel()
	local drum = vm:LookupBone("roll")
	
	drumroll = LerpAngle(FrameTime()*6.5, drumroll, drmrltmp)
	vm:ManipulateBoneAngles(drum, drumroll)
	
	if self.ToReset and self.NextReset < CurTime() then
		self:CallOnClient("ResetDrum", "1")
		self.ToReset = false
	end
	
end

SWEP.Reloading = false

function SWEP:Reeload()

	if !IsFirstTimePredicted() then return false end
	if self.Owner:KeyDown(IN_USE) then 
		self:SetSafe( !self:GetSafe() ) 
		self:SetNextPrimaryFire( CurTime() + 0.1 )
	return end
	if self:GetSafe() then return end

	if (self:Clip1() >= self.Primary.ClipSize) or self.Weapon:Ammo1() < 0 or self:Ammo1() <= 0 or self:GetNextReload() > CurTime() or self:GetNextPrimaryFire() > CurTime() then return end
	
	local ammomath = 0
	local empty = false
	
	self.NextReset = CurTime() + 0.8
	self.ToReset = true
	
	local vm = self.Owner:GetViewModel()
		local clip = (3-self:Clip1())
		
		if self.Weapon:Ammo1() >= clip then
			self:PlayAnim("reload_"..self:Clip1())
			self.Weapon:SetClip1( self.Weapon:Clip1()+clip )
			self.Owner:SetAmmo( self.Weapon:Ammo1() - clip, self.Primary.Ammo ) 
		elseif self.Weapon:Ammo1() > 0 and self.Weapon:Ammo1() < clip then
			clip = self.Weapon:Ammo1()
			self:PlayAnim("reload_"..(3-clip))
			self.Weapon:SetClip1( self.Weapon:Clip1()+clip )
			self.Owner:SetAmmo( self.Weapon:Ammo1() - clip, self.Primary.Ammo ) 
		end
		
	self:SetNextReload( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )
	self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )
	
	self:SetRunning(false)
	
end
