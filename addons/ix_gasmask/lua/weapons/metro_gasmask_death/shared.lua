
SWEP.Category				= "Metro Gasmask"
SWEP.Author				= "Hobo_Gus"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "GASMASK WIPE"		
SWEP.Slot				= 99				
SWEP.SlotPos				= 23			
SWEP.DrawAmmo				= false		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= false			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "normal"		

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/metroll/v_gasmask.mdl"
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

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.HolsterT = false

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK_EMPTY )
	self.Owner:EmitSound("gasmask/breathing/breath_suffocation_"..math.random(1,3)..".wav")
	self.Owner:ViewPunch( Angle( 3,0,0 ) )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self:SetHoldType( self.HoldType )	
	
	if SERVER then
		self.HolsterT = false
		timer.Simple(self:SequenceDuration(), function()
			if self.Weapon == nil then return end
			self.Owner:Kill()
			--self.Owner:StripWeapon( "metro_gasmask_death" ) 
		end)
	end
	
	local ply = self.Owner
	
	return true
end

function SWEP:Holster()
		return self.HolsterT
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end
