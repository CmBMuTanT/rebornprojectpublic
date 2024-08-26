
--SWEP.Base			= "metro_passport_base"

SWEP.Category				= "METRO BASE"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Динамо-Машина"	

SWEP.PassSkin = 3
	
SWEP.Slot				= 0							
SWEP.DrawAmmo				= false		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= false			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "slam"		

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/dynamo/v_dynamo.mdl"
SWEP.WorldModel				= ""		
SWEP.ShowWorldModel			= false
SWEP.ShowViewModel = false

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 0
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Ammo			= "none"

SWEP.UseHands = true

SWEP.Primary.Automatic		= true

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

function SWEP:SetupDataTables()

	self:NetworkVar( "Bool", 0, "Holster" )
	self:NetworkVar( "Float", 0, "HolsterDelay" )
	
	self:SetHolster( false )
	self:SetHolsterDelay( 0 )
	
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	--self:SendWeaponAnim( ACT_VM_DRAW )--ACT_VM_FIDGET
	--self.Owner:ViewPunch( Angle( -3,0,0 ) )
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "Draw" ) )
	self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() )
	self:SetHoldType("slam")	
	self.idledelay = CurTime() + vm:SequenceDuration() 
	self:SetHolsterDelay( CurTime() + vm:SequenceDuration() )
	self:SetHolster(false)
	--return true
end

function SWEP:Think()
local vm = self.Owner:GetViewModel()

	if CLIENT then return end
	
	if self:GetHolster() and (self:GetHolsterDelay() - CurTime()) <= 0 then
		self.Owner:SelectWeapon(self.ChangeTo)
		self:CallOnClient("ResetStrelka")
	end
		
	if self.idledelay and CurTime() > self.idledelay then
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "Idle" ) )
		self:SetHoldType("slam")
		self.idledelay = CurTime() + vm:SequenceDuration()	
	end

end

function SWEP:Holster(wep)
	local vm = self.Owner:GetViewModel()
	
	if self:IsValid() and self.Owner:IsValid() and IsValid(vm) then
		
		if IsValid(wep) and self:GetNextPrimaryFire() < CurTime() and !self:GetHolster() then
		
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "Holster" ) )
			self.idledelay = CurTime() + vm:SequenceDuration() + 0.1
			self:SetHolsterDelay( CurTime() + vm:SequenceDuration() )
			self:SetHolster(true)
			
			if SERVER then self.ChangeTo = wep:GetClass() end
			
			self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
			self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
			
		elseif self:GetHolster() and self:GetHolsterDelay() <= CurTime() then
			if SERVER then self.ChangeTo = nil end
			return true
		end
				
	end
	return false
end

function SWEP:PrimaryAttack()
	if self.Owner:GetNWInt("FlashlightEnergy") >= 1800 then return end
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "Fire" ) )
	self.idledelay = CurTime() + vm:SequenceDuration()	
	self.Owner:EmitSound("weapons/charger_pump_1.mp3")
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )
	if SERVER then
		self.Owner:SetNWInt("FlashlightEnergy", self.Owner:GetNWInt("FlashlightEnergy") + 100)
	end
end

function SWEP:SecondaryAttack()
end

SWEP.strelka = nil
SWEP.strelka_ang = Angle(0,0,0)
SWEP.strelka_sin_mul = 0
SWEP.strelka_delay = 0
SWEP.last_strelka = 0

function SWEP:ResetStrelka()
	local vm = self.Owner:GetViewModel()
	vm:ManipulateBoneAngles(self.strelka, Angle(0,0,0))
end

function SWEP:DrawHUD()

	local FT = FrameTime()
	local ply = LocalPlayer()
	local vm = self.Owner:GetViewModel()

		if self.last_strelka != ply:GetNWInt("FlashlightEnergy") then
			self.strelka_delay = CurTime() + 0.1
			self.last_strelka = ply:GetNWInt("FlashlightEnergy")
		else
			if self.strelka_delay > CurTime() then
				self.strelka_sin_mul = Lerp(FT*5, self.strelka_sin_mul, 15)
			else
				self.strelka_sin_mul = Lerp(FT*5, self.strelka_sin_mul, 0)
			end
		end

	if self.strelka == nil then
		self.strelka = vm:LookupBone("dynamo_strelka")
	else
		self.strelka_ang.y = Lerp(FT*10, self.strelka_ang.y, (((ply:GetNWInt("FlashlightEnergy")+(100*math.sin( CurTime()*15 )*self.strelka_sin_mul))*1)*0.1)-90)
		vm:ManipulateBoneAngles(self.strelka, self.strelka_ang)
	end

end

