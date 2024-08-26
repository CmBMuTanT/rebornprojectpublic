PLUGIN.name = "Рация и не более."
PLUGIN.author = "KriegKaiser aka Lucifer"
PLUGIN.description = "Криг/Разговор/Шёпот."

if (SERVER) then
	hook.Add('PlayerCanHearPlayersVoice', 'PlayerCanHearPlayersVoice.Chatter', function(listener, speaker)
		if (!IsValid(speaker)) or (!IsValid(listener)) or (listener == speaker) or (!listener:IsPlayer()) or (!speaker:IsPlayer()) or (listener:IsBot() or speaker:IsBot()) then
			return false
		end
		
		local lis_char = listener:GetCharacter()
		local speak_char = speaker:GetCharacter()
		if not (lis_char and speak_char) then return false end

		local lis_radio = listener:ExtraInventory("radio"):GetEquipedItem("chatter")
		local speak_radio = speaker:ExtraInventory("radio"):GetEquipedItem("chatter")
		if speaker:KeyDown(IN_WALK) and speak_radio then

			if (lis_radio and lis_radio:GetData("equip") == true and lis_radio:GetData("BatteryCondition", nil) ~= nil and lis_radio:GetData("BatteryCondition", nil) > 1 and speak_radio and speak_radio:GetData("equip") == true and speak_radio:GetData("BatteryCondition", nil) ~= nil and speak_radio:GetData("BatteryCondition", nil) > 1 and speak_radio:GetData("freq") == lis_radio:GetData("freq")) then
				--listener:SetDSP(56)
				return true, false
			else
				return false
			end
		end	
	end)
end