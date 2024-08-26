
SWEP.Category				= "Metro Gasmask"
SWEP.Author				= "Hobo_Gus"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "GASMASK DEPLOY"		
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
	self.Owner:SetNWInt("checkfilter", CurTime() + 5)
	
	self:SendWeaponAnim( ACT_VM_DRAW )--ACT_VM_FIDGET
	self.Owner:ViewPunch( Angle( 10,0,0 ) )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self:SetHoldType( self.HoldType )	

	self.Owner:EmitSound("gasmask/gasmask_on_fast.wav")
	self.Owner:ViewPunch( Angle( -3,0,0 ) )
	
	if SERVER then
	
		self.HolsterT = false
		self.Owner:SetCanZoom( false )
		 
		timer.Simple(self:SequenceDuration()*0.87, function()
			if self.Weapon == nil then return end
				
				self.Owner:SetNetVar("gasmask_on", true)
				self.Owner:ViewPunch( Angle( 3,0,0 ) )
				
		local ply = self.Owner	
		
			timer.Create("MMFX"..ply:SteamID(), 1, 0, function()
				sounds[ply:SteamID()] = CreateSound(ply, Sound("metromod/breath_1.wav"))
				sounds[ply:SteamID()]:SetSoundLevel(42)
				sounds[ply:SteamID()]:PlayEx(1, 100)
			end)			
					
		end)
		
	end
	
	timer.Simple(self:SequenceDuration(), function()
		if self.Weapon == nil then return end
			if SERVER then
				self.HolsterT = true
				if self.Owner.gasmask_lastwepon != nil and self.Owner:HasWeapon(self.Owner.gasmask_lastwepon) then
					self.Owner:SelectWeapon( self.Owner.gasmask_lastwepon )
					self.Owner:StripWeapon( "metro_gasmask_deploy" ) 
				end
			end
	end)
	
	return true
end

function SWEP:Holster()
return self.HolsterT
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end
