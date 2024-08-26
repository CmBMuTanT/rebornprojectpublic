
if CLIENT then

surface.CreateFont( "ImpactHUD", {
    font = "Impact",
    extended = true,
    size = 30,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )
 
surface.CreateFont( "ImpactHUD1", {
    font = "Impact",
    extended = true,
    size = 15,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )
 
surface.CreateFont( "ImpactHUD2", {
    font = "Impact",
    extended = true,
    size = 30,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )

surface.CreateFont( "ImpactHUD3", {
    font = "Impact",
    extended = true,
    size = 50,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )

surface.CreateFont( "ImpactHUDFilterText", {
    font = "Impact",
    extended = true,
    size = 25,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )

end

local nv_tab = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0.09,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 3,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

local gasmaskshit = {}
local wipin = 0

local redwipeeffect = 0
local yellowwipeeffect = 0

local wipeeffect = 0

local function HasBloodtype(types)
	if #gasmaskshit > 20 then
		for k, v in pairs(gasmaskshit) do
			if v.types == types then
				return true
			end
		end
	end
end

net.Receive( "WipeMaskHud", function(len)
	local ply = LocalPlayer()
	wipin = CurTime() + 0.3
	timer.Simple(0.1, function()
		--gasmaskshit = {}
		for k, v in pairs(gasmaskshit) do
			if v.types == "blooddrop" then
				--if v.x then v.x = v.x/2 + 128 end--math.random(0,500) end
				if v.y then v.y = v.y*2 end--ScrH() - math.random(0,ScrH()/3) end
				
				v.xmul = math.random(-12,-25) 
				
				if v.ang then v.ang = -math.random(35,90) end
				if v.w then v.w = math.random(70,120) end
				if v.h then v.h = 80 end
				if v.fallmul then v.fallmul = math.random(5,14.5) end
				if v.falltime then v.falltime = 2 end
					if k > 5 then
						if v.fallmul then v.fallmul = math.random(45,50) end
					end
					if k > 10 then
						if v.opacity then v.opacity = v.opacity / 6 end
					end
			else
				if v.opacity then v.opacity = v.opacity / 6 end
				
				if v.y then v.y = v.y + 128 end
				if v.fallmul then v.fallmul = math.random(10,25) end
				v.xmul = math.random(-12,-25) 
					--if k > 20 then
					--	if v.opacity then v.opacity = 5 end
					--end
			end
		end
		if #gasmaskshit > 0 then
			--timer.Simple(0.1, function()
				wipeeffect = CurTime() + 0.3
				if HasBloodtype("blooddrop") then
					redwipeeffect = CurTime() + 0.3
				end
				if HasBloodtype("ybloodsplat") then
					yellowwipeeffect = CurTime() + 0.3
				end
			--end)
		end
	end)
end)

net.Receive( "ClearMask", function(len)
	local ply = LocalPlayer()
	wipin = CurTime() + 0.3
	timer.Simple(0.1, function()
		gasmaskshit = {}
	end)
end)

net.Receive( "AddShitOnScreengasmask", function(len)	

	local types = net.ReadString()
	local newshitonscreen
	
	if types == "cleanin" then
		newshitonscreen = {
			[table.Count(gasmaskshit)] = {opacity = 255, x = math.random(0,ScrW()), y = math.random(0,ScrH()), material = "hobo_gus/glassshit"..math.random(1,3), ang = math.random(0,360), w = 512, h = 512, types = types, fallmul = 1, falltime = 0}
		}
	elseif types == "bloodsplat" then
		local sizerand = math.random(256, 256)
		newshitonscreen = { 
			[table.Count(gasmaskshit)] = {opacity = 255, x = math.random(200,ScrW()-200), y = math.random(ScrH()/2+100,ScrH()/2-300), material = "part/wm_blood_wm"..math.random(1,7), ang = math.random(-12, 12), w = sizerand , h = sizerand, types = types, fallmul = 0.11, falltime = 0 }
		}
	elseif types == "ybloodsplat" then
		local sizerand = math.random(300, 600)
		newshitonscreen = { 
			[table.Count(gasmaskshit)] = {opacity = 155, x = math.random(200,ScrW()-200), y = math.random(ScrH()/2+100,ScrH()/2-300), material = "effects/metro_blood/yscreenblood"..math.random(1,3), ang = math.random(0, 360), w = sizerand , h = sizerand, types = types, fallmul = math.random(0.2, 1), falltime = 0 }
		}
	elseif types == "watersplash" then
		local sizerand = math.random(600, 900)
		newshitonscreen = { 
			[table.Count(gasmaskshit)] = {opacity = 200, x = math.random(100,ScrW()-100), y = math.random(ScrH()/2+100,ScrH()/2-200), material = "particle/water/watersplash_001a_refract", ang = math.random(0, 360), w = sizerand , h = sizerand, types = types, fallmul = math.random(7, 8), falltime = 0 }
		}
	elseif types == "dirt" then
		local sizerand = math.random(300, 600)
		newshitonscreen = { 
			[table.Count(gasmaskshit)] = {opacity = 255, x = math.random(100,ScrW()-100), y = math.random(ScrH()/2+100,ScrH()/2-200), material = "effects/metro_dirt/dirt"..math.random(1,3), ang = math.random(0, 360), w = sizerand , h = sizerand, types = types, fallmul = math.random(0.03, 0.1), falltime = 0 }
		}
	elseif types == "blooddrop" then
		newshitonscreen = { 
			[table.Count(gasmaskshit)] = {opacity = 255, x = math.random(200,ScrW()-200), y = math.random(ScrH()/2+100,ScrH()/2-300), material = "hobo_gus/watershit", ang = 0, w = math.random(35, 95) , h = math.random(30, 90), types = types, fallmul = math.random(0.2, 1.5), falltime = 0 }
		}
	end
	--print(table.Count(shitonscreen))
	table.Add( gasmaskshit, newshitonscreen ) 
end)
	
local weartime = 0
local moist = true

local function SetMoist(bool)
	if moist != bool then
		moist = bool
	end
end
	
local function MaskHUDOverlay()
--DrawLens()
	local ply = LocalPlayer()
	local GasmaskOn = ply:GetNetVar("gasmask_on", false)
	local item = ply.gasmask_item
	
	if GasmaskOn and item != nil then
		local maskhlth = item:Health()
	--surface.SetDrawColor( Color(255,255,255,255) )
		if maskhlth >= 85 then
			DrawMaterialOverlay("morganicism/metroredux/gasmask/metromask1.vmt", 0.1)
			SetMoist(true)
		elseif maskhlth < 85 and maskhlth >= 65 then
			DrawMaterialOverlay("morganicism/metroredux/gasmask/metromask2.vmt", 0.1)
			SetMoist(true)			
		elseif maskhlth < 65 and maskhlth >= 35 then
			DrawMaterialOverlay("morganicism/metroredux/gasmask/metromask3.vmt", 0.1)
			SetMoist(false)
		elseif maskhlth < 35 and maskhlth >= 20 then
			DrawMaterialOverlay("morganicism/metroredux/gasmask/metromask4.vmt", 0.1)
			SetMoist(false)
		elseif maskhlth < 20 and maskhlth >= 10 then
			DrawMaterialOverlay("morganicism/metroredux/gasmask/metromask5.vmt", 0.1)	
			SetMoist(false)
		elseif maskhlth < 10 and maskhlth >= 0 then
			DrawMaterialOverlay("morganicism/metroredux/gasmask/metromask6.vmt", 0.1)
			SetMoist(false)			
		end
		
		if weartime < 0.03 and moist == true then
			weartime = weartime + 0.00001
		elseif weartime > 0 and moist == false then
			weartime = weartime - 0.001
		end
		
		if weartime > 0 then
			DrawMaterialOverlay("effects/ui_maska_moist.vmt", weartime)
		end
	elseif !GasmaskOn and weartime > 0 then
		weartime = 0
	end
	--particle/water/waterdrop_001a_refract
	
	--DrawBloom( 0.15, 1, 9, 50, 5, 0.2, 1, 0, 0 )
	
end

local maskdelay = 0
local nvdelay = 0
local g_down = 0

local wipinop = 0

local filterwarning = false
local wipingafter = 0
local wipeeffect1 = 0

local wipingblood1 = 0
local wipingblood2 = 0

local language = GetConVar("gmod_language")

hook.Add("ChatTextChanged", "ChatTextChangedGasmaskHud", function(txt)
	maskdelay = CurTime() + 0.5
end)

local function HUDShit()

	local GasmaskOn = LocalPlayer():GetNetVar("gasmask_on", false)

	if wipin > CurTime() then
		wipinop = Lerp(FrameTime()*5, wipinop, 1)
	else
		wipinop = Lerp(FrameTime()*5, wipinop, 0)
	end

	if wipeeffect > CurTime() then
		wipingafter = Lerp(FrameTime()*5, wipingafter, 1)
		wipeeffect1 = wipeeffect1 + 0.5
	else
		wipingafter = Lerp(FrameTime()*1, wipingafter, 0)

	end

	if redwipeeffect > CurTime() then
		wipingblood1 = Lerp(FrameTime()*5, wipingblood1, 1)
	else
		wipingblood1 = Lerp(FrameTime()*1, wipingblood1, 0)
	end

	if yellowwipeeffect > CurTime() then
		wipingblood2 = Lerp(FrameTime()*5, wipingblood2, 1)
	else
		wipingblood2 = Lerp(FrameTime()*1, wipingblood2, 0)
	end

	if wipingafter <= 0.1 then
		wipeeffect1 = 0
	end

	--if wipeeffect > CurTime() then
		--DrawMaterialOverlay("particle/water/waterdrop_001a_refract.vmt", 0.01)
		
		surface.SetDrawColor( Color( 255,0,0,250*wipingblood1 ) )
		surface.SetTexture( surface.GetTextureID("particle/water/waterdrop_001a_refract") )	
		surface.DrawTexturedRectRotated( ScrW()/2-wipeeffect1, ScrH()/2+wipeeffect1, ScrW()*2, ScrH(), 150 )

		if HasBloodtype("ybloodsplat") then
			surface.SetDrawColor( Color( 255,255,0,250*wipingblood2 ) )
			surface.SetTexture( surface.GetTextureID("particle/water/waterdrop_001a_refract") )	
			surface.DrawTexturedRectRotated( ScrW()/2-wipeeffect1, ScrH()/2+wipeeffect1, ScrW()*2, ScrH(), 150 )
		end
		surface.SetDrawColor( Color( 255,255,255,255*wipingafter ) )
		surface.SetTexture( surface.GetTextureID("particle/water/waterdrop_001a_refract") )	
		surface.DrawTexturedRectRotated( ScrW()/2-wipeeffect1, ScrH()/2+wipeeffect1, ScrW()*2, ScrH(), 150 )
	--end

	if (GasmaskOn) then
		surface.SetDrawColor( Color(0,0,0,255*wipinop ) )
		surface.SetTexture( surface.GetTextureID("metroui/hud_overlayshit_white") )	
		surface.DrawTexturedRectRotated( ScrW()/2, ScrH()/2,  ScrW() , ScrH() , 0 )
	end
	
	for k, v in pairs(gasmaskshit) do
	--local x, y = pl:GetViewModel():GetPos():ToScreen().x - ScrW()/2, pl:GetViewModel():GetPos():ToScreen().y - ScrH()/2
		if v.types == "waterdrop" then
			surface.SetDrawColor( 255, 255, 255, v.opacity )
			surface.SetTexture( surface.GetTextureID( v.material ) )
			surface.DrawTexturedRectRotated(v.x-v.w/2, v.y, v.w, v.h, v.ang )
			v.opacity = v.opacity - 0.2
			v.y = v.y + v.fallmul
			v.x = v.x+math.sin(CurTime()*1)
			v.ang = math.sin(CurTime()*2)
		elseif v.types == "blooddrop" then
			
			surface.SetDrawColor( 255, 255, 255, v.opacity )
			surface.SetTexture( surface.GetTextureID( "effects/metro_blood/blooddrop1" ) )
			surface.DrawTexturedRectRotated(v.x-v.w/2, v.y, v.w, v.h+v.falltime*0.7, v.ang )
			
			if v.xmul then v.x = v.x + v.xmul v.xmul = Lerp(FrameTime()*4, v.xmul, 0) end
			
			if v.ang != 0 then
				v.y = v.y + math.random(0.1, v.fallmul)
				v.x = v.x -math.random(0, 0.1)
			else
				v.y = v.y + v.fallmul
			end
			
			v.ang = Lerp(FrameTime()*4, v.ang, 0)
			
			v.opacity = v.opacity - 0.1
			v.falltime = v.falltime + 0.4
			
			if v.y > ScrH() + 128 then
				v.opacity = 0
			end
			
			--v.x = v.x+math.sin(CurTime()*0.2/5)
			--v.ang = math.sin(CurTime()*1)
		elseif v.types == "bloodsplat" then
			
			surface.SetDrawColor( 255, 255, 255, v.opacity )
			surface.SetTexture( surface.GetTextureID( v.material ) )
			surface.DrawTexturedRectRotated(v.x, v.y, v.w, v.h+v.falltime, v.ang )					
			
			v.opacity = v.opacity - 0.2
			v.falltime = v.falltime + 0.3
			if v.xmul then v.x = v.x + v.xmul v.xmul = Lerp(FrameTime()*4, v.xmul, 0) end
			v.y = v.y + v.fallmul
			--v.ang = math.sin(CurTime()*1)
		elseif v.types == "dirt" or v.types == "ybloodsplat" or v.types == "watersplash" then
			surface.SetDrawColor( 255, 255, 255, v.opacity )
			surface.SetTexture( surface.GetTextureID( v.material ) )
			surface.DrawTexturedRectRotated(v.x, v.y, v.w, v.h+v.falltime, v.ang )					
			
			v.opacity = v.opacity - 0.2
			v.falltime = v.falltime + 0.3
			if v.xmul then v.x = v.x + v.xmul v.xmul = Lerp(FrameTime()*4, v.xmul, 0) end
			v.y = v.y + v.fallmul
			--v.ang = math.sin(CurTime()*1)				
		
		end
		
		if v.opacity <= 0 then
			table.remove( gasmaskshit, k )
		end
	end

local ply = LocalPlayer()
local item = ply.gasmask_item
local bindkey = KEY_G

	if GasmaskOn and item != nil then
	
		if filterwarning == true then
			if (language:GetString() == "ru") then
				draw.SimpleText("Нажми ", "ImpactHUDFilterText", ScrW()/2 - 110, ScrH()-150, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText("T", "ImpactHUDFilterText", ScrW()/2-65, ScrH()-150, Color( 255, 150, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText("чтобы заменить фильтр.", "ImpactHUDFilterText", ScrW()/2 + 60, ScrH()-150, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
				draw.SimpleText("Press ", "ImpactHUDFilterText", ScrW()/2 - 70, ScrH()-150, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText("T", "ImpactHUDFilterText", ScrW()/2-30, ScrH()-150, Color( 255, 150, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText("to swap a filter.", "ImpactHUDFilterText", ScrW()/2 + 50, ScrH()-150, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )		
			end
		end
	
		if item:GetFilter() <= 30 then
			if filterwarning == false then
				filterwarning = true
				surface.PlaySound( "gasmask/watch_timer_three_beeps.wav" )
				ply:SetNWInt("checkfilter", CurTime() + 5)			
			end
		elseif item:GetFilter() > 30 then
			if filterwarning == true then
				filterwarning = false
			end
		end
	
		if input.IsKeyDown(bindkey) then
			g_down = g_down + 1
		elseif !input.IsKeyDown(bindkey) and g_down > 1 then
			if maskdelay < CurTime() then
				net.Start( "WipeMask" )	
				net.SendToServer()	
				maskdelay = CurTime() + 1				
			end
			g_down = 0
		end
		
		if input.IsKeyDown(KEY_T) and maskdelay <= CurTime() then
			maskdelay = CurTime() + 3.5
			
			net.Start( "SwapFilter" )								
			net.SendToServer() 
		end

	end
	
end

hook.Add("HUDPaintBackground", "DrawGasmaskHud", HUDShit)

hook.Add("RenderScreenspaceEffects", "DrawGasmaskOverlay", MaskHUDOverlay)

local checkgasmask_mul = 0
local checkfilter_mul = 0

local function GasmaskHUD()

local ply = LocalPlayer()
local FT = FrameTime()
local GasmaskOn = ply:GetNetVar("gasmask_on", false)

if GetConVarNumber ( "cl_drawhud" ) == 0 then return end

	if ply:GetNWInt("checkgasmask") > CurTime() then
		checkgasmask_mul = Lerp(FT*4, checkgasmask_mul, 1)
	else
		checkgasmask_mul = Lerp(FT*4, checkgasmask_mul, 0)
	end
	
	if ply:GetNWInt("checkfilter") > CurTime() then
		checkfilter_mul = Lerp(FT*4, checkfilter_mul, 1)
	else
		checkfilter_mul = Lerp(FT*4, checkfilter_mul, 0)
	end
	
	if GasmaskOn then
		local item = ply.gasmask_item
		if item and item:GetFilter() > 0 then 
			surface.SetDrawColor( Color(255,255,255,255*checkfilter_mul) )
			surface.SetTexture( surface.GetTextureID("metroui/filter") )	
			surface.DrawTexturedRectRotated( ScrW() - 480, ScrH()-110,  64 , 64 , 0 )
			
			--draw.RoundedBox( 0, ScrW() - 350, 15, 300, 60, Color( 0, 0, 0, 150 ) )
			local time = string.FormattedTime( item:GetFilter(), "%02i:%02i" )
			draw.SimpleText( time, "ImpactHUD2", ScrW() - 430, ScrH()-110, Color( 255, 255, 255, 255*checkfilter_mul ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		else
			surface.SetDrawColor( Color(255,50,50,255*checkfilter_mul) )
			surface.SetTexture( surface.GetTextureID("metroui/no_filter") )	
			surface.DrawTexturedRectRotated( ScrW() - 480, ScrH()-110,  64 , 64 , 0 )
		end	
	end

end
 
hook.Add("HUDPaint", "GasmaskHUD", GasmaskHUD)

local function GetBoneOrientation( basetab, tab, ent, bone_override )
	
	local bone, pos, ang
	if (tab.rel and tab.rel != "") then
		
		local v = basetab[tab.rel]
		
		if (!v) then return end

		pos, ang = GetBoneOrientation( basetab, v, ent )
		
		if (!pos) then return end 
		
		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			
	else
	
		bone = ent:LookupBone(bone_override or tab.bone)

		if (!bone) then return end
		
		pos, ang = Vector(0,0,0), Angle(0,0,0)
		local m = ent:GetBoneMatrix(bone)
		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end
		
		--if (IsValid(ply) and ply:IsPlayer() and 
			--ent == ply:GetViewModel() and self.ViewModelFlip) then
			--ang.r = -ang.r 
		--end 
	
	end
	
	return pos, ang
end

local creategasmask = ClientsideModel("models/half-dead/metroll/p_mask_1.mdl")
creategasmask:SetNoDraw( true )
local maskpos, maskang


hook.Add( "HUDWeaponPickedUp", "HUDWeaponPickedUpGasmask", function(weapon ) 
	if weapon:GetClass() == "metro_gasmask_wipe" then return false end
	if weapon:GetClass() == "metro_gasmask_holster" then return false end
	if weapon:GetClass() == "metro_gasmask_filter_swap" then return false end
	if weapon:GetClass() == "metro_gasmask_deploy" then return false end
end)

hook.Add( "PostPlayerDraw", "DrawMetroGasmask", function(ply) 

	if not IsValid( ply ) or not ply:Alive() then return end
	
	local GasmaskOn = ply:GetNetVar("gasmask_on", false)
	
	local gasmask = creategasmask--ply:GetNWEntity("gasmask_model_hg")
		local b = ply:LookupBone("ValveBiped.Bip01_Head1")
		if not b then return end
		local m = ply:GetBoneMatrix( b )
		if not m then return end
		
			local attach_id = ply:LookupAttachment( 'eyes' )
			if not attach_id then return end
			local attach = ply:GetAttachment( attach_id )
			if not attach then return end
		maskpos, maskang = attach.Pos, attach.Ang--m:GetTranslation(), m:GetAngles()
		
	if gasmask:IsValid() then
		gasmask:SetPos( ( maskpos + maskang:Forward() * .1 + maskang:Right() * 0 + maskang:Up() * -1.7 ) )
		
			maskang:RotateAroundAxis(maskang:Up(), 90)
			maskang:RotateAroundAxis(maskang:Right(), 0)
			maskang:RotateAroundAxis(maskang:Forward(), 70)

			gasmask:SetAngles(maskang)
			
			if GasmaskOn then			
				
				gasmask:SetRenderAngles( maskang )
				gasmask:SetupBones()
				gasmask:DrawModel()
				gasmask:SetRenderOrigin()
				gasmask:SetRenderAngles()
				
			end
	end
end)

net.Receive( "DeployMask", function(len)

	local ply = LocalPlayer()
	local id = net.ReadInt(32)
	
	local item = ix.item.instances[id]
	ply.gasmask_item = item
	
	--print(id)
	
end)

net.Receive( "RemoveMask", function(len)
	
	local ply = LocalPlayer()
	
	ply.gasmask_item = nil

end)

surface.CreateFont( "Lel", {
	font = "Impact",
	extended = true,
	size = 24,
	weight = 500,
	blursize = 0.1,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )

surface.CreateFont( "Lel2", {
	font = "Impact",
	extended = true,
	size = 26,
	weight = 500,
	blursize = 0.1,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true,
} )

