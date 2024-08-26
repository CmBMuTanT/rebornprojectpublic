if SERVER then
	
	hook.Add( "PlayerSpawn", "PlayerSpawnFlashlihgt", function (ply)
		ply:SetNWInt("FlashlightEnergy", 0)
		ply:SetNWBool("Flashlight2", false)
	end)

	hook.Add( "PlayerPostThink", "PlayerPostThinkMetroF", function(ply) 
		--print(ply:GetVelocity():Length())

		if ply:GetNWBool("Flashlight2") == true then
			if ply:GetNWInt("FlashlightEnergy") > 0 and ply:GetNWInt("FlashlightEnergyDown") < CurTime() then
				ply:SetNWInt("FlashlightEnergy", ply:GetNWInt("FlashlightEnergy") - 1)
				ply:SetNWInt("FlashlightEnergyDown", CurTime() + 1)
			elseif ply:GetNWInt("FlashlightEnergy") <= 0 then
				ply:SetNWBool("Flashlight2", false)
			end
		end

	end)
	
	hook.Add( "PlayerSwitchFlashlight", "PlayerSwitchFlashlightMetro", function(ply, bool) 
		if ply:Alive() then
			if ply:GetNWInt("FlashlightEnergy") > 0 then
				ply:SetNWBool("Flashlight2", !ply:GetNWBool("Flashlight2"))
			end
			ply:EmitSound("items/flashlight1.wav")
		end
		return false
	end)

end

if CLIENT then
	local matBeam = Material("effects/lamp_beam")
	local flashlerp = Vector(0,0,0)
	local flashlerpang = Angle(0,0,0)
	local flashdel = 0

	local light = nil

hook.Add( "PostPlayerDraw", "DrawMetroFlashlight", function(ply) 
	if ply:GetNWBool("Flashlight2") == true then
	
		local flash_percentage = ((ply:GetNWInt("FlashlightEnergy") - 0)/(1800-0)*100)
		flash_percentage = flash_percentage /100
		
			local b = ply:LookupBone("ValveBiped.Bip01_R_Hand")
			if not b then return end
			local m = ply:GetBoneMatrix( b )
			if not m then return end
			
		local fpos, fang = m:GetTranslation(), m:GetAngles()
		
		local tr = ply:GetEyeTrace()
		local dist = math.Clamp( fpos:Distance(tr.HitPos), 0, 100 )
		
		render.SetMaterial( matBeam )
		render.DrawBeam( fpos, fpos + fang:Forward()*dist, 25, 1, 1.95, Color(255, 255, 100+(100*flash_percentage), 25*flash_percentage) ) 
		
	end
	
end)

hook.Add( "HUDPaint", "FlashlightHUDPaint", function() 

	local ply = LocalPlayer()
		local flash_percentage = ((ply:GetNWInt("FlashlightEnergy") - 0)/(1800-0)*100)
		flash_percentage = flash_percentage /100
		
	if ply:Alive() and ply:GetNWBool("Flashlight2") == true then
		if light == nil then
			light = ProjectedTexture()
			light:SetTexture( "effects/flashlight001" )
			light:SetEnableShadows( true )
			light:SetFOV(60)
		end
		
		local Icon = Material("icons/lamp_on.png")
		surface.SetDrawColor( Color(255, 50+(150*flash_percentage), 50+(150*flash_percentage)))
		surface.SetMaterial( Icon )
		surface.DrawTexturedRect( ScrW() / 1.05, ScrH() /  1.7, 50, 50 )


		light:SetFarZ(500+(212*flash_percentage))
		light:SetBrightness(4*flash_percentage)
		light:SetColor(Color(255, 255, 100+(100*flash_percentage)))		
		light:SetPos( ply:GetShootPos() + Vector(0,0,-15) +ply:GetAimVector()*5 )
		light:SetAngles( ply:EyeAngles() )
		light:Update()
	else
		if light != nil then
			light:Remove()
			light = nil
		end
	end
	
end)

end