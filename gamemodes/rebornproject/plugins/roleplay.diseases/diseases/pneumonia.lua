
return {
    name = "pneumonia",
    description = "Более тяжелая болезнь кашля, уже может довести до летального исхода.",
    canGetRandomly = false,
   -- immuneFactions = { FACTION_MPF, FACTION_OTA },

    OnCall = function( pl )
        pl:GetCharacter():SetData("diseaseInfoTemp", "Высокая Температура")
        pl:GetCharacter():AddBoost("debuffpneuma1", "stm", -75) -- да-да) нехуй болеть потому шо
        pl:GetCharacter():AddBoost("debuffpneuma2", "str", -75)
        pl:GetCharacter():AddBoost("debuffpneuma3", "end", -75)

        pl:_SetTimer( "diseasePneuma::" .. pl:SteamID64(), 60, 0, function()
            pl:EmitSound( "ambient/voices/cough" .. math.random(1, 4) .. ".wav", 75, 70 )
            pl:ScreenFade( SCREENFADE.IN, Color(0, 0, 0, 200), 0.3, 0 )
            ix.chat.Send( pl, "me", "сильно закашлялся, что начал отхаркивать мокроту" )
            pl:ConsumeStamina(100) -- ну каждые 60 секунд это довольно весело будет наблюдать за этим.
            pl:SetHealth(math.Clamp(pl:Health() - math.random(5, 10), 5, pl:GetMaxHealth()))
            util.Decal("Blood", pl:GetPos(), pl:GetPos() - Vector(0, 0, 64), pl )
            for k, v in pairs( ents.FindInSphere(pl:GetPos(), 150) ) do
                if ( v:IsValid() and v:IsPlayer() and v:GetCharacter() ) then
                    local value = GIP(v)
                    local maskcheck = value or 90
                    local random = math.random(160) -- шанс заразиться крайне великий даже через маски
                    if random > maskcheck then
                        ix.Diseases:InfectPlayer( v, "cough" )
                    end
                end
            end
        end )
        pl:_SetSimpleTimer(5400, function()
            ix.Diseases:InfectPlayer( pl, "hardpneumonia" )
            ix.Diseases:DisinfectPlayer(pl, "pneumonia")
        end)
    end,

    OnEnd = function( pl )
        if pl:_TimerExists( "diseasePneuma::" .. pl:SteamID64() ) then
            pl:_RemoveTimer( "diseasePneuma::" .. pl:SteamID64() )
        end

        pl:GetCharacter():RemoveBoost("debuffpneuma1", "stm")
        pl:GetCharacter():RemoveBoost("debuffpneuma2", "str")
        pl:GetCharacter():RemoveBoost("debuffpneuma3", "end")
    end
}
