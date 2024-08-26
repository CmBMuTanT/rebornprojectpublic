local PLUGIN = PLUGIN

PLUGIN.name = "Помощник с чатом и дистанцией"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[
——————————————————————————————————————no cmbmutant.xyz?———————————————————————————
          .                                                      .
        .n                   .                 .                  n.
  .   .dP                  dP                   9b                 9b.    .
 4    qXb         .       dX                     Xb       .        dXp     t
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'
        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP
                     `'      9XXXXXX(   )XXXXXXP      `'
                              XXXX X.`v'.X XXXX
                              XP^X'`b   d'`X^XX
                              X. 9  `   '  P )X
                              `b  `       '  d'
                               `             '
—————————————————————————————————————————————————————————————————————————————————
]]


PLUGIN.VoiceDistanceTable = {
    [1] = 0.25,
    [2] = 0.45,
    [3] = 0.65,
    [4] = 0.85,
    [5] = 1,
    [6] = 1.25,
    [7] = 1.45,
    [8] = 1.65,
    [9] = 1.85,
    [10] = 2,
}

ix.util.Include("sv_plugin.lua")

if SERVER then return end

PLUGIN.Circles = ix.util.Include("libs/cl_circles.lua")

function PLUGIN:StartChat()
    self.ChatSphereRadius = ix.config.Get("chatRange", 280)
    self.targetRadius = self.ChatSphereRadius
    self.animSpeed = 1
    self.DefaultColor = Color(255, 111, 0)

    hook.Add("PostDrawTranslucentRenderables", "DrawChatDistance", function()
        local command = ix.chat.currentCommand

        local circle =  PLUGIN.Circles.New(CIRCLE_OUTLINED, self.targetRadius, 0, 0, 6)

        if command == "y" then
            self.targetRadius = Lerp(FrameTime() * self.animSpeed, self.targetRadius, self.ChatSphereRadius * 2)
        elseif command == "w" then
            self.targetRadius = Lerp(FrameTime() * self.animSpeed, self.targetRadius, self.ChatSphereRadius * 0.25)
        else
            self.targetRadius = Lerp(FrameTime() * self.animSpeed, self.targetRadius, self.ChatSphereRadius)
        end

        circle:SetColor(self.DefaultColor)
        circle:SetMaterial(true)

        cam.Start3D2D(LocalPlayer():GetPos(), Angle(0, 0, 0), 1)
            circle()
        cam.End3D2D()
    end)
end

function PLUGIN:FinishChat()
    hook.Remove("PostDrawTranslucentRenderables", "DrawChatDistance")
end


-----------------------VOICE-----------------------
local function SetVoiceDistance(level)
    netstream.Start("CMBTK:VoiceDistance", level)
end

local bIsCircleVisible = false
local delay = 5
local nextOccurance = 0

local client, char, VCdistance, currentVolumeWidth, voiceVolume

timer.Create("TempLocalTimer", 5, 0, function() -- ага, очередной таймер, но учитывая что он обновляется каждые 5 секунд, то нагрузки от него нет и нихуя.
    client = LocalPlayer()
    if !client:GetCharacter() then return end

    char = LocalPlayer():GetCharacter()
    if char then
        voiceVolume = client:GetLocalVar("new.voicedistance", 5) * 10
        VCdistance = ix.config.Get("chatRange", 280)
        currentVolumeWidth = 0
        timer.Remove("TempLocalTimer")
    end
end)

function PLUGIN:PlayerButtonDown(ply, key)
    if not char then return end

    if key == 88 then -- KEY_UP (стрелка вверх)
        voiceVolume = math.min(100, voiceVolume + 10)
        bIsCircleVisible = true
        SetVoiceDistance(voiceVolume * 0.1)
    elseif key == 90 then -- KEY_DOWN (стрелка вниз)
        voiceVolume = math.max(10, voiceVolume - 10)
        bIsCircleVisible = true
        SetVoiceDistance(voiceVolume * 0.1)
    end
end

function PLUGIN:PostDrawTranslucentRenderables()
    if not char then return end

    local timeLeft = nextOccurance - CurTime()

    if bIsCircleVisible and timeLeft < 0 then
        bIsCircleVisible = false
        nextOccurance = CurTime() + delay
    end

    if bIsCircleVisible then 

         local initialVCdistance = self.VoiceDistanceTable[voiceVolume * 0.1] * ix.config.Get("chatRange", 280)
        local circle =  PLUGIN.Circles.New(CIRCLE_OUTLINED, VCdistance, 0, 0, 6)
        VCdistance = Lerp(FrameTime() * 2, VCdistance, initialVCdistance)

        
        circle:SetColor(Color(255, 0, 0))
        circle:SetMaterial(true)

        cam.Start3D2D(client:GetPos(), Angle(0, 0, 0), 1)
            circle()
        cam.End3D2D()
    end
end

function PLUGIN:HUDPaint()
    if not char or not bIsCircleVisible then return end

    local screenWidth, screenHeight = ScrW(), ScrH()

    local barWidth, barHeight = 200, 5
    local barX, barY = (screenWidth - barWidth) / 2, screenHeight / 1.5 - barHeight / 2
    
    currentVolumeWidth = Lerp(0.1, currentVolumeWidth, barWidth * (voiceVolume * 0.01))

    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(barX, barY, barWidth, barHeight)

    surface.SetDrawColor(255, 111, 0, 255)
    surface.DrawRect(barX, barY, currentVolumeWidth, barHeight)

    local text = "Громкость голоса: " .. tostring(voiceVolume) .. "%"
    local textWidth, textHeight = surface.GetTextSize(text)
    local textX, textY = (screenWidth - textWidth) / 2, barY - textHeight - 5

    draw.SimpleText(text, "DermaDefault", textX, textY, Color(255, 255, 255, 255))
end
-----------------------VOICE-----------------------