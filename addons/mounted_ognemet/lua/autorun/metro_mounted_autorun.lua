
hook.Add( "StartCommand", "MountedGuns_StartCommand", function( ply, cmd )

	if ply.UsingAGun then
	
		if ply.GunEnt != nil and IsValid(ply.GunEnt) then
		
			if cmd:KeyDown(IN_ATTACK) then
				ply.GunEnt:FireGun(ply)
				--if CLIENT then cmd:RemoveKey(IN_ATTACK) end	--due to this being removed on client before it gets sent to the server everything stops working properly
			end
			
			if cmd:KeyDown(IN_RELOAD) then
				ply.GunEnt:ReloadGun(ply)
				--if CLIENT then cmd:RemoveKey(IN_ATTACK2) end
			end

		end
	end
	
end)

if SERVER then

util.AddNetworkString("UseMountedGun")

function UseMountedGun(ply, gun)

	ply.NextMntGunUse = CurTime() + 0.1
	ply.UsingAGun = true
	ply.GunEnt = gun
	gun.EyeAng = ply:EyeAngles()
	gun.InUse = true
	
	gun:SetOwner( ply )
	
	net.Start("UseMountedGun")
		net.WriteBool(true)
		net.WriteEntity(gun)
	net.Send(ply)
	
end

function ResetMount(ply)

	net.Start("UseMountedGun")
		net.WriteBool(false)
		net.WriteEntity(nil)
	net.Send(ply)

	ply.NextMntGunUse = CurTime() + 0.1
	ply.UsingAGun = false
	if ply.GunEnt and IsValid(ply.GunEnt) then ply.GunEnt.InUse = false end--ply.GunEnt:SetOwner( nil )
	ply.GunEnt = nil
	
end

hook.Add( "SetupMove", "MountedGuns_SetupMove", function( ply, mvd, cmd )
	
	if ply.UsingAGun then
		if ply.GunEnt != nil and IsValid(ply.GunEnt) then
			
			cmd:ClearMovement()
			cmd:ClearButtons()

			local wep = ply:GetActiveWeapon()

			--hacky
			if wep and IsValid(wep) then
				wep:SetNextPrimaryFire( CurTime()+0.3 )
				wep:SetNextSecondaryFire( CurTime()+0.3 )
			end
			
			mvd:SetButtons( bit.band( mvd:GetButtons(), bit.bnot( IN_JUMP ) ) )
			
			--mvd:SetMaxClientSpeed( 0 )
			mvd:SetVelocity(Vector(0,0,0))

			local ang = Angle( math.Clamp(ply.GunEnt:GetGunAng().p+cmd:GetMouseX()*0.02, -45, 45), 0, 0)
			local ang2 = Angle(0, math.Clamp(ply.GunEnt:GetGunAng2().y+cmd:GetMouseY()*0.01, -15, 15), 0)
			ply.GunEnt:SetGunAng(ang)
			ply.GunEnt:SetGunAng2(ang2)
			
			if ply.NextMntGunUse < CurTime() and ( mvd:KeyDown(IN_USE) or ply.GunEnt:GetPos():Distance(ply:GetShootPos()) > 65 ) then
				ResetMount(ply)
			end
			
		elseif ply.GunEnt == nil or !IsValid(ply.GunEnt) or !ply:Alive() then
			ResetMount(ply)
		end
	end
	
end)

end

if CLIENT then

	hook.Add( "PreDrawViewModel", "MGPreventViewModel", function(vm, ply, wep)
		local ply = LocalPlayer()
		
		if ply.UsingAGun then
			return true
		end
		
	end)

	hook.Add( "InputMouseApply", "MGFreezeTurning", function( cmd )
	
		local ply = LocalPlayer()
		
		if ply.UsingAGun and !input.IsMouseDown(MOUSE_RIGHT) then
		
			cmd:SetMouseX( 0 )
			cmd:SetMouseY( 0 )
			return true
			
		end
		
	end)

	hook.Add( "PlayerBindPress", "MGPlayerBindPress", function( ply, bind, pressed )

		if ply:IsPlayer() and ply:Alive() then
			if ply.UsingAGun then
				if ( bind == "invprev" ) then
					return true
				elseif ( bind == "invnext") then
					return true
				end
			end
		end
		
	end)

	net.Receive("UseMountedGun", function()
		local start = net.ReadBool()
		local gun = net.ReadEntity()
		
		local ply = LocalPlayer()
		
		if start then
			ply.UsingAGun = true
			ply.GunEnt = gun
		else
			ply.UsingAGun = false
			ply.GunEnt = nil	
		end
		
	end)
end

print("mounted_metro")
