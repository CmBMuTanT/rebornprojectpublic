local PLUGIN = PLUGIN

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	timer.Simple(0.1, function()
		if (IsValid(client)) then
			client:SetLocalVar("new.voicedistance", 5)
		end
	end)
end
	

netstream.Hook("CMBTK:VoiceDistance", function(client, level)
    if !IsValid(client) and !client:Alive() then return end

    local char = client:GetCharacter()
	if !char then return end
    if !isnumber(level) then return end

    local normalizelevel = math.floor(math.Clamp(level, 1, 10))

    client:SetLocalVar("new.voicedistance", normalizelevel)
end)

function PLUGIN:PlayerCanHearPlayersVoice(listener, speaker)
	local SP_data = self.VoiceDistanceTable[speaker:GetLocalVar("new.voicedistance", 5)]

	if SP_data then
		local NewDist = SP_data * ix.config.Get("chatRange", 280)
		return (listener:GetPos():Distance(speaker:GetPos()) <= NewDist)
	end
end