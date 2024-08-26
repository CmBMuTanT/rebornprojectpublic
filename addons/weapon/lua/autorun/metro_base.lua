
AddCSLuaFile()
AddCSLuaFile( "metro_base_menus.lua" )

CreateClientConVar( "metro_sight_toggle", 0, true, true )

offhand_stuff = {
	["zhiga"] = {
		vmodel = "models/weapons/zhiga/v_zhiga.mdl",
		single_use = false,
		deploy_func = function(ply, vm)
			ply:EmitSound("weapons/light_fast_start.wav")
		end,
		holster_func = function(ply)
			ply:EmitSound("weapons/light_fast_stop.wav")	
		end,
		deploy_check = function(ply)
			return true
		end
	},
	["pnv"] = {
		vmodel = "models/weapons/pnv/v_pnv.mdl",
		single_use = true,
		use_time = 1,
		holster = false,
		deploy_func = function(ply, vm)
			local pnv = ply:GetNWBool("pnv_on")
			
			if pnv then
				vm:SendViewModelMatchingSequence( vm:SelectWeightedSequence( ACT_VM_HOLSTER ) )
				ply:SetNWBool("pnv_on", false)
			else
				vm:SendViewModelMatchingSequence( vm:SelectWeightedSequence( ACT_VM_DRAW ) )
				timer.Simple(0.5, function()
					ply:SetNWBool("pnv_on", true)
				end)
			end
			
		end,
		holster_func = function(ply)
		
		end,
		deploy_check = function(ply)
			return true
		end
	}
}

if SERVER then

	util.AddNetworkString("SetAttachment")
	util.AddNetworkString("DeployOffhand")
	util.AddNetworkString("HolsterOffhand")

	function OpenZhiga(ply)
		
		if ply.current_offhand == nil then return end
		
		local vm = ply:GetViewModel(1)
		local shitdata = offhand_stuff[ply.current_offhand]
		local model = shitdata.vmodel

		vm:SetWeaponModel( model, ply:GetActiveWeapon() )
		vm:SendViewModelMatchingSequence( vm:SelectWeightedSequence( ACT_VM_DRAW ) )
		vm:SetPlaybackRate(1)
		ply.zhiga_open = true
		
		shitdata.deploy_func(ply, vm)
		
		if shitdata.single_use then
			
			timer.Simple(shitdata.use_time, function()
			
				ply.offhand_single_use = false
				ply.current_offhand = nil
				ply.next_current_offhand = nil
				
				if shitdata.holster then
				
					CloseZhiga(ply)
					
				else
				
					ply.zhiga_open = false	
					ply.zhiga_nxt_wep = nil
					vm:SetWeaponModel( "", ply:GetActiveWeapon() )
					ply.zhiga_deploy = false
					ply.zhiga_holster = false
					ply:SetNWBool("offhand_on", false)	
					
				end
				
			end)
		end
		
	end
	
	function CloseZhiga(ply)
	
		if not ply.zhiga_open then return end
		
		local shitdata = offhand_stuff[ply.current_offhand]
		local vm = ply:GetViewModel(1)
		vm:SendViewModelMatchingSequence( vm:SelectWeightedSequence( ACT_VM_HOLSTER ) )
		vm:SetPlaybackRate(1)
		ply.zhiga_open = false	
		ply.zhiga_holster = true
		ply.zhiga_nxt_wep = nil
		ply.zhiga_holster_time = CurTime() + 0.5
		shitdata.holster_func(ply)
		
	end

	function SelectOffhand(ply, item)
		ply.current_offhand = item
		ply.next_current_offhand = nil
		ply.zhiga_holster = false
		ply.zhiga_deploy = true
		ply.zhiga_open = true
		ply.zhiga_deploy_time = CurTime() + 0.3
		ply:SetNWBool("offhand_on", true)
	end

	net.Receive( "DeployOffhand", function( len, ply )
		
		local bool = net.ReadBool()
		local float = net.ReadFloat()
		local str = net.ReadString()
		print(str)
		local shitdata = offhand_stuff[str]
		
		if shitdata.deploy_check(ply) then
		
			ply.offhand_single_use = shitdata.single_use
		
			if !ply.zhiga_open then
			
				SelectOffhand(ply, str)
				
			elseif ply.zhiga_open then
				
				CloseZhiga(ply)
				
				if float != 0 then
					ply.zhiga_holster_time = CurTime() + float
					local vm = ply:GetViewModel(1)
					vm:SetPlaybackRate(4)
				end
				--print(ply.current_offhand)
				if ply.current_offhand != str then
					ply.next_current_offhand = str
					--ply.current_offhand = nil
				end
				
			end
		end
		
	end)
	
	net.Receive( "HolsterOffhand", function( len, ply )
		
		local bool = net.ReadBool()
		local float = net.ReadFloat()
		local str = net.ReadString()
		
		if !ply.zhiga_open then return end
		
		CloseZhiga(ply)
		
		if float != 0 then
			ply.zhiga_holster_time = CurTime() + float
			local vm = ply:GetViewModel(1)
			vm:SetPlaybackRate(4)
		end
		
	end)

	hook.Add("EntityFireBullets", "MetroZhigaEntityFireBullets", function(ent, data)
		if ent:IsPlayer() and ent.zhiga_open then
			--print("gei")
			data.Spread = data.Spread * 2
			return true
		end
	end)

	hook.Add("PlayerSwitchWeapon", "MetroZhigaPlayerSwitchWeapon", function(ply, from, to)
		
		if ply.offhand_single_use then return true end
		
		local zhiga_vm = ply:GetViewModel(1)
		if ply.zhiga_open then
			CloseZhiga(ply)
			ply.zhiga_holster = true
			ply.next_current_offhand = nil
			ply.zhiga_nxt_wep = to:GetClass()
			ply.zhiga_holster_time = CurTime() + 0.5
			return true
		end
	end)
	
	local tst = false
	
	hook.Add("PlayerPostThink", "MetroZhigaPlayerPostThink", function(ply)
	
		if ply:Alive() then
			if ply.zhiga_deploy and ply.zhiga_deploy_time < CurTime() then
				OpenZhiga( ply )
				ply.zhiga_deploy = false
			end
			
			if ply.zhiga_holster and ply.zhiga_holster_time < CurTime() then
				if ply.zhiga_nxt_wep != nil then
                   print(ply.zhiga_nxt_wep)
					--ply:SelectWeapon(ply.zhiga_nxt_wep)
                    ply.zhiga_nxt_wep = nil
				end
						
				ply.zhiga_holster = false
				ply.zhiga_open = false
				ply.current_offhand = nil
				
				if ply.next_current_offhand != nil then
					SelectOffhand(ply, ply.next_current_offhand)
				else
					ply:SetNWBool("offhand_on", false)	
				end
				
			end

		end
		
	end)
	
	hook.Add("DoPlayerDeath","DoPlayerDeathMetroZhiga",function( ply, attacker, dmginfo )
		ply:SetNWBool("offhand_on", false)	
		ply:SetNWBool("pnv_on", false)
		ply.zhiga_open = false
		ply.zhiga_deploy = false
		ply.zhiga_holster = false
		ply.zhiga_nxt_wep = nil
		ply.current_offhand = nil
	end)
	
	hook.Add( "PlayerButtonUp", "ButtonUpMetro", function( ply, button )
		--[[if button == KEY_B then
			local wep = ply:GetActiveWeapon()
			if not IsValid(wep) then return end
			if wep.Base == "metro_base" or wep:GetClass() == "metro_base" then
				wep:SetSafe( !wep:GetSafe() )
				wep:SetNextPrimaryFire( CurTime() + 0.1 )
			end
		end]]--
	end)
	
end

hook.Add( "SetupMove", "Metro_SetupMove", function( ply, mvd, cmd )
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end
		if wep.Base == "metro_base" or wep:GetClass() == "metro_base" then
			--wep.mouse_y_delta = cmd:GetMouseY()
			--wep.mouse_x_delta = cmd:GetMouseX()
		end
end )

if CLIENT then

	local nxt_zhiga = 0
	local zhiga_vm = nil
	
	local zhiga_mul = 0
	
	local hmod = 0
	local old_ang = Angle(0,0,0)
	local new_ang = Angle(0,0,0)
	
	local function zhiga_effect(pos, ang)
	
		local FT = FrameTime()
	
		local ply = LocalPlayer()
		local emitter = ply.zhiga_emitter
		
		local ang_delta = ply:EyeAngles() - old_ang
		old_ang = ply:EyeAngles()
		new_ang = LerpAngle( FT*6, new_ang, ang_delta )
		
		if math.random( 1, 5 ) == 1 then
			local particle = emitter:Add( "effects/smoke/smoke_particle_"..math.Rand(1, 5), pos + ang:Forward()*1.3 )
			particle:SetVelocity( 10 * VectorRand() )
			particle:SetAirResistance( 400 )
			particle:SetGravity( Vector(0, 0, math.Rand(25, 50) ) )
			particle:SetDieTime( math.Rand( 4, 5 ) )
			
			particle:SetStartAlpha( math.Rand( 1, 3 ) )
			particle:SetEndAlpha( 0 )
			
			particle:SetStartSize(0)
			particle:SetEndSize(7)
			
			particle:SetRoll( math.Rand( 0, 1 ) )
			particle:SetRollDelta( 0.1 )	
		end
		
		ang:RotateAroundAxis(ang:Right(), ply:EyeAngles().pitch)
		ang:RotateAroundAxis(ang:Up(), new_ang.y*-5)
		
		cam.Start3D()
			cam.Start3D2D( pos+ang:Right()*-3.2 + ang:Forward()*-1.5, ang, 0.1 )
			
				--hmod = math.Clamp(ply:EyeAngles().pitch, -256, 256)
				
				--local flamepos = pos:ToScreen()
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetTexture( surface.GetTextureID("effects/fire/zhiga_flame") )
				surface.DrawTexturedRectRotated( 32, 32, 64, 64, -90 )

			cam.End3D2D()
		cam.End3D()			
	end
	
	local tab = {
		[ "$pp_colour_addr" ] = 0,
		[ "$pp_colour_addg" ] = 0.5,
		[ "$pp_colour_addb" ] = 0,
		[ "$pp_colour_brightness" ] = 0,
		[ "$pp_colour_contrast" ] = 2,
		[ "$pp_colour_colour" ] = 0.2,
		[ "$pp_colour_mulr" ] = 0,
		[ "$pp_colour_mulg" ] = 0,
		[ "$pp_colour_mulb" ] = 0
	}
	
	local function draw_nv()
		local ply = LocalPlayer()
		
		local dynlight = DynamicLight(ply:EntIndex())
		dynlight.Pos = ply:GetShootPos()
		dynlight.Size = 1024
		dynlight.Decay = 2000
		dynlight.R = 0
		dynlight.G = 255
		dynlight.B = 0
		dynlight.Brightness = 2
		dynlight.DieTime = CurTime() + 0.1
		
		DrawColorModify( tab ) 
		
		draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color(0, 255, 0, 25 ) )	
	
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetTexture( surface.GetTextureID("ui_nv") )
		surface.DrawTexturedRectRotated( ScrW()/2, ScrH()/2, ScrW(), ScrH(), 0 )
	end

	hook.Add("HUDPaint", "MetroZhiga", function()
	
		local ply = LocalPlayer()
		local vm = ply:GetViewModel(0)
		local wep = ply:GetActiveWeapon()
		
		if wep.zhiga_hand_bone != nil then
			if ply:Alive() and nxt_zhiga < CurTime() and wep:GetNextPrimaryFire() < CurTime() then
				if input.IsKeyDown( KEY_M ) and !vgui.CursorVisible() then
					net.Start( "DeployOffhand" )
						net.WriteBool(true)
						net.WriteFloat(0)
						net.WriteString("zhiga")
					net.SendToServer()
					if ply:GetNWBool("zhiga_on") == true then
						nxt_zhiga = CurTime()+1
					else
						nxt_zhiga = CurTime()+0.6
					end
				end
			end
			
			if ply:Alive() and nxt_zhiga < CurTime() and ( wep:GetNextPrimaryFire()-0.3 > CurTime() ) then
				net.Start( "HolsterOffhand" )
					net.WriteBool(false)
					net.WriteFloat(0.1)
				net.SendToServer()
				nxt_zhiga = CurTime()+1		
			end
			
		end
		--if zhiga_vm != nil then
			
		--end		
		
		if ply:GetNWBool("offhand_on") == true then
			zhiga_mul = Lerp(FrameTime() * 20, zhiga_mul, 1)
			
			local vm = ply:GetViewModel(1)
			local att = vm:GetAttachment(1)
			if att == nil then return end
			local pos = att.Pos
			local ang = att.Ang
			
			if ply.zhiga_emitter == nil then
				ply.zhiga_emitter = ParticleEmitter(pos)
			end
			
			if nxt_zhiga < CurTime() then
			
				zhiga_effect(pos, ang)
				
				local dynlight = DynamicLight(ply:EntIndex())
				dynlight.Pos = pos + ang:Forward()*1.3
				dynlight.Size = 256
				dynlight.Decay = 2000
				dynlight.R = 255
				dynlight.G = 180
				dynlight.B = 50
				dynlight.Brightness = 2
				dynlight.DieTime = CurTime() + 0.1
			end
		else
			zhiga_mul = Lerp(FrameTime() * 20, zhiga_mul, 0)
		end
		
		if wep.zhiga_hand_bone == nil then
			wep.zhiga_hand_bone = vm:LookupBone("l_upperarm")
		end
		
		if wep.zhiga_hand_bone != nil then
			vm:ManipulateBoneAngles(wep.zhiga_hand_bone, Angle(0, -40, -10)*zhiga_mul)
		end
		
	end)
	
	--hook.Add("PostDrawViewModel", "MetroZhigaPostDrawViewModel", function()
	--	if zhiga_vm != nil then
	--		zhiga_vm:DrawModel()
	--	end		
	--end)

	hook.Add( "ContextMenuOpen", "Metro_ContextMenuOpen", function()
		local ply = LocalPlayer()
		ply.inventory = false
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end
		if wep.Base == "metro_base" or wep:GetClass() == "metro_base" then
			if !ply.inventory then
				OpenAttMenu(wep)
			end
			return false
		end
	end )
	
	local old, x, y, ang
	local viewdata = {}
		viewdata.x = 0
		viewdata.y = 0
		viewdata.w = ScrH()
		viewdata.h = ScrH()
		viewdata.fov = 3
		viewdata.drawviewmodel = false
		viewdata.drawhud = false
		viewdata.dopostprocess = true

	local mat_ColorMod = Material( "pp/colour" )

	hook.Add( "RenderScene", "Metro_RenderScene", function()
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end

		if wep.Base == "metro_base" or wep:GetClass() == "metro_base" then
			if !wep.RTSight or !wep:GetAimBool() then return end
			x, y = ScrW(), ScrH()
			old = render.GetRenderTarget()
			
			viewdata.angles = wep.rt_ang
			viewdata.origin = wep.Owner:GetShootPos()
			viewdata.fov = 5
			--DrawColorModify( tab ) 
			render.SetRenderTarget(wep.RTTexture)
			render.SetViewPort(0, 0, ScrH(), ScrH())
				
				if wep.rtfunc then
				
					wep.rtfunc(viewdata, wep)
					
				else
					wep.RTMat:SetVector("$color", Vector(1, 1, 1) )
					render.RenderView(viewdata)
				end
				
			render.SetViewPort(0, 0, x, y)
			render.SetRenderTarget(old)
			
			wep.RTMat:SetTexture("$basetexture", wep.RTTexture)
			--wep.RTMat:SetVector("$color", Vector(1, 1, 1) )

		end
	end )

end
