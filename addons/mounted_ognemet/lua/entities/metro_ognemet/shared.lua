ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Огнемёт"
ENT.Author = ""
ENT.Category = "metro"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.AmmoItem = "toplivo"		--предмет для перезарядки
ENT.TakeAmmo = 2				--чем больше тем быстрее кончается топливо
ENT.MuzzleName = "m_flamer"		--эффект

function ENT:SetupDataTables()

	self:NetworkVar( "Float", 0, "Ammo" )
	self:NetworkVar( "Angle", 0, "GunAng" )
	self:NetworkVar( "Angle", 1, "GunAng2" )
	
	if SERVER then
		self:SetAmmo(100)
		self:SetGunAng(Angle(0,0,0))
		self:SetGunAng2(Angle(0,0,0))
	end
	
end

ENT.RotationBone = nil
ENT.RotationBone2 = nil

ENT.NextFire = 0

local mutant_base = "npc_vj_creature_base"

function ENT:FireGun(ply)

	if self.NextFire < CurTime() then
	
		if self:GetAmmo() > 0 then
			if self.RotationBone2 then
			
				local pos, ang = self.Entity:GetBonePosition(self.RotationBone2)

				local fx = EffectData()
				fx:SetEntity(self.Entity)
				fx:SetOrigin(self.Entity:GetPos() + ang:Forward()*50 - ang:Right()*10)
				fx:SetNormal(ang:Forward())
				fx:SetAttachment(1)

				util.Effect(self.MuzzleName, fx)
				
				if SERVER then
				
					self:EmitSound("ambient/fire/mtov_flame2.wav")
					
					local tr = util.TraceHull( {
						start = self.Entity:GetPos() + (ang:Forward()*50),
						endpos = self.Entity:GetPos() + ( ang:Forward() * 300 ),
						filter = self,
						mins = Vector( -10, -10, -10 ),
						maxs = Vector( 10, 10, 10 ),
						mask = MASK_SHOT_HULL
					} )
					
					if ( tr.Hit ) then
						local dmginfo = DamageInfo()
						dmginfo:SetDamageType(DMG_BURN)
						dmginfo:SetAttacker(self.Owner)
						dmginfo:SetInflictor(self)
						
						if tr.Entity and tr.Entity.Base and tr.Entity.Base == mutant_base then
							dmginfo:SetDamage(30)
						else
							dmginfo:SetDamage(20)
						end
						
						tr.Entity:Ignite(20)
						
						if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
							dmginfo:SetDamageForce(self.Owner:GetForward()*3000)
						else
							if IsValid(tr.Entity:GetPhysicsObject()) then
								tr.Entity:GetPhysicsObject():ApplyForceCenter(self.Owner:GetForward()*1500)
							end
						end
						
						tr.Entity:TakeDamageInfo(dmginfo)
					end

					self:SetAmmo(self:GetAmmo()-self.TakeAmmo)
				end
			end
		else
			if SERVER then self:EmitSound("weapons/tikhar_empty_air.wav") end
		end
		
		self.NextFire = CurTime()+0.1
		
	end
	
end


ENT.NextReload = 0

function ENT:ReloadGun(ply)
	
	if self:GetAmmo() > 0 or self.NextReload > CurTime() or !ply or ply == nil or !ply:Alive() then return end
	local inv = ply:GetCharacter():GetInventory()
	
	if SERVER then 
		if inv:GetItemCount(self.AmmoItem) > 0 then
			local iitem = inv:HasItem(self.AmmoItem)
			if !iitem.isTool then
				if iitem:GetData("stacks", 1) > 1 then
					iitem:SetData("stacks", iitem:GetData("stacks") - 1)
				else
					iitem:Remove()
				end
				self:EmitSound("weapons/weapon_handling_2.wav")
				self:SetAmmo(100)
			end
		end
	end
	
	self.NextReload = CurTime() + 0.5
	
end

function ENT:Think()

	if self.RotationBone == nil then
		self.RotationBone = self.Entity:LookupBone("ognemet_rotation_1")
	else
		self.Entity:ManipulateBoneAngles(self.RotationBone, self:GetGunAng())
	end
		
	if self.RotationBone2 == nil then
		self.RotationBone2 = self.Entity:LookupBone("ognemet_rotation_2")
	else
		self.Entity:ManipulateBoneAngles(self.RotationBone2, self:GetGunAng2())
	end
	
	self:NextThink( CurTime() )
	return true
	
end
