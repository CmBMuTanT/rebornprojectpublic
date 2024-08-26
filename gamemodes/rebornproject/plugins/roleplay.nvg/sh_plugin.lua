local PLUGIN = PLUGIN
PLUGIN.name = "ПНВ/ТПВ"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

PLUGIN.NvCooldown 	= 1 -- Откат на включение/выключение пнв

if SERVER then
ix.util.Include("sv_plugin.lua")
end

--[[

———————————No cmbmutant.xyz?———————————
⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
—————————————————————————————————————
]]


if CLIENT then

    local vrnvgcolorpresettable = {}
    local nv = {
        goglightblue = true,
        goggreen = true,
        gogblue = true,
        gogred = true,
    }
    hook.Add("PlayerButtonDown", "PBD_NV", function(ply,btn)
		if btn == KEY_N && !vgui.CursorVisible() then
			if not (ply:GetCharacter() and ply:Alive()) then return false end

			if (nv_cd || 0) > CurTime() then return false end
			nv_cd = CurTime() + (PLUGIN.NvCooldown || 0.5)

			local inv = ply:ExtraInventory("pnv")
			if inv == nil then return end
			if inv:GetEquipedItem() and nv[inv:GetEquipedItem().uniqueID] then
                netstream.Start("enable_nvgoogles")
			end
		end
	end)

    netstream.Hook("pickcolor", function(data) -- я не хочу делать массив так что сделаю elseif (позже перепишу под массивы ок. Да и плюс это не прям так шакально выглядит или по оптимизации долбит.)
        if data == "Green" then
            vrnvg_classicgreen()
        elseif data == "BlueGreen" then
            vrnvg_bluegreen()
        elseif data == "Blue" then
            vrnvg_lightblue()
        elseif data == "Red" then
            vrnvg_lightred()
        end
    end)


    local nvgflashlerp = 0
        
    local glassposx = 0
    local glassposy = 0

    local rx, gx, bx, ry, gy, by = 0, 0, 0, 0, 0, 0
    local black = Material("vrview/black.png")
    local TPV_mat = CreateMaterial( "TPV_mat", "UnlitGeneric", {
        ["$basetexture"] = "color/white",
        ["$model"] = 1,
        ["$translucent"] = 0,
        ["$alpha"] = 0,
        ["$nocull"] = 0,
        ["$ignorez"] = 0
    } )
    
    local ca_r = CreateMaterial( "ca_r", "UnlitGeneric", {
        ["$basetexture"] = "vgui/black",
        ["$color2"] = "[1 0 0]",
        ["$additive"] = 1,
        ["$ignorez"] = 1
    } )
    local ca_g = CreateMaterial( "ca_g", "UnlitGeneric", {
        ["$basetexture"] = "vgui/black",
        ["$color2"] = "[0 1 0]",
        ["$additive"] = 1,
        ["$ignorez"] = 1
    } )
    local ca_b = CreateMaterial( "ca_b", "UnlitGeneric", {
        ["$basetexture"] = "vgui/black",
        ["$color2"] = "[0 0 1]",
        ["$additive"] = 1,
        ["$ignorez"] = 1
    } )

    local function vrnvg_chromatic( rx, gx, bx, ry, gy, by )
        render.UpdateScreenEffectTexture()
        local screentx = render.GetScreenEffectTexture()
        ca_r:SetTexture( "$basetexture", screentx)
        ca_g:SetTexture( "$basetexture", screentx)
        ca_b:SetTexture( "$basetexture", screentx)
        render.SetMaterial( black )
        render.DrawScreenQuad()
        render.SetMaterial( ca_r )
        render.DrawScreenQuadEx( -rx / 2, -ry / 2, ScrW() + rx, ScrH() + ry )
    render.SetMaterial( ca_g )
        render.DrawScreenQuadEx( -gx / 2, -gy / 2, ScrW() + gx, ScrH() + gy )
        render.SetMaterial( ca_b )
        render.DrawScreenQuadEx( -bx / 2, -by / 2, ScrW() + bx, ScrH() + by )
    end

    local blur = Material("pp/blurscreen")
    local blurtoggle = false
    local blura = 0
    local function drawblur()
        local w, h = ScrW(), ScrH()
        surface.SetMaterial(blur)
        surface.SetDrawColor(255, 255, 255, 255)
        if LocalPlayer():GetViewEntity() ~= LocalPlayer() then return end

        for i = 1, blura do
            blur:SetFloat( "$blur", (i / blura ) * ( blura ) )
            blur:Recompute()
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(0, 0, w, h)
        end
    end


    sound.Add({
        name = "vrnvg_elecsizzle",
        channel = CHAN_AUTO,
        volume = 1.0,
        level = 50,
        pitch = 100,
        sound = "ventrische/nvg/sizzlesizzle.mp3"
    })
    sound.Add({
        name = "vrnvg_elechum",
        channel = CHAN_AUTO,
        volume = 1.0,
        level = 50,
        pitch = 100,
        sound = "ventrische/nvg/hum.wav"
    })

    surface.CreateFont("vrnvgdigits", {
        font = "Sicret Mono PERSONAL Light",
        extended = false,
        size = 15,
        weight = 500,
        antialias = true,
        shadow = true
    })
    surface.CreateFont("vrnvgdigitsbig", {
        font = "Futura Md BT",
        extended = false,
        size = 35,
        weight = 500,
        antialias = true,
        shadow = false
    })
    surface.CreateFont("vrnvgdigitsmenu", {
        font = "Futura Md BT",
        extended = false,
        size = 35,
        weight = 700,
        antialias = true,
        shadow = false
    })
    surface.CreateFont("vrnvgdigitsNOS", {
        font = "Sicret Mono PERSONAL Light",
        extended = false,
        size = 15,
        weight = 500,
        antialias = true,
        shadow = false
    })

    local vrnvgsway = {}
    vrnvgsway.lerpx = 0
    vrnvgsway.lerpy = 0
    vrnvgsway.angle1 = 0
    vrnvgsway.angle2 = 0
    vrnvgsway.clampx = 0
    vrnvgsway.clampy = 0
    hook.Add("Think", "nvghuduiandmisc", function()
        local ply = LocalPlayer()
        local eyeang = ply:EyeAngles()
        local ft = FrameTime()
        
        if !vrnvgcolorpresettable then
            vrnvgcolorpresettable = {
                [1] = Color(0,255,200);
                [2] = 0;
                [3] = 255;
                [4] = 200;
                [5] = .0;
                [6] = .2;
                [7] = .16;
                [8] = .5;
                [9] = 1;
            }
        end

        if ply:GetViewEntity() == ply or !ply:Alive() then 
            if ply.vrnvgplayermodel then
                ply.vrnvgplayermodel:Remove()
                ply.vrnvgplayermodel = nil
            end
        end

            --yoinked but its just angle lerp so who cares
        if ply.quadnodson then
            vrnvgsway.lerpx = Lerp(ft*8, vrnvgsway.lerpx, math.Clamp(vrnvgsway.clampx + math.AngleDifference(eyeang.y * 2.25, vrnvgsway.angle1) * 2, -25, 25))
            vrnvgsway.lerpy = Lerp(ft*8, vrnvgsway.lerpy, math.Clamp(vrnvgsway.clampy + math.AngleDifference(eyeang.p * 2.25, vrnvgsway.angle2) * 2, -25, 25))

            if vrnvgsway.angle1 ~= eyeang.y * 2.25 then
                vrnvgsway.angle1 = eyeang.y * 2.25
            end
            if vrnvgsway.angle2 ~= eyeang.p * 2.25 then
                vrnvgsway.angle2 = eyeang.p * 2.25
            end
        end

            --dlights for light on weapons
        if ply.quadnodsonlight and ply:Alive() then
            local vrnvgdlight = DynamicLight( ply:EntIndex() )

            vrnvgdlight.pos = ply:GetShootPos()
            vrnvgdlight.r = vrnvgcolorpresettable[2]
            vrnvgdlight.g = vrnvgcolorpresettable[3]
            vrnvgdlight.b = vrnvgcolorpresettable[4]
            vrnvgdlight.brightness = 0.5
            vrnvgdlight.Decay = 1000
            vrnvgdlight.Size = 250
            vrnvgdlight.DieTime = CurTime()
        end
    end)


    local edgeblurtex = Material("pp/toytown-top")
    local function edgeblur( passed, H )
        surface.SetMaterial( edgeblurtex )
        surface.SetDrawColor( 255, 255, 255, 255 )
        for i = 1, passed do
            render.CopyRenderTargetToTexture( render.GetScreenEffectTexture() )

            surface.DrawTexturedRect( 0, 0, ScrW(), H )
                    surface.DrawTexturedRectUV( 0, ScrH() - H, ScrW(), H, 0, 1, 1, 0 )
                    surface.DrawTexturedRectRotated( 0, 0, ScrW(), H*6, 90 )
                    surface.DrawTexturedRectRotated( ScrW(), 0, ScrW(), H*6, -90 )
        end
    end


    function vrnvg_bluegreen() --dumb
        vrnvgcolorpresettable[1] = Color(0,255,200);
        vrnvgcolorpresettable[2] = 0;
        vrnvgcolorpresettable[3] = 255;
        vrnvgcolorpresettable[4] = 200;
        vrnvgcolorpresettable[5] = 0;
        vrnvgcolorpresettable[6] = .2;
        vrnvgcolorpresettable[7] = .16;

        vrnvgcolorpresettable[8] = .5;
    end
    function vrnvg_lightblue()
        vrnvgcolorpresettable[1] = Color(0,150,255);
        vrnvgcolorpresettable[2] = 0;
        vrnvgcolorpresettable[3] = 150;
        vrnvgcolorpresettable[4] = 255;
        vrnvgcolorpresettable[5] = .0;
        vrnvgcolorpresettable[6] = .1;
        vrnvgcolorpresettable[7] = .2;

        vrnvgcolorpresettable[8] = .5;
    end
    function vrnvg_lightred()
        vrnvgcolorpresettable[1] = Color(255,35,35);
        vrnvgcolorpresettable[2] = 255;
        vrnvgcolorpresettable[3] = 35;
        vrnvgcolorpresettable[4] = 35;
        vrnvgcolorpresettable[5] = .2;
        vrnvgcolorpresettable[6] = .02;
        vrnvgcolorpresettable[7] = .02;

        vrnvgcolorpresettable[8] = .5;
    end
    function vrnvg_classicgreen()
        vrnvgcolorpresettable[1] = Color(25,255,25);
        vrnvgcolorpresettable[2] = 25;
        vrnvgcolorpresettable[3] = 255;
        vrnvgcolorpresettable[4] = 25;
        vrnvgcolorpresettable[5] = .01;
        vrnvgcolorpresettable[6] = .2;
        vrnvgcolorpresettable[7] = .01;

        vrnvgcolorpresettable[8] = .5;
    end

    function vrnvg_TPV()
        vrnvgcolorpresettable[1] = Color(1,1,1);
        vrnvgcolorpresettable[2] = 255;
        vrnvgcolorpresettable[3] = 255;
        vrnvgcolorpresettable[4] = 255;
        vrnvgcolorpresettable[5] = .01;
        vrnvgcolorpresettable[6] = .01;
        vrnvgcolorpresettable[7] = .01;

        vrnvgcolorpresettable[8] = .5;

        TPVgoogles = !TPVgoogles;
    end

    local viggy = Material("vrview/ventwhitevig")
    local battery = Material("ventrische/nvg/tinybattery.png")
    local linebar = Material("ventrische/nvg/linebar8.png")
    local scale = Material("ventrische/nvg/scale.png")
    local moon = Material("ventrische/nvg/moonnn.png")
    local sun = Material("ventrische/nvg/sunnn.png")
    local broken = Material("vrview/fx_distort")
    local crackref = Material("vrview/glass/glasscrack")
    local crack1 = Material("vrview/glass/glasscrack.png")
    local crackref2 = Material("vrview/glass/glasscrack2")
    local crack2 = Material("vrview/glass/glasscrack20.png")
    local crackref3 = Material("vrview/glass/glasscrack3")
    local crack3 = Material("vrview/glass/glasscrack3.png")
    local lightcolor = 0
    local lightcolor2 = 0
    local humlevel = 0.4
    local batteryoffnvgs = 0
    local ooga = {}

    net.Receive("vrnvgnetflip", function(len, ply) -- можете багоюзить это если вы прошаренный, я не против.

        local boolin = net.ReadBool()
        local ply = LocalPlayer()
        ply.vrnvgflipped = boolin
        if boolin then
            surface.PlaySound("ventrische/nvg/flipdown.mp3")
            timer.Simple(0, function()
                ply.quadnodson = true
                
                --ply.vrnvgequipped = true


                if !ply.nvglightdraw then 
                    ply.nvglightdraw = ProjectedTexture()
                    ply.nvglightdraw:SetTexture( "effects/flashlight/soft" )
                    ply.nvglightdraw:SetFOV( 140 )
                    ply.nvglightdraw:SetVerticalFOV(100)
                    ply.nvglightdraw:SetBrightness(1)
                    ply.nvglightdraw:SetEnableShadows(false)
                    ply.nvglightdraw:Update()
                end

                surface.PlaySound("ventrische/nvg/night_vision_on.wav")
                nvgflashlerp = 255
            end)
        else
            if ply.nvglightdraw or ply.nvgnobattery then 
                surface.PlaySound("ventrische/nvg/flipup.mp3")
                timer.Simple(.25, function()
                    ply.quadnodson = false
                    if !ply.nvgnobattery then
                        ply.nvglightdraw:Remove()
                        ply.nvglightdraw = nil
                    else 
                        ply.nvgnobattery = false
                    end
                    surface.PlaySound("ventrische/nvg/night_vision_off.wav")
                end)
                timer.Simple(.2, function()
                    ply.quadnodsonlight = false
                   -- ply.vrnvgequipped = false

                end)

              --  vrplayanim("flipup", 1.1)
            end
        end
    end)

    --the meat
    function PLUGIN:HUDPaintBackground()
        local ply = LocalPlayer()
        local ft = FrameTime()
        local eang, epos = EyeAngles(), EyePos()
        local w, h = ScrW(), ScrH()
        local p, q = vrnvgsway.lerpx * 1.1, -vrnvgsway.lerpy * 1.1
        local vrna = false


        local bluegreencolor = Color(vrnvgcolorpresettable[2] or 0,vrnvgcolorpresettable[3] or 255,vrnvgcolorpresettable[4] or 200,100)
        local nvgs = ply.vrnvgmodel
        local nvgcam = ply.vrnvgcam
        if !ply:Alive() or !ply:IsValid() then 
                        local viewmodel = ply:GetViewModel()
                        blura = 0
            ply:StopSound("vrnvg_elecsizzle")
            ply:StopSound("vrnvg_elechum")
            ply.quadnodson = false
           -- ply.vrnvgequipped = false
            ply.vrnvgflipped = false
            ply.quadnodsonlight = false
            if ply.vrnvgmodel then
                ply.vrnvgmodel:Remove()
                ply.vrnvgmodel = nil
                                if ply.vrnvghand then
                                            ply.vrnvghand:Remove()
                                            ply.vrnvghand = nil
                                end
                ply.vrnvgcam:Remove()
                ply.vrnvgcam = nil
            end
                if IsValid(viewmodel) then
                    if viewmodel:GetSequence() != viewmodel:LookupSequence("idleoff") then
                end
                --vrplayanim("idleoff") 
            end
            if ply.nvglightdraw then
                ply.nvglightdraw:Remove()
                ply.nvglightdraw = nil
            end
                        return
        end

            if !ply.nvgbattery then 
                ply.nvgbattery = 80
            end

        if ply.vrnvgflipped then
            local inventory = ply:ExtraInventory("pnv")
            local item = inventory:GetEquipedItem()

            if !inventory then return end
            if !item then return end

            local batterylevel = item:GetData("BatteryCondition")
            
            if batterylevel == nil or batterylevel == 0 then 
                ply.nvgbattery = 0
                ply.quadnodson = false
                ply.vrnvgflipped = false
                ply.quadnodsonlight = false

                if ply.nvglightdraw then 
                    ply.nvglightdraw:Remove()
                    ply.nvglightdraw = nil
                end
                
                return 
            end

            ply.nvgbattery = batterylevel
        end


        if blura > 0 then
            drawblur() 
        end
        local blura = 0
        if blurtoggle then
            blura = math.Approach(blura, 4, ft*20)
            elseif ply.quadnodson then
                        if ply.nvgbattery >= 40 then 
                                blura = math.Approach(blura, math.random(1, 2), ft*20)
                                humlevel = 0.4
                        elseif ply.nvgbattery < 40 and ply.nvgbattery >= 20 then 
                                blura = math.Approach(blura, math.random(1, 3), ft*15)
                                humlevel = 0.7
                        elseif ply.nvgbattery < 20 and ply.nvgbattery > 0 then 
                                blura = math.Approach(blura, math.random(1, 4), ft*10)
                                humlevel = 1
                        end
        else
            humlevel = 0.4
            blura = math.Approach(blura, 0, ft*25)
        end

        local nvgs = ply.vrnvgmodel
        local nvgcam = ply.vrnvgcam
        cam.Start3D( epos, eang, 100, 0, 0, w, h, 1, 35)
            if nvgs and ply.vrnvghand then
                nvgs:SetPos(epos + Vector(0,0,0.3))
                nvgs:SetAngles(eang)
                nvgs:SetupBones()
                nvgs:FrameAdvance(ft)
                ply.vrnvghand:SetupBones()
                nvgcam:SetPos(Vector(0,0,0))
                nvgcam:SetAngles(Angle(0,0,0))
                nvgcam:FrameAdvance(ft)
                ply.nvgcamattach = nvgcam:GetAttachment(nvgcam:LookupAttachment("Camera"))
                if ply:GetViewEntity() == ply and !ply:ShouldDrawLocalPlayer() and !sky3d then 
                    nvgs:DrawModel() 
                end
            end
        cam.End3D()

            --battery HUD
        if ply.vrnvgflipped and !ply.quadnodson and ply:GetViewEntity() == ply then
            -- local nodbone = nvgs:LookupBone("nod")
            -- local nodbonep = nvgs:GetBonePosition(nodbone)
            -- if nodbonep == nvgs:GetPos() then
            --     nodbonep = nvgs:GetBoneMatrix(nodbone):GetTranslation()
            -- end
            -- ooga = nodbonep:ToScreen()
            -- local n, m = math.Round(ooga.x, 0), math.Round(ooga.y, 0)
            -- local percentage = math.Round(ply.nvgbattery, 0)

            -- draw.SimpleText(percentage, "vrnvgdigitsbig", n + 2, m + 150 + 2, Color(21,21,21,batteryoffnvgs/2), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            -- draw.SimpleText(percentage, "vrnvgdigitsbig", n, m + 150, Color(255,255,255,batteryoffnvgs), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            if batterynvg2dfade or ply.nvgbattery > 75 then 
                batteryoffnvgs = Lerp(ft*6, batteryoffnvgs, 0)
            else
                batteryoffnvgs = Lerp(ft, batteryoffnvgs, 200)
            end
        end

            --misc sounds and sizzle
        if ply.quadnodson then 
            -- if ply.vrnvgflipped then
            --     rechargedsoundplayedomg = true
            -- end

            if (!nvghummingrepeat or CurTime() >= nvghummingrepeat) then
                nvghummingrepeat = CurTime() + 10 --lazy
                ply:EmitSound("vrnvg_elechum", 75, 100, humlevel)
            end

            if ply.nvgbattery == 0 then 
                ply.nvgnobattery = true

                if ply.nvglightdraw then
                    ply.nvglightdraw:Remove()
                    ply.nvglightdraw = nil
                    surface.PlaySound("ventrische/nvg/night_vision_off_c.wav")
                end
                ply.quadnodsonlight = false
            end
        else 
            -- if ply.nvgbattery > 75 and ply.nvgbattery ~= 80 then
            --     surface.PlaySound("ventrische/nvg/theclassicventycustomaudiorequirement/recharged.mp3")
            --     --rechargedsoundplayedomg = false
            -- end
            if ply.nvgbattery > 0 then 
                ply.nvgnobattery = false
            end
            nvghummingrepeat = CurTime()
            ply:StopSound("vrnvg_elechum")
        end

            --sizzle sound, light blinding, main HUD
        if ply.nvglightdraw then
            ply.nvglightdraw:SetColor( vrnvgcolorpresettable[1] )
            ply.nvglightdraw:SetFarZ( 1000 ) 
            if ply:GetViewEntity() == ply then
                ply.nvglightdraw:SetPos( ply:GetPos() + Vector(0,0,50)) 
                ply.nvglightdraw:SetAngles( ply:EyeAngles() )
            else
                nvghummingrepeat = CurTime()
                ply:StopSound("vrnvg_elechum")
                ply.nvglightdraw:SetPos( ply:GetPos() + Vector(0,0,2400000000))
                ply.nvglightdraw:SetAngles( Angle(90,0,0) )
            end
            ply.nvglightdraw:Update()
            

                    local tr = util.QuickTrace(ply:GetShootPos() + ply:EyeAngles():Forward()*250, gui.ScreenToVector(gui.MousePos()),ply)
            local lightcolorreg = render.GetLightColor(ply:GetPos())
            local lightcoloreye = render.GetLightColor(tr.HitPos)
            local lightcolorreg2 = lightcolorreg.r/3 + lightcolorreg.g/3 + lightcolorreg.b/3
            local lightcoloreye2 = lightcoloreye.r/3 + lightcoloreye.g/3 + lightcoloreye.b/3

            local lightcolorclamp = math.Clamp(lightcolorreg2, 0.003332, .45)
            local lightcoloreyeclamp = math.Clamp(lightcoloreye2, 0.003332, .45)

            lightcolor = Lerp(ft*4, lightcolor, lightcolorclamp)
            lightcolor2 = Lerp(ft*4, lightcolor2, lightcoloreyeclamp)

            draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,nvgflashlerp))
            nvgflashlerp = math.Approach(nvgflashlerp, 0, ft*600)
            if lightcolor > 0.2 then
                    if (!nvgsizzlerepeat or CurTime() >= nvgsizzlerepeat) then
                        nvgsizzlerepeat = CurTime() + 24 --lazy
                        ply:EmitSound("vrnvg_elecsizzle")
                    end
            elseif lightcolor > 0.1 then 
                if nvglightmeter then
                    surface.PlaySound("ventrische/nvg/night_vision_lightmeter_warning.wav")
                    nvglightmeter = false 
                end
                nvgsizzlerepeat = CurTime()
                ply:StopSound("vrnvg_elecsizzle")
            else
                nvglightmeter = true
                nvgsizzlerepeat = CurTime()
                ply:StopSound("vrnvg_elecsizzle")
            end

            surface.SetDrawColor(Color(0,0,0,255))
            surface.SetMaterial(viggy)
            surface.DrawTexturedRect(0, 0, w, h)

            if ply.nvgbattery < 20 then
                local capitfucker = math.Clamp(150*math.sin(CurTime()*3), 0, 150)
                surface.SetDrawColor(Color(capitfucker, 0, 0, 150))
                surface.SetMaterial(battery)
                surface.DrawTexturedRect(w/4 - 220 + p, h/1.4 + q, 80, 30)
            else
                surface.SetDrawColor(Color(21,21,21,125))
                surface.SetMaterial(battery)
                surface.DrawTexturedRect(w/4 - 220 + p, h/1.4 + q, 80, 30)

                surface.SetDrawColor(bluegreencolor)
                surface.SetMaterial(battery)
                render.SetScissorRect( 0+ p, 0+ q, w/4 - 230 + ply.nvgbattery*1.15 + p, ScrH() + q, true )
                    surface.DrawTexturedRect(w/4 - 220 + p, h/1.4 + q, 80, 30)
                render.SetScissorRect( 0, 0, 0, 0, false )
            end
            local percentage = math.Round(ply.nvgbattery, 0)
            draw.SimpleText(percentage.."%", "vrnvgdigits", w/4 - 135 + p, h/1.4 + 5 + q, Color(vrnvgcolorpresettable[2],vrnvgcolorpresettable[3],vrnvgcolorpresettable[4],150), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)

            surface.SetDrawColor(bluegreencolor)
            surface.SetMaterial(scale)
            surface.DrawTexturedRect(w/4 - 190 + p, h/1.6 + q - 2 - lightcolor*500, 30, 5)
            surface.SetFont( "vrnvgdigits" )
            local tw = surface.GetTextSize( math.Round(lightcolor*3, 3) )
            draw.RoundedBox(4, w/4 - 155 + p, h/1.6 + q - 8 - lightcolor*500, tw + 10, 15, Color(vrnvgcolorpresettable[2],vrnvgcolorpresettable[3],vrnvgcolorpresettable[4],50))
            render.PushFilterMag(TEXFILTER.ANISOTROPIC)
                render.PushFilterMin(TEXFILTER.ANISOTROPIC)
                    draw.SimpleText(math.Round(lightcolor*3, 3), "vrnvgdigitsNOS", w/4 - 150 + p + 1, h/1.6 + q - 7 - lightcolor*500 + 1, Color(0,0,0,150), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
                draw.SimpleText(math.Round(lightcolor*3, 3), "vrnvgdigitsNOS", w/4 - 150 + p, h/1.6 + q - 7 - lightcolor*500, Color(vrnvgcolorpresettable[2],vrnvgcolorpresettable[3],vrnvgcolorpresettable[4],150), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
            render.PopFilterMag()
            render.PopFilterMin()

            surface.SetDrawColor(bluegreencolor)
            surface.SetMaterial(linebar)
            surface.DrawTexturedRect(w/4 - 225 + p, h/1.6 + q - 225, 20, 225)

            surface.SetDrawColor(bluegreencolor)
            surface.SetMaterial(moon)
            surface.DrawTexturedRect(w/4 - 200 + p, h/1.6 + 7 + q, 8, 12)

            surface.SetDrawColor(bluegreencolor)
            surface.SetMaterial(sun)
            surface.DrawTexturedRect(w/4 - 205 + p, h/1.6 - 250 + q, 20, 20)


            draw.RoundedBox(2, w/4 - 200 + p, h/1.6 + q - 225, 10, 225, Color(0,0,0,100))
            draw.RoundedBox(0, w/4 - 200 + p, h/1.6 + q - lightcolor*500, 10, lightcolor*500, bluegreencolor)
        elseif ply.nvgnobattery then 
            draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,nvgflashlerp))
            nvgflashlerp = math.Approach(nvgflashlerp, 0, ft*20)
            ply:StopSound("vrnvg_elecsizzle")
        else 
            nvgsizzlerepeat = CurTime()
            ply:StopSound("vrnvg_elecsizzle")
        end

            --chromatic abberation
        if ply.quadnodson and vrnvgcolorpresettable[2] ~= 255 and vrnvgcolorpresettable[3] ~= 150 then 
            vrnvg_chromatic( 10, 0, 10, 0, 0, 0 )
        elseif ply.quadnodson and vrnvgcolorpresettable[2] == 255 or ply.quadnodson and vrnvgcolorpresettable[3] == 150 then 
            vrnvg_chromatic( 5, 0, 5, 0, 0, 0 )
        end
    end

    --hook.Add("HUDPaintBackground", "vrnvgbackground", vrnvgbackground)

    local ents_table = {}
    local ents_count = 0

    function TPV_GetTypes(ent)
        if !ent then return false end
        if !ent:IsValid() then return false end
        if ent:IsWorld() then return false end
        if (ent:Health() and (ent:Health() <= 0)) then return false end
    
        if ent:IsOnFire() then return true end
        if ent:IsNPC() then return true end

        if ent:IsNextBot() then return true end
        if ent:IsPlayer() then return true end
    
        if ent:IsRagdoll() then return false end
    
        if ent:IsVehicle() then
            return ent:GetVelocity():Length() >= 100
        end
    
    end

    local addrl = 0
    local addgl = .2
    local addbl = .16
    local colourl = .5
    local contrastl = 2
    local contrastl = 2

    local DefMats = {}

    --rip colormod fps on shitty laptops sorry it has to be updated live
  --  function PLUGIN:RenderScreenspaceEffects()
    hook.Add("RenderScreenspaceEffects", "vrnvggreen", function()
        local ply = LocalPlayer()
        local ft = FrameTime()
        if !ply:Alive() then return end
            local colormod = {
            [ "$pp_colour_addr" ] = addrl,
            [ "$pp_colour_addg" ] = addgl,
            [ "$pp_colour_addb" ] = addbl,
            [ "$pp_colour_brightness" ] = 0,
            [ "$pp_colour_contrast" ] = contrastl,
            [ "$pp_colour_colour" ] = colourl,
            [ "$pp_colour_mulr" ] = 0,
            [ "$pp_colour_mulg" ] = 0,
            [ "$pp_colour_mulb" ] = 0
            }
        local colormod2 = {
            [ "$pp_colour_addr" ] = addrl,
            [ "$pp_colour_addg" ] = addgl,
            [ "$pp_colour_addb" ] = addbl,
            [ "$pp_colour_brightness" ] = 0,
            [ "$pp_colour_contrast" ] = contrastl,
            [ "$pp_colour_colour" ] = colourl,
            [ "$pp_colour_mulr" ] = 0,
            [ "$pp_colour_mulg" ] = 0,
            [ "$pp_colour_mulb" ] = 0
            }
        if ply.quadnodson and !ply.nvgnobattery then
                        addrl = Lerp(ft*4, addrl, vrnvgcolorpresettable[5])
                        addgl = Lerp(ft*4, addgl, vrnvgcolorpresettable[6])
                        addbl = Lerp(ft*4, addbl, vrnvgcolorpresettable[7])
                        colourl = Lerp(ft*4, colourl, vrnvgcolorpresettable[8])
                        contrastl = Lerp(ft*4, contrastl, 2)
                        DrawColorModify(colormod)
                        if render.SupportsPixelShaders_2_0() then
                                DrawBloom( 0, 0.2+lightcolor+lightcolor2*2, 9, 9, 1, 1, 1, 1, 1 )
                        end
            edgeblur(3, ScrH()*.4)
        elseif ply.nvgnobattery then
            addrl = Lerp(ft, addrl, 0)
            addgl = Lerp(ft, addgl, 0)
            addbl = Lerp(ft, addbl, 0)
            colourl = Lerp(ft, colourl, 1)
            contrastl = Lerp(ft, contrastl, 1)
            DrawColorModify(colormod2)
            edgeblur(3, ScrH()*.4)
        end

        if TPVgoogles then
            return -- TODO!
        end

    end)
end