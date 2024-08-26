resource.AddFile("materials/metromod/metromask2.vmt")
resource.AddFile("sound/metromod/gmse2.wav")
sounds = {}

if SERVER then
	util.AddNetworkString( "DeployMask" )
	util.AddNetworkString( "RemoveMask" )
	util.AddNetworkString( "WipeMask" )	
	util.AddNetworkString( "ClearMask" )	
	util.AddNetworkString( "WipeMaskHud" )
	util.AddNetworkString( "SwapFilter" )
	util.AddNetworkString( "AddShitOnScreengasmask" )
	
	util.AddNetworkString( "UseMedkit" )
	
	util.AddNetworkString( "MetroHudCheck" )
	
	net.Receive( "SwapFilter", function(len, ply)

		local ply = ply
		local char = ply:GetCharacter()
		local inv = char:GetInventory()
		
		local GasmaskOn = ply:GetNetVar("gasmask_on", false)
	
		local item = inv:HasItem("gasmask_filter")
		
		if GasmaskOn and item then
			if IsValid(ply:GetActiveWeapon()) then 
				local wep = ply:GetActiveWeapon():GetClass()
				ply.gasmask_lastwepon = wep
			end
			
			ply:Give("metro_gasmask_filter_swap")
			ply:SelectWeapon( "metro_gasmask_filter_swap" )
			
			if ply.gasmask_item != nil then
				ply.gasmask_item:SetData("filter", item:Health())
				print("ww")
			end
			
			item:Remove()
		end
		
	end)
	
	net.Receive( "WipeMask", function(len, ply)
	
		local ply = ply
		if IsValid(ply:GetActiveWeapon()) then 
			local wep = ply:GetActiveWeapon():GetClass()
			ply.gasmask_lastwepon = wep
		end
		
		ply:Give("metro_gasmask_wipe")
		ply:SelectWeapon( "metro_gasmask_wipe" )
			
	end)
	
end

hook.Add("DoPlayerDeath","DoPlayerDeathMetroModCyka",function( ply, attacker, dmginfo )

	timer.Remove("MMFX"..ply:SteamID())
	if sounds[ply:SteamID()] then
		sounds[ply:SteamID()]:Stop()
	end
	
	ply:SetNetVar("gasmask_on", false)
	ply.gasmask_item = nil
	
	net.Start("RemoveMask")
		
	net.Send(ply)
	
end)

local function DropStuffOnScreen(dist, damage, attacker, types)
	if types == "red" then
			if dist < 100 then
				for i = 1, math.Round(damage/30) do
					net.Start( "AddShitOnScreengasmask" )								
						net.WriteString("blooddrop")
					net.Send(attacker)	
				end
			end
			if dist < 80 and damage >= 20 then
				for i = 1, math.Round(damage/80) do
					net.Start( "AddShitOnScreengasmask" )								
						net.WriteString("bloodsplat")
					net.Send(attacker)	
				end
			end
	elseif types == "yellow" then
			if dist < 80 and damage >= 20 then
				for i = 1, math.Round(damage/50) do
					net.Start( "AddShitOnScreengasmask" )								
						net.WriteString("ybloodsplat")
					net.Send(attacker)	
				end
			end
	end
end

hook.Add("EntityTakeDamage", "EntityTakeDamageMetro", function(trg, dmg)
		if dmg:GetDamage() > 1 and dmg:GetAttacker():IsPlayer() then
			local tr = dmg:GetAttacker():GetEyeTrace()
			local dist = dmg:GetAttacker():GetShootPos():Distance(trg:GetPos())
			local damage = dmg:GetDamage()
			local attacker = dmg:GetAttacker()
			local GasmaskOn = attacker:GetNetVar("gasmask_on", false)
			--print(damage)
			if GasmaskOn then
				if trg:GetBloodColor() == BLOOD_COLOR_RED then		
					DropStuffOnScreen(dist, damage, attacker, "red")
				elseif trg:GetBloodColor() == BLOOD_COLOR_YELLOW or trg:GetBloodColor() == BLOOD_COLOR_GREEN or trg:GetBloodColor() == BLOOD_COLOR_ZOMBIE or trg:GetBloodColor() == BLOOD_COLOR_ANTLION then
					DropStuffOnScreen(dist, damage, attacker, "yellow")
				end
			end
		end
end)

--set true to protect from
local dmgs = {
	DMG_ACID, 
	DMG_POISON, 
	DMG_NERVEGAS,
	DMG_RADIATION
}

hook.Add("EntityTakeDamage","EntityTakeDamageMetroGasmaskmod",function( target, dmginfo )
	local damagetaken = dmginfo:GetDamage()
	local dmgtype = dmginfo:GetDamageType()
	
	local take_dmg = false

	for k, v in pairs(dmgs) do
		if dmginfo:IsDamageType(v) then take_dmg = true break end
	end
	
	if target:IsPlayer() then
		local GasmaskOn = target:GetNetVar("gasmask_on", false)
		local item = target.gasmask_item
		if !take_dmg then
			local ply = target
				if GasmaskOn and math.random(1,2) == 2 then
					item:Damage(damagetaken)
				end
		elseif take_dmg then
			local ply = target
			if GasmaskOn and item:GetFilter() > 0 then
			
				if ply.FilterDown == nil or ply.FilterDown < CurTime() then
					item:DamageFilter(1)
					ply.FilterDown = CurTime() + 1
				end
	
				return true
			end
		end
	end
	
end)

hook.Add( "PlayerPostThink", "PlayerPostThinkGasmaskHandleKeysShitBlyat", function(ply)

	if ply.gasmask_item != nil and IsValid(ply.gasmask_item) then
		local maskhlth = ply.gasmask_item:Health()
		if maskhlth <= 0 and ply:GetNWBool("MetroGasmask") == true then

			timer.Remove("MMFX"..ply:SteamID())
			if not sounds[ply:SteamID()] then return end
			sounds[ply:SteamID()]:Stop()
			ply:SetNetVar("gasmask_on", false)
			ply.gasmask_item = nil
			
			local wep = ply:GetActiveWeapon()
			client.gasmask_lastwepon = wep:GetClass()
				
			ply:Give("metro_gasmask_holster")
			ply:SelectWeapon( "metro_gasmask_holster" )
				
			net.Start("RemoveMask")
				
			net.Send(client)
			
		end
	end
	
end)

hook.Add("PlayerDisconnected", "MMPlayerLeave", function(ply)
	if ply != nil then
		if timer.Exists( "MM"..ply:SteamID() ) then
			timer.Remove("MM"..ply:SteamID())
			sounds[ply:SteamID()]:Stop()
		end
	end
end)
