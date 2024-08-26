
SWEP.Category				= "Metro Gasmask"
SWEP.Author				= "Hobo_Gus"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "GASMASK HOLSTER"		
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
	self:SendWeaponAnim( ACT_VM_HOLSTER )
	self.Owner:EmitSound("gasmask/gasmask_holster_fast.wav")
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	
	self:SetHoldType( self.HoldType )	

	self.Owner:ViewPunch( Angle( -5,0,0 ) )
	local ply = self.Owner
	
	if SERVER then
		self.Owner:SetCanZoom( true ) 
		self.HolsterT = false
		self.Owner:SetNetVar("gasmask_on", false)
		net.Start( "ClearMask" )								
			net.WriteEntity( ply )
		net.Send(self.Owner)	
	end

	timer.Simple(self:SequenceDuration(), function()
		if SERVER then
			self.HolsterT = true
			if self.Owner.gasmask_lastwepon != nil and self.Owner:HasWeapon(self.Owner.gasmask_lastwepon) then
				self.Owner:SelectWeapon( self.Owner.gasmask_lastwepon )
				self.Owner:StripWeapon( "metro_gasmask_holster" ) 
			end
		end
	end)
	
	timer.Remove( "MMFX"..ply:SteamID() ) 
	
	return true
end

function SWEP:Holster()
return self.HolsterT
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end
