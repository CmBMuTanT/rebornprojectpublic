local PLUGIN = PLUGIN
local _tonumber = tonumber
local _math_ceil = math.ceil
local _SoundDuration = SoundDuration
local _Ambients_Cooldown = 10

PLUGIN.name = "Ambient Music"
PLUGIN.description = "Adds background music (client-side)"
PLUGIN.author = "Bilwin"
PLUGIN.schema = "Any"
PLUGIN.songs = {
    {path = "ambients/ambientq1.wav", duration = 211},
    {path = "ambients/ambientq2.wav", duration = 162},
    {path = "ambients/ambientq3.wav", duration = 300},
    {path = "ambients/ambientq4.wav", duration = 136},
	{path = "ambients/ambientq5.wav", duration = 260},
    {path = "ambients/ambientq6.wav", duration = 278},
    {path = "ambients/ambientq7.wav", duration = 126},
    {path = "ambients/ambientq9.wav", duration = 156},
    {path = "ambients/ambientq10.wav", duration = 259},
    {path = "ambients/ambientq11.ogg", duration = 379},       
    {path = "ambients/ambientq12.ogg", duration = 261},         
    {path = "ambients/ambientq13.wav", duration = 284},           
    {path = "ambients/ambientq14.wav", duration = 127},     
    {path = "ambients/ambientq15.wav", duration = 300}, 
    {path = "ambients/ambientq16.wav", duration = 228},    
    {path = "ambients/ambientq17.wav", duration = 103},   
    {path = "ambients/ambientq18.wav", duration = 302},   
    {path = "ambients/ambientq19.wav", duration = 368},   
    {path = "ambients/ambientq16.wav", duration = 310},   
}


ix.lang.AddTable("russian", {
	optEnableAmbient = "Включить фоновую музыку",
    optAmbientVolume = "Громкость фоновой музыки"
})

if (CLIENT) then
    m_flAmbientCooldown = m_flAmbientCooldown or 0
    bAmbientPreSaver = bAmbientPreSaver or false

    ix.option.Add("enableAmbient", ix.type.bool, true, {
		category = PLUGIN.name,
        OnChanged = function(oldValue, value)
            if (value) then
                if IsValid(PLUGIN.ambient) then
                    local volume = ix.option.Get("ambientVolume", 1)
                    PLUGIN.ambient:SetVolume(volume)
                end
            else
                if IsValid(PLUGIN.ambient) then
                    PLUGIN.ambient:SetVolume(0)
                end
            end
        end
	})

	ix.option.Add("ambientVolume", ix.type.number, 0.5, {
		category = PLUGIN.name,
        min = 0.1,
        max = 2,
        decimals = 1,
        OnChanged = function(oldValue, value)
            if IsValid(PLUGIN.ambient) and ix.option.Get("enableAmbient", true) then
                PLUGIN.ambient:SetVolume(value)
            end
        end
	})

    do
        if !table.IsEmpty(PLUGIN.songs) then
            for _, data in ipairs(PLUGIN.songs) do
                util.PrecacheSound(data.path)
            end
        end
    end

    function PLUGIN:CreateAmbient()
        local bEnabled = ix.option.Get('enableAmbient', true)

        if (bEnabled and !bAmbientPreSaver) then
            local flVolume = _tonumber(ix.option.Get('ambientVolume', 1))
            local mSongTable = self.songs[math.random(1, #self.songs)]
            local mSongPath = mSongTable.path
            local mSongDuration = mSongTable.duration or _SoundDuration(mSongPath)

            sound.PlayFile('sound/' .. mSongTable.path, 'noblock', function(radio)
                if IsValid(radio) then
                    if IsValid(self.ambient) then self.ambient:Stop() end

                    radio:SetVolume(flVolume)
                    radio:Play()
                    self.ambient = radio

                    m_flAmbientCooldown = os.time() + _tonumber(mSongDuration) + _Ambients_Cooldown
                end
            end)
        end
    end

    net.Receive('ixPlayAmbient', function()
        if !timer.Exists('mAmbientMusicChecker') then
            timer.Create('mAmbientMusicChecker', 5, 0, function()
                if (m_flAmbientCooldown or 0) > os.time() then return end
                PLUGIN:CreateAmbient()
            end)
        end

        if !timer.Exists('mAmbientChecker') then
            timer.Create('mAmbientChecker', 0.5, 0, function()
                if IsValid(ix.gui.characterMenu) and ix.config.Get("music") ~= "" then
                    if IsValid(PLUGIN.ambient) then
                        PLUGIN.ambient:SetVolume(0)
                    end
                else
                    if ix.option.Get('enableAmbient', true) then
                        if IsValid(PLUGIN.ambient) then
                            local volume = ix.option.Get("ambientVolume", 1)
                            PLUGIN.ambient:SetVolume(volume)
                        end
                    end
                end
            end)
        end
    end)
end

if (SERVER) then
    util.AddNetworkString('ixPlayAmbient')
    function PLUGIN:PlayerLoadedCharacter(client, character, currentChar)
        net.Start('ixPlayAmbient')
        net.Send(client)
    end
end