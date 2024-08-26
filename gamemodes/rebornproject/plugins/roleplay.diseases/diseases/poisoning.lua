
return {
    name = "poisoning",
    description = "Обычное пищевое отравление.",
    canGetRandomly = false,
   -- immuneFactions = { FACTION_MPF, FACTION_OTA },

    OnCall = function( pl )
        pl:GetCharacter():SetData("diseaseInfoTemp", "Слегка повышенная температура")
        pl:GetCharacter():AddBoost("debuffpoison1", "stm", -50) -- да-да) нехуй болеть потому шо
        pl:GetCharacter():AddBoost("debuffpoison2", "str", -50)
        pl:GetCharacter():AddBoost("debuffpoison3", "end", -50)

        pl:_SetTimer( "diseasePoisoning::" .. pl:SteamID64(), 60, 0, function()
            pl:EmitSound( "npc/barnacle/barnacle_digesting" .. math.random(1, 2) .. ".wav", 50)
            pl:ScreenFade( SCREENFADE.IN, Color(0, 0, 0, 200), 0.3, 0 )
            ix.chat.Send( pl, "me", "ощущает тошнотики" )
            pl:ConsumeStamina(100) -- ну каждые 60 секунд это довольно весело будет наблюдать за этим.
        end)
        pl:_SetSimpleTimer(5400, function()
            ix.Diseases:DisinfectPlayer(pl, "poisoning") -- само пройдет
        end)
    end,

    OnEnd = function( pl )
        if pl:_TimerExists( "diseasePoisoning::" .. pl:SteamID64() ) then
            pl:_RemoveTimer( "diseasePoisoning::" .. pl:SteamID64() )
            
        end

        pl:GetCharacter():RemoveBoost("debuffpoison1", "stm")
        pl:GetCharacter():RemoveBoost("debuffpoison2", "str")
        pl:GetCharacter():RemoveBoost("debuffpoison3", "end")
    end
}
