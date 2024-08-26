--[[

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )

	function SWEP:OnDrop()

		if ( ValidEntity( self.Weapon ) ) then
			self.Owner = nil
		end

	end

end
]]
function SWEP:CreateWorldModel()
   if not self.WModel then
      self.WModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
      self.WModel:SetNoDraw(true)
      self.WModel:SetBodygroup(1, 1)
   end
   return self.WModel
end

function SWEP:DrawWorldModel()
   local wm = self:CreateWorldModel()
   if self.Owner != NULL then
	   local bone = self.Owner:LookupBone("ValveBiped.Bip01_L_Hand")
	   local pos, ang = self.Owner:GetBonePosition(bone)
			
	   if bone then
		  ang:RotateAroundAxis(ang:Right(), self.Ang.p)
		  ang:RotateAroundAxis(ang:Forward(), self.Ang.y)
		  ang:RotateAroundAxis(ang:Up(), self.Ang.r)
		  wm:SetRenderOrigin(pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z)
		  wm:SetRenderAngles(ang)
		  wm:DrawModel()
		  wm:SetModelScale( 0.8, 0 )
	   end
	else
		wm:DrawModel()
	end
end
SWEP.Pos = Vector(-3,-3,3)
SWEP.Ang = Angle(70, 180, 0)
SWEP.Base				= "weapon_base"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.PrintName			= "Швабра"
SWEP.ViewModel			= ""
SWEP.Author              = "Creed"
SWEP.Instructions		= "Hold left click to sweep decals."
SWEP.WorldModel			= "models/props_c17/pushbroom.mdl"
SWEP.HoldType			= "passive"
SWEP.DoEffect			= false

CreateConVar("broom_clearamount", 1, FCVAR_ARCHIVE, "The amount of decals to place for Creed\'s Broom SWEP" )
function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end
function SWEP:PrimaryAttack()
    local tr = self.Owner:GetEyeTrace()
	if self:GetOwner():GetPos():Distance(tr.HitPos) > 100 then return end
	self:SetNextPrimaryFire( CurTime() + 0.2 )
end
function SWEP:Think()
	if (self.Owner:KeyDown(IN_ATTACK)) then
		if math.sin(CurTime()*5) > 0.9 then
			if self.DoEffect then
				local tr = self.Owner:GetEyeTrace()
				if self:GetOwner():GetPos():Distance(tr.HitPos) <= 100 then
					self.DoEffect = false
					--The Source Engine will remove decals in a given area if there
					--are too many of them, thus giving us a cleaning effect.
					sound.Play("player/footsteps/dirt1.wav", tr.HitPos, 70, 100, 1 )
					local info = EffectData();
					info:SetNormal( tr.HitNormal );
					info:SetOrigin( tr.HitPos );
					for i=0, 50 do
						info:SetScale(math.random( 0.01, 0.5))
						util.Effect( "WheelDust", info );
					end
				end
			end
		else
			if not self.DoEffect then
				self.DoEffect = true
			end
		end
	end
end
function SWEP:SecondaryAttack()
end