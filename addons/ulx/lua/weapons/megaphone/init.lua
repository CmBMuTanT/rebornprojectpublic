-- from incredible-gmod.ru with <3

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

hook.Add("PostGamemodeLoaded", "incredible-gmod.ru/megaphoneSWEP", function()
	local voiceDistance = 360000
	local function CalcPlayerCanHearPlayersVoice(listener)
		if IsValid(listener) == false then return end

		listener.ixVoiceHear = listener.ixVoiceHear or {}

		local eyePos = listener:EyePos()
		for _, speaker in ipairs(player.GetHumans()) do
			local speakerEyePos = speaker:EyePos()
			local swep = speaker:GetActiveWeapon()
			listener.ixVoiceHear[speaker] = eyePos:DistToSqr(speakerEyePos) < (
				(IsValid(swep) and swep.IsMegaphone and swep.MicEnabled) and voiceDistance * (swep.voiceDistanceMultiplayer or 2) or voiceDistance
			)
		end
	end

	hook.Add("InitializedConfig", "incredible-gmod.ru/megaphoneSWEP", function()
		voiceDistance = ix.config.Get("voiceDistance") ^ 2
	end)

	hook.Add("VoiceToggled", "incredible-gmod.ru/megaphoneSWEP", function(bAllowVoice)
		for _, ply in ipairs(player.GetHumans()) do
			local uniqueID = ply:SteamID64() .."ixCanHearPlayersVoice"

			if bAllowVoice then
				timer.Create(uniqueID, 0.5, 0, function()
					CalcPlayerCanHearPlayersVoice(ply)
				end)
			else
				timer.Remove(uniqueID)

				ply.ixVoiceHear = nil
			end
		end

		return true -- supress GM hook call
	end)

	hook.Add("VoiceDistanceChanged", "incredible-gmod.ru/megaphoneSWEP", function(distance)
		voiceDistance = distance * distance
	end)

	hook.Add("PostPlayerLoadout", "incredible-gmod.ru/megaphoneSWEP", function(client)
		-- Reload All Attrib Boosts
		local character = client:GetCharacter()

		if character:GetInventory() then
			for _, v in pairs(character:GetInventory():GetItems()) do
				v:Call("OnLoadout", client)

				if v:GetData("equip") and v.attribBoosts then
					for attribKey, attribValue in pairs(v.attribBoosts) do
						character:AddBoost(v.uniqueID, attribKey, attribValue)
					end
				end
			end
		end

		if ix.config.Get("allowVoice") then
			timer.Create(client:SteamID64() .."ixCanHearPlayersVoice", 0.5, 0, function()
				CalcPlayerCanHearPlayersVoice(client)
			end)
		end

		return true -- supress GM hook call
	end)
end)