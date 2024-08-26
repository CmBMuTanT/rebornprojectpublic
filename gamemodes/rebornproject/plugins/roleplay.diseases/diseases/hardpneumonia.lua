
return {
    name = "hardpneumonia",
    description = "Тяжелая пневмония ее можно отличить от обычной пневмонии путем того что температура крайне критичная, человек падает в обморок, и кашляет кровью.",
    canGetRandomly = false,
   -- immuneFactions = { FACTION_MPF, FACTION_OTA },

    OnCall = function( pl )
        pl:GetCharacter():SetData("diseaseInfoTemp", "Критичная Температура")
        pl:GetCharacter():AddBoost("debuffhardpneuma1", "stm", -100) -- да-да) нехуй болеть потому шо
        pl:GetCharacter():AddBoost("debuffhardpneuma2", "str", -100)
        pl:GetCharacter():AddBoost("debuffhardpneuma3", "end", -100)

        pl:_SetTimer( "diseaseHardPneuma::" .. pl:SteamID64(), 60, 0, function()
            pl:SetHealth(pl:Health() - math.random(10, 15))
            if pl:Health() <= 0 then
                pl:Kill()
                ix.Diseases:DisinfectPlayer(pl, "hardpneumonia") -- после смерти освобождаем человека от его ответственности (ну почему нет)
            end
            pl:EmitSound( "ambient/voices/cough" .. math.random(1, 4) .. ".wav", 75, 50 )
            pl:ScreenFade( SCREENFADE.IN, Color(0, 0, 0, 200), 0.3, 0 )
            ix.chat.Send( pl, "me", "сильно закашлялся, что начал отхаркивать кровь" )
            pl:ConsumeStamina(100) -- ну каждые 60 секунд это довольно весело будет наблюдать за этим.
            util.Decal("Blood", pl:GetPos(), pl:GetPos() - Vector(0, 0, 64), pl )
            for k, v in pairs( ents.FindInSphere(pl:GetPos(), 150) ) do
                if ( v:IsValid() and v:IsPlayer() and v:GetCharacter() ) then
                    local value = GIP(v)
                    local maskcheck = value or 90
                    local random = math.random(250) -- шанс заразиться крайне великий даже через маски
                    if random > maskcheck then
                        ix.Diseases:InfectPlayer( v, "cough" )
                    end
                end
            end
        end )
    end,

    OnEnd = function( pl )
        if pl:_TimerExists( "diseaseHardPneuma::" .. pl:SteamID64() ) then
            pl:_RemoveTimer( "diseaseHardPneuma::" .. pl:SteamID64() )
        end

        pl:GetCharacter():RemoveBoost("debuffhardpneuma1", "stm")
        pl:GetCharacter():RemoveBoost("debuffhardpneuma2", "str")
        pl:GetCharacter():RemoveBoost("debuffhardpneuma3", "end")
    end
}
