if SERVER then
	util.AddNetworkString( "PartyChat")
	local function SendPartyMessage(ply, text)
		local Chatmembers = {}
		for v, k in pairs (parties[ply:GetParty()].members) do
			table.insert(Chatmembers , player.GetBySteamID64(k))
		end
		local chattext = string.Right(text, string.len(text) - string.len( party.partychatcommand) - 1)
		local chattable = {ply:Nick(), chattext }
		net.Start("PartyChat")
		net.WriteTable(chattable)
		net.Send(Chatmembers)
		hook.Run("SPSChat", ply, ply:GetParty(), chattext)
	end
	
	hook.Add( "PlayerSay", "PartyChatMessage", function(ply,text)
		if string.Left( text, string.len(party.partychatcommand) + 1 ) == party.partychatcommand.." " then  
		ServerLog("[Группа] "..ply:Nick() ..": ".. text.."\n")
			if ply:GetParty() != nil then			
				SendPartyMessage(ply, text)

			end
		return ""
		end
	end)
end




if CLIENT then
	net.Receive("PartyChat", function(len, CLIENT)
		local chattable = net.ReadTable()
		chat.AddText( party.partychatcolr, party.language["[Группа]"],  party.partychatnamecolr, chattable[1]..": ", party.partychatmsgcolr, chattable[2])
	end)
end