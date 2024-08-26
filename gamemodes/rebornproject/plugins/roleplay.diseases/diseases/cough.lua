
return {
    name = "Cough",
    description = "A regular cough, generally not dangerous at all",
    canGetRandomly = true,
  --  immuneFactions = { FACTION_MPF, FACTION_OTA },

    OnCall = function( pl )
        pl:GetCharacter():SetData("diseaseInfoTemp", "Повышенная Температура")
        pl:_SetTimer( "diseaseCough::" .. pl:SteamID64(), 60, 0, function()
            pl:EmitSound( "ambient/voices/cough" .. math.random(1, 4) .. ".wav" )
            pl:ScreenFade( SCREENFADE.IN, Color(0, 0, 0, 200), 0.3, 0 )
            ix.chat.Send( pl, "me", "закашлялся" )
            for k, v in pairs( ents.FindInSphere(pl:GetPos(), 120) ) do
                if ( v:IsValid() and v:IsPlayer() and v:GetCharacter() ) then
                    local value = GIP(v)
                    local maskcheck = value or 90
                    local random = math.random(100)
                    if random > maskcheck then
                        ix.Diseases:InfectPlayer( v, "cough" )
                    end
                end
            end
        end )

        pl:_SetSimpleTimer(5400, function() -- 1.5 часа до пневмача даем ему
            ix.Diseases:InfectPlayer( pl, "pneumonia" )
            ix.Diseases:DisinfectPlayer(pl, "cough")
        end)
    end,

    OnEnd = function( pl )
        if pl:_TimerExists( "diseaseCough::" .. pl:SteamID64() ) then
            pl:_RemoveTimer( "diseaseCough::" .. pl:SteamID64() )
        end
    end
}
