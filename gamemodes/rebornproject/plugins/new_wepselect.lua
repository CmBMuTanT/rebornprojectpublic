PLUGIN.Author = "Dobytchick - IX Porting \n Some author - selector"
PLUGIN.Name = "New WeaponSelector"
PLUGIN.Description = ""

if CLIENT then
    hook.Add("ShouldDrawCrosshair", "DCROSS", function() return false end)
    hook.Add("ShouldHideBars", "DBARS", function() return false end)
    hook.Add("ShouldBarDraw", "DBARS", function(bar) return false end)

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

    --эти две можно использовать чтоб поменять положение худа на экране
    local x_off = 416 -- 416
    local y_off = 320-- 320

    local max_weapons = 2
    local max_weps_base = "tfa_bash_base"

    local weapon_offsets = {
        ["weapon_crowbar"] = {pos = Vector(0, 0, 0), ang = Angle(-5, -30, 0), scale_mul = 0.1 },
        ["weapon_ar2"] = {pos = Vector(0, 8, 0), ang = Angle(2, -40, 25), scale_mul = 0.08 },
        ["weapon_smg1"] = {pos = Vector(0, -8, 0), ang = Angle(-5, -30, 30), scale_mul = 0.12 },
        ["weapon_physcannon"] = {pos = Vector(0, 18, 8), ang = Angle(-5, -30, 30), scale_mul = 0.06 },
        ["weapon_physgun"] = {pos = Vector(0, 18, 8), ang = Angle(-5, -30, 30), scale_mul = 0.06 },
        ["weapon_passchecker"] = {pos = Vector(0, 9, -10), ang = Angle(0, -30, 30), scale_mul = 0.11 },
        ["weapon_357"] = {pos = Vector(0, 9, 3), ang = Angle(0, -30, 30), scale_mul = 0.11 },
        ["weapon_pistol"] = {pos = Vector(0, -5, 0), ang = Angle(-8, -30, 30), scale_mul = 0.18 },
        ["weapon_crossbow"] = {pos = Vector(0, 14, 0), ang = Angle(-5, -30, 30), scale_mul = 0.06 },
        ["tfa_metro_doublet"] = {pos = Vector(-10, 20, 1), ang = Angle(-5, -30, 25), scale_mul = 0.08},
        ["tfa_metro_doublet_donate"] = {pos = Vector(-10, 20, 1), ang = Angle(-5, -30, 25), scale_mul = 0.08},
        ["tfa_metro_doublet_group"] = {pos = Vector(-10, 20, 1), ang = Angle(-5, -30, 25), scale_mul = 0.08},
        ["tfa_metro_saiga"] = {pos = Vector(-30, -5, -12), ang = Angle(-9, -30, 30), scale_mul = 0.1},
        ["tfa_metro_vsv"] = {pos = Vector(-65, -20, -60), ang = Angle(-7, -30, 25), scale_mul = 0.12},
        ["tfa_metro_rpk"] = {pos = Vector(-17, 20, 1), ang = Angle(-5, -30, 25), scale_mul = 0.07},
        ["tfa_metro_bastard"] = {pos = Vector(-15, 25, -6), ang = Angle(-7, -30, 25), scale_mul = 0.07},
        ["tfa_metro_bastard_sup"] = {pos = Vector(-15, 25, -6), ang = Angle(-7, -30, 25), scale_mul = 0.07},
        ["tfa_metro_bastard_group"] = {pos = Vector(-15, 25, -6), ang = Angle(-7, -30, 25), scale_mul = 0.07},
        ["tfa_metro_bastard_sup_group"] = {pos = Vector(-15, 25, -6), ang = Angle(-7, -30, 25), scale_mul = 0.07},
        ["tfa_metro_bastard_sup_donate"] = {pos = Vector(-15, 25, -6), ang = Angle(-7, -30, 25), scale_mul = 0.07},
        ["tfa_metro_aks74u"] = {pos = Vector(-3, -50, -5), ang = Angle(-7, -30, 25), scale_mul = 0.09},
        ["tfa_metro_aks74u_group"] = {pos = Vector(-3, -50, -5), ang = Angle(-7, -30, 25), scale_mul = 0.09},
        ["tfa_metro_aks74u_ohrana"] = {pos = Vector(-3, -50, -5), ang = Angle(-7, -30, 25), scale_mul = 0.09},
        ["tfa_metro_kalash"] = {pos = Vector(-65, -20, -50), ang = Angle(-7, -30, 25), scale_mul = 0.1},
        ["tfa_metro_kalash_ohrana"] = {pos = Vector(-65, -20, -50), ang = Angle(-7, -30, 25), scale_mul = 0.1},
        ["tfa_metro_rpk"] = {pos = Vector(-17, 20, 1), ang = Angle(-5, -30, 25), scale_mul = 0.07},
        ["tfa_metro_padnok"] = {pos = Vector(-10, 0, -5), ang = Angle(-1, -40, 25), scale_mul = 0.2 },
        ["tfa_metro_padnok_ohrana"] = {pos = Vector(-10, 0, -5), ang = Angle(-1, -40, 25), scale_mul = 0.2 },
        ["tfa_metro_padnok_mod"] = {pos = Vector(-10, 0, -5), ang = Angle(-1, -40, 25), scale_mul = 0.2 },
        ["tfa_metro_padnok_mod_donate"] = {pos = Vector(-10, 0, -5), ang = Angle(-1, -40, 25), scale_mul = 0.2 },
        ["tfa_metro_padnok_sup"] = {pos = Vector(-10, 0, -5), ang = Angle(-1, -40, 25), scale_mul = 0.2 },
        ["tfa_metro_revolver"] = {pos = Vector(-30, 10, -30), ang = Angle(1, -40, 25), scale_mul = 0.2 },
        ["tfa_metro_revolverkatya"] = {pos = Vector(-30, 10, -30), ang = Angle(1, -40, 25), scale_mul = 0.2 },
        ["tfa_metro_revolver_sup"] = {pos = Vector(-30, 10, -30), ang = Angle(1, -40, 25), scale_mul = 0.2 },
        ["tfa_metro_kalashscoped"] = {pos = Vector(-65, -20, -50), ang = Angle(-7, -30, 25), scale_mul = 0.1},
        ["tfa_metro_flamethrower"] = {pos = Vector(-70, 0, -30), ang = Angle(-5, -32, 0), scale_mul = 0.08},
        ["tfa_metro_gatling"] = {pos = Vector(-15, 0, 0), ang = Angle(0, -45, 0), scale_mul = 0.06},
        ["tfa_metro_railgun"] = {pos = Vector(-60, 10, -45), ang = Angle(-6, -35, 25), scale_mul = 0.11},
        ["tfa_metro_helsing"] = {pos = Vector(-35, 0, -30), ang = Angle(-4, -35, 0), scale_mul = 0.11},
        ["tfa_metro_helsing_donate"] = {pos = Vector(-35, 0, -30), ang = Angle(-4, -35, 0), scale_mul = 0.11},
        ["tfa_metro_tihar"] = {pos = Vector(-40, 20, -25), ang = Angle(-5, -35, 30), scale_mul = 0.1},
        ["tfa_metro_preved"] = {pos = Vector(-75, 20, -30), ang = Angle(-5, -30, 25), scale_mul = 0.06},
        ["tfa_metro_prevedscoped"] = {pos = Vector(-75, 20, -30), ang = Angle(-5, -30, 25), scale_mul = 0.06},
        ["tfa_metro_ventil"] = {pos = Vector(-69, 0, -45	), ang = Angle(-6, -30, 25), scale_mul = 0.1},
        ["tfa_metro_ashot"] = {pos = Vector(0, 0, 0), ang = Angle(-5, -35, 0), scale_mul = 0.11 },
        ["weapon_fists"] = {pos = Vector(0, 0, 0), ang = Angle(-5, -35, 0), scale_mul = 0.11 },
        ["gmod_camera"] = {pos = Vector(0, 0, 0), ang = Angle(-5, -35, 0), scale_mul = 0.11 },
        ["guitar"] = {pos = Vector(-100, -200, -110), ang = Angle(20, -60, 140), scale_mul = 0.1 },
        ["passport_vdnkh"] = {pos = Vector(-40, 40, 90), ang = Angle(50, -60, 140), scale_mul = 0.11 },
        ["passport_kk"] = {pos = Vector(-40, 40, 90), ang = Angle(50, -60, 140), scale_mul = 0.11 },
        ["passport_redline"] = {pos = Vector(-40, 40, 90), ang = Angle(50, -60, 140), scale_mul = 0.11 },
        ["passport_pr"] = {pos = Vector(-40, 40, 90), ang = Angle(50, -60, 140), scale_mul = 0.11 },
        ["passport_reich"] = {pos = Vector(-40, 40, 90), ang = Angle(50, -60, 140), scale_mul = 0.11 },
        ["passport_sssf"] = {pos = Vector(-40, 40, 90), ang = Angle(50, -60, 140), scale_mul = 0.11 },
        ["ix_hands"] = {pos = Vector(0, 0, 0), ang = Angle(-5, -30, 0), scale_mul = 0.1 },
    }

    local MAX_SLOTS = 6
    local CACHE_TIME = 1
    local MOVE_SOUND = "sound/metro/battery_pickup.wav"
    local SELECT_SOUND = "sound/metro/battery_pickup.wav"

    --[[ Instance variables ]]--

    local iCurSlot = 0 -- Currently selected slot. 0 = no selection
    local iCurPos = 1 -- Current position in that slot
    local flNextPrecache = 0 -- Time until next precache
    local flSelectTime = 0 -- Time the weapon selection changed slot/visibility states. Can be used to close the weapon selector after a certain amount of idle time
    local iWeaponCount = 0 -- Total number of weapons on the player

    -- Weapon cache; table of tables. tCache[Slot + 1] contains a table containing that slot's weapons. Table's length is tCacheLength[Slot + 1]
    local tCache = {}

    -- Weapon cache length. tCacheLength[Slot + 1] will contain the number of weapons that slot has
    local tCacheLength = {}


    local wep_time = 0
    local wep_lerp = 0
    
    local wep_select = 0
    local cur_wep = 0
    
    local mpanel = nil
    local CurPosCsh = 0
    local icon_wep = nil
    
    local function Rndr()
        local ply = LocalPlayer()
        local wep = ply:GetActiveWeapon()
        
        if !IsValid(wep) or wep == nil then return end
        
        local x_start = ScrW() - x_off
        local y_start = ScrH() - y_off
    
        mpanel:PaintManual()
                
    end
    
    local function UpdateWeaponIcon(wep)
        if !IsValid(wep) or wep == nil then return end
        
        --if wep:GetWeaponWorldModel() == nil or wep:GetWeaponWorldModel() == "" or then return end

        mpanel.icon:SetModel(((wep:GetWeaponWorldModel() != "" or wep:GetWeaponWorldModel() != nil) && 
        wep:GetWeaponWorldModel()) or "")
        
        if IsValid(mpanel.icon.Entity) then
            local mn, mx = mpanel.icon.Entity:GetRenderBounds()
            local size = 0
            size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
            size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
            size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
    
            function mpanel.icon:LayoutEntity( Entity ) 
                            
                local ang = Angle(0, -30, 30)
                local sizemul = 0.1
                local pos_mod = Vector(0,0,0)
                
                if !IsValid(wep) or wep == nil then return end
                    
                if weapon_offsets[wep:GetClass()] != nil then
    
                    ang = weapon_offsets[wep:GetClass()].ang
                    sizemul = weapon_offsets[wep:GetClass()].scale_mul
                    pos_mod = weapon_offsets[wep:GetClass()].pos
                
                end
                            
                Entity:SetPos( (Vector(size,size,size)*-0.2)+pos_mod )	
                Entity:SetAngles( ang )
                                    
                Entity:SetModelScale(size*sizemul)
                                    
                mpanel.icon:SetColor( Color( 255, 255, 255, 255*wep_lerp ) )
                Entity:SetMaterial("engine/singlecolor")
                                    
            end				
            mpanel.icon:SetFOV( 90 )
            mpanel.icon:SetCamPos( Vector( size, size, size ) )
            mpanel.icon:SetLookAt( ( mn + mx ) * 0.35 )		
        end
    end
    
    local function UpdateModelPanel(wep2)
        local ply = LocalPlayer()
        local wep = ply:GetActiveWeapon()
        
        if !IsValid(wep) or wep == nil then return end
        
        local x_start = ScrW() - x_off
        local y_start = ScrH() - y_off
            
        if mpanel == nil then
                mpanel = vgui.Create( "DFrame" )
                mpanel:SetTitle( "" )
                
                mpanel:SetSize( 264, 110 )
                
                mpanel:ShowCloseButton( false )
                mpanel:SetDraggable( false )
                mpanel:SetDeleteOnClose( true )
                mpanel:SetScreenLock( false )
                mpanel:SetPos(x_start + 72, y_start+86)
                mpanel:SetPaintedManually( true )
                
                --mpanel:MakePopup()	
                
                mpanel.Paint = function()
                
                end
                
                    mpanel.icon = vgui.Create( "DModelPanel", mpanel )
                    mpanel.icon:SetSize( 232, 110 )
                    mpanel.icon:SetPos( 0, 0 )
                    mpanel.icon:Dock(FILL)
                    UpdateWeaponIcon(wep2)
                                            
        else
            if icon_wep != wep2 then
                UpdateWeaponIcon(wep2)
            end
        end
        
    end
    
    --[[ Weapon switcher ]]--
    
    local function DrawWeaponIcon()
        local ply = LocalPlayer()
        local wep = ply:GetActiveWeapon()
        
        local x_start = ScrW() - x_off
        local y_start = ScrH() - y_off
        
        if wep_time > CurTime() then
            wep_lerp = Lerp(FrameTime()*22, wep_lerp, 1)
        else
            wep_lerp = Lerp(FrameTime()*22, wep_lerp, 0)
        end
        
        if wep_select > 0 then
            wep_select = Lerp(FrameTime()*6, wep_select, 0)
        end
        
        --if wep:GetWeaponWorldModel() == nil or wep:GetWeaponWorldModel() == "" then
        --	draw.SimpleText( wep:GetPrintName(), "ImpactHUD2", x_start+185, y_start+150, Color(255, 255, 255, 255*wep_lerp), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        --end
        
        if mpanel != nil and wep_lerp > 0.002 then
            draw.RoundedBox( 0, x_start + 72, y_start+100, 232, 110, Color(200,100,0,255*wep_select) )
            draw.RoundedBox( 0, x_start + 72, y_start+100, 232, 110, Color(0,0,0,200*wep_lerp) )
            Rndr()
        end
        
        if cur_wep != wep then
            wep_select = 1
            wep_time = CurTime() + 1.5
            cur_wep = wep
            UpdateModelPanel(wep)
        end
        
    end
    
    local function DrawWeaponHUD()
        -- Draw here!
        local ply = LocalPlayer()
        local wep = ply:GetActiveWeapon()
        
        local x_start = ScrW() - x_off
        local y_start = ScrH() - y_off
        
        for k, v in pairs(tCache) do
        
            if !IsValid(v) and v == nil then return end
            
            if iCurSlot != k then
                draw.RoundedBox( 0, x_start + 32 + (40*k), y_start+64, 32, 32, Color(0,0,0,200) )
            else
                draw.RoundedBox( 0, x_start + 32 + (40*k), y_start+64, 32, 32, Color(200,100,0,200) )
                for w, v in pairs(tCache[iCurSlot]) do
                
                    local slotnum = tCacheLength[iCurSlot]
                    local offset = (42*(slotnum)) + 45 -- 106
                    
                    if iCurPos != w then
                        draw.RoundedBox( 0, x_start+72, y_start+64-offset + (42*w), 232, 40, Color(0,0,0,200) )	--x_start+100 + (40*k)
                    else
                        UpdateModelPanel(v)
                        draw.RoundedBox( 0, x_start+72, y_start+64-offset + (42*w), 232, 40, Color(0,0,0,200) )
                        draw.RoundedBox( 0, x_start+72, y_start+64-offset + (42*w), 232, 40, Color(200,100,0,32) )
                        draw.RoundedBox( 0, x_start+72, y_start+64-offset + (42*w), 8, 40, Color(200,100,0,255) )
                        draw.RoundedBox( 0, x_start+296, y_start+64-offset + (42*w), 8, 40, Color(200,100,0,255) )
                    end
                    
                    if wep == v then		
                        draw.RoundedBox( 0, x_start+72, y_start+64-offset + (42*w), 232, 40, Color(200,100,0,32) )	
                    end
                    
                    if v != nil and IsValid(v) then
                        draw.SimpleText( v:GetPrintName(), "ImpactHUD2", x_start+80, y_start+64-offset + (42*w), Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_UP )
                    end
                end
            end
            
            draw.SimpleText( k, "ImpactHUD2", x_start+36 + (40*k), y_start+64, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_UP )
            
        end
    end
    
    --[[ Implementation ]]--
    
    -- Initialize tables with slot number
    for i = 1, MAX_SLOTS do
        tCache[i] = {}
        tCacheLength[i] = 0
    end
    
    local pairs = pairs
    local tonumber = tonumber
    local RealTime = RealTime
    local hook_Add = hook.Add
    local LocalPlayer = LocalPlayer
    local string_lower = string.lower
    local input_SelectWeapon = input.SelectWeapon
    
    -- Hide the default weapon selection
    hook_Add("HUDShouldDraw", "GS_WeaponSelector", function(sName)
        if (sName == "CHudWeaponSelection") then
            return false
        end
    end)
    
    local function PrecacheWeps()
        -- Reset all table values
        for i = 1, MAX_SLOTS do
            for j = 1, tCacheLength[i] do
                tCache[i][j] = nil
            end
    
            tCacheLength[i] = 0
        end
    
        -- Update the cache time
        flNextPrecache = RealTime() + CACHE_TIME
        iWeaponCount = 0
    
        -- Discontinuous table
        for _, pWeapon in pairs(LocalPlayer():GetWeapons()) do
            iWeaponCount = iWeaponCount + 1
    
            -- Weapon slots start internally at "0"
            -- Here, we will start at "1" to match the slot binds
            local iSlot = pWeapon:GetSlot() + 1
    
            if (iSlot <= MAX_SLOTS) then
                -- Cache number of weapons in each slot
                local iLen = tCacheLength[iSlot] + 1
                tCacheLength[iSlot] = iLen
                tCache[iSlot][iLen] = pWeapon
            end
        end
    
        -- Make sure we're not pointing out of bounds
        if (iCurSlot ~= 0) then
            local iLen = tCacheLength[iCurSlot]
    
            if (iLen < iCurPos) then
                if (iLen == 0) then
                    iCurSlot = 0
                else
                    iCurPos = iLen
                end
            end
        end
    end
    
    local cl_drawhud = GetConVar("cl_drawhud")
    
    hook_Add("HUDPaint", "GS_WeaponSelector", function()
        
        local pPlayer = LocalPlayer()
        
        if !pPlayer:Alive() then return end
        
        DrawWeaponIcon()
    
        if (iCurSlot == 0 or not cl_drawhud:GetBool()) then
            return
        end
        
        -- Don't draw in vehicles unless weapons are allowed to be used
        -- Or while dead!
        if (pPlayer:IsValid() and pPlayer:Alive() and (not pPlayer:InVehicle() or pPlayer:GetAllowWeaponsInVehicle())) or (!pPlayer:KeyDown(IN_ATTACK) or !pPlayer:KeyDown(IN_ATTACK2)) then
            if (flNextPrecache <= RealTime()) then
                PrecacheWeps()
            end
    
            DrawWeaponHUD()
            wep_time = CurTime() + 0.1
            
        else
            iCurSlot = 0
        end
    end)
    
    hook_Add("PlayerBindPress", "GS_WeaponSelector", function(pPlayer, sBind, bPressed)
        if (not pPlayer:Alive() or pPlayer:InVehicle() and not pPlayer:GetAllowWeaponsInVehicle()) or (pPlayer:KeyDown(IN_ATTACK) or pPlayer:KeyDown(IN_ATTACK2)) or ( IsValid(pPlayer:GetActiveWeapon()) and pPlayer:GetActiveWeapon():GetNextPrimaryFire() > CurTime() ) then
            return
        end
    
        sBind = string_lower(sBind)
    
        -- Close the menu
        if (sBind == "cancelselect") then
            if (bPressed) then
                iCurSlot = 0
            end
    
            return true
        end
    
        -- Move to the weapon before the current
        if (sBind == "invprev") then
            if (not bPressed) then
                return true
            end
    
            PrecacheWeps()
    
            if (iWeaponCount == 0) then
                return true
            end
    
            local bLoop = iCurSlot == 0
    
            if (bLoop) then
                local pActiveWeapon = pPlayer:GetActiveWeapon()
    
                if (pActiveWeapon:IsValid()) then
                    local iSlot = pActiveWeapon:GetSlot() + 1
                    local tSlotCache = tCache[iSlot]
    
                    if (tSlotCache[1] ~= pActiveWeapon) then
                        iCurSlot = iSlot
                        iCurPos = 1
    
                        for i = 2, tCacheLength[iSlot] do
                            if (tSlotCache[i] == pActiveWeapon) then
                                iCurPos = i - 1
    
                                break
                            end
                        end
    
                        flSelectTime = RealTime()
                        pPlayer:EmitSound(MOVE_SOUND)
    
                        return true
                    end
    
                    iCurSlot = iSlot
                end
            end
    
            if (bLoop or iCurPos == 1) then
                repeat
                    if (iCurSlot <= 1) then
                        iCurSlot = MAX_SLOTS
                    else
                        iCurSlot = iCurSlot - 1
                    end
                until(tCacheLength[iCurSlot] ~= 0)
    
                iCurPos = tCacheLength[iCurSlot]
            else
                iCurPos = iCurPos - 1
            end
    
            flSelectTime = RealTime()
            pPlayer:EmitSound(MOVE_SOUND)
    
            return true
        end
    
        -- Move to the weapon after the current
        if (sBind == "invnext") then
            if (not bPressed) then
                return true
            end
    
            PrecacheWeps()
    
            -- Block the action if there aren't any weapons available
            if (iWeaponCount == 0) then
                return true
            end
    
            -- Lua's goto can't jump between child scopes
            local bLoop = iCurSlot == 0
    
            -- Weapon selection isn't currently open, move based on the active weapon's position
            if (bLoop) then
                local pActiveWeapon = pPlayer:GetActiveWeapon()
                
                if (pActiveWeapon:IsValid()) then
                    local iSlot = pActiveWeapon:GetSlot() + 1
                    local iLen = tCacheLength[iSlot]
                    local tSlotCache = tCache[iSlot]
    
                    if (tSlotCache[iLen] ~= pActiveWeapon) then
                        iCurSlot = iSlot
                        iCurPos = 1
    
                        for i = 1, iLen - 1 do
                            if (tSlotCache[i] == pActiveWeapon) then
                                iCurPos = i + 1
    
                                break
                            end
                        end
    
                        flSelectTime = RealTime()
                        pPlayer:EmitSound(MOVE_SOUND)
    
                        return true
                    end
    
                    -- At the end of a slot, move to the next one
                    iCurSlot = iSlot
                end
            end
    
            if (bLoop or iCurPos == tCacheLength[iCurSlot]) then
                -- Loop through the slots until one has weapons
                repeat
                    if (iCurSlot == MAX_SLOTS) then
                        iCurSlot = 1
                    else
                        iCurSlot = iCurSlot + 1
                    end
                until(tCacheLength[iCurSlot] ~= 0)
    
                -- Start at the beginning of the new slot
                iCurPos = 1
            else
                -- Bump up the position
                iCurPos = iCurPos + 1
            end
    
            flSelectTime = RealTime()
            pPlayer:EmitSound(MOVE_SOUND)
    
            return true
        end
    
        -- Keys 1-6
        if (sBind:sub(1, 4) == "slot") then
            local iSlot = tonumber(sBind:sub(5))
    
            -- If the command is slot#, use it for the weapon HUD
            -- Otherwise, let it pass through to prevent false positives
            if (iSlot == nil) then
                return
            end
    
            if (not bPressed) then
                return true
            end
    
            PrecacheWeps()
    
            -- Play a sound even if there aren't any weapons in that slot for "haptic" (really auditory) feedback
            if (iWeaponCount == 0) then
                pPlayer:EmitSound(MOVE_SOUND)
    
                return true
            end
    
            -- If the slot number is in the bounds
            if (iSlot <= MAX_SLOTS) then
                -- If the slot is already open
                if (iSlot == iCurSlot) then
                    -- Start back at the beginning
                    if (iCurPos == tCacheLength[iCurSlot]) then
                        iCurPos = 1
                    -- Move one up
                    else
                        iCurPos = iCurPos + 1
                    end
                -- If there are weapons in this slot, display them
                elseif (tCacheLength[iSlot] ~= 0) then
                    iCurSlot = iSlot
                    iCurPos = 1
                end
    
                flSelectTime = RealTime()
                pPlayer:EmitSound(MOVE_SOUND)
            end
    
            return true
        end
    
        -- If the weapon selection is currently open
        if (iCurSlot ~= 0) then
            if (sBind == "+attack") then
                -- Hide the selection
                local pWeapon = tCache[iCurSlot][iCurPos]
                iCurSlot = 0
    
                -- If the weapon still exists and isn't the player's active weapon
                if (pWeapon:IsValid() and pWeapon ~= pPlayer:GetActiveWeapon()) then
                    input_SelectWeapon(pWeapon)
                end
    
                flSelectTime = RealTime()
                pPlayer:EmitSound(SELECT_SOUND)
    
                return true
            end
    
            -- Another shortcut for closing the selection
            if (sBind == "+attack2") then
                flSelectTime = RealTime()
                iCurSlot = 0
    
                return true
            end
        end
    end)
end