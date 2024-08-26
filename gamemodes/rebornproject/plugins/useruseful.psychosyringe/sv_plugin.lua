function PLUGIN:SetupPSYCHOtimer(client, character, data, datatimer)
    local steamID = client:SteamID64()
    local datatimer = datatimer or 5
    local startTime = os.time()

    timer.Create("Psyche_" .. steamID..data, 1, 0, function()
        if (IsValid(client) and character) then
            self:PsycheTick(client, character, data, startTime, datatimer)
        else
            timer.Remove("Psyche_" .. steamID)
        end
    end)
end

function PLUGIN:PsycheTick(client, character, data, startTime, datatimer)
	if (!client:Alive() or client:GetMoveType() == MOVETYPE_NOCLIP) then
		return
	end

	local currentTime = os.time()
	local elapsedTime = currentTime - startTime 

	if (elapsedTime >= datatimer) then
		local boosts = character:GetBoosts()

		for attribID, v in pairs(boosts) do
			for boostID, _ in pairs(v) do
				character:RemoveBoost(boostID, attribID)
			end
		end

        character:SetData("PSYCHOSYN", character:GetData("PSYCHOSYN", 0) - 1)
		timer.Remove("Psyche_" .. client:SteamID64()..data)
	end
end

function PLUGIN:PostPlayerDeath(client)
    local character = client:GetCharacter()
    if !character then return end
    local boosts = character:GetBoosts()

    for attribID, v in pairs(boosts) do
        for boostID, _ in pairs(v) do
            character:RemoveBoost(boostID, attribID)
        end
    end
end