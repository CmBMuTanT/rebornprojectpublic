
--SWEP.Base			= "metro_passport_base"

SWEP.Category				= "METRO BASE"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Боян"	

SWEP.Muzon = {
	[1] = {path = "boyan/boyan_1.wav"}
}

--local change_msg = "Музяка изменена"
	
SWEP.Slot				= 5
SWEP.DrawAmmo				= false		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= false			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "slam"		

SWEP.ViewModelFOV			= 75
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/boyan/v_boyan.mdl"
SWEP.WorldModel				= ""		
SWEP.ShowWorldModel			= false
SWEP.ShowViewModel = false

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 0
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Ammo			= "none"

SWEP.UseHands = false

SWEP.Primary.Automatic		= false
SWEP.Secondary.Automatic	= false

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

function SWEP:SetupDataTables()

	self:NetworkVar( "Bool", 0, "Holster" )
	self:NetworkVar( "Float", 0, "HolsterDelay" )
	self:NetworkVar( "Bool", 1, "Playing" )
	self:NetworkVar( "Float", 1, "MuzonPos" )
	
	self:SetHolster( false )
	self:SetHolsterDelay( 0 )
	self:SetPlaying( false )
	self:SetMuzonPos( 1 )
	
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self:SetHoldType("slam")	
	self.idledelay = CurTime() + vm:SequenceDuration() 
	self:SetHolsterDelay( CurTime() + vm:SequenceDuration() )
	self:SetHolster(false)
	self:SetPlaying( false )
	self:SetMuzonPos( 1 )
	--return true
end

function SWEP:StopPlaying()
	self:SendWeaponAnim( ACT_IDLE )
	self:SetPlaying( false )
	self:StopSound( self.Muzon[self:GetMuzonPos()].path )
end

function SWEP:PrimaryAttack()
	
	if !self:GetPlaying() then
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self:SetPlaying( true )
		self:EmitSound( self.Muzon[self:GetMuzonPos()].path )
	else
		self:StopPlaying()
	end
	
end

function SWEP:SecondaryAttack()
	self:StopPlaying()
	--self.Owner:PrintMessage( HUD_PRINTTALK, change_msg )
	if self:GetMuzonPos()+1 > #self.Muzon then
		self:SetMuzonPos(1)
	else
		self:SetMuzonPos(self:GetMuzonPos()+1)
	end
end

function SWEP:Think()

	if CLIENT then return end
	
	if self:GetHolster() and (self:GetHolsterDelay() - CurTime()) <= 0 then
		self.Owner:SelectWeapon(self.ChangeTo)
	end

end

function SWEP:Holster(wep)
	local vm = self.Owner:GetViewModel()
	
	if self:IsValid() and self.Owner:IsValid() and IsValid(vm) then
		
		if IsValid(wep) and self:GetNextPrimaryFire() < CurTime() and !self:GetHolster() then
		
			self:SendWeaponAnim( ACT_VM_HOLSTER )
			self.idledelay = CurTime() + self:SequenceDuration()
			self:SetHolsterDelay( CurTime() + self:SequenceDuration() )
			self:SetHolster(true)
			
			if SERVER then self.ChangeTo = wep:GetClass() end
			
			self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
			self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())
			
		elseif self:GetHolster() and self:GetHolsterDelay() <= CurTime() then
			if SERVER then self.ChangeTo = nil end
			return true
		end
				
	end
	return false
end

