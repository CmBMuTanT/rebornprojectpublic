local NetMessages = { "OpenPartyMenu", "ManagePlayers", "PartyDisband", "MyParty", "SendParties", "PartySettings", "CreateParty", "ModifyParty", "PartyCheck", "ErrorPopup", "GetDetails", "PartyChat" }

BlobsParties = BlobsParties or {}

for k,v in pairs(NetMessages) do
	util.AddNetworkString("blobsParty:"..v)
end

concommand.Add("partymenu", function(ply)
	net.Start("blobsParty:OpenPartyMenu")
	net.Send(ply)
end)

net.Receive("blobsParty:SendParties", function(len,ply)
	net.Start("blobsParty:SendParties")
		net.WriteTable(BlobsParties)
	net.Send(ply)
end)

local function UpdateParty(partyname)
	for k,v in pairs(BlobsParties) do
		if v.name == partyname then
			for _,v2 in pairs(v.members) do
				net.Start("blobsParty:MyParty")
						net.WriteTable(v)
				net.Send(v2)
			end
			break
		end
	end
end

local function UpdatePartyDisband(partyname)
	for k,v in pairs(BlobsParties) do
		if v.name == partyname then
			for _,v2 in pairs(v.members) do
				net.Start("blobsParty:PartyDisband")
				net.Send(v2)
			end
			break
		end
	end
end

local function isInBlobParty(ply)
	for a,b in pairs(BlobsParties) do
		for c,d in pairs(b.members) do
			if d == ply then
				return true
			end
		end
	end
	
	return false
end

local function PartyCMD(ply, txt)
	local txt = string.lower(txt)	
	local args = string.Explode(" ", txt)
	if table.HasValue(BlobsPartyConfig.PartyCommands, args[1]) then
		ply:ConCommand("partymenu")
		return ""
	end
	
end
hook.Add("PlayerSay", "blobsParty:PlayerSayParty", PartyCMD)

local function addToBlobParty(ply, party)
	for a,b in pairs(BlobsParties) do
		if b.name == party then
			table.insert(b.members, ply)
			break
		end
	end
end

local function messageBlobParty(party, msg)
	for a,b in pairs(BlobsParties) do
		if b.name == party then
			for c,d in pairs(b.members) do
				d:ChatPrint(msg)
			end
			break
		end
	end
end

local function removeFromBlobParty(ply, party)
	for a,b in pairs(BlobsParties) do
		if b.name == party then
			table.RemoveByValue(b.members, ply)
		end
	end

end

local function isOwnerOfBlobParty(partyname, ply)
	for a,b in pairs(BlobsParties) do
		if b.name == partyname then
			if b.owner == ply then
				return true
			end
		end
	end
	
	return false
end

local function disbandBlobParty(owner)
	for a,b in pairs(BlobsParties) do
		if b.owner == owner then
			table.RemoveByValue(BlobsParties, b)
			break
		end
	end
end

local function getBlobPartyOwner(partyname)
	for a,b in pairs(BlobsParties) do
		if b.name == partyname then
			return b.owner
		end
	end
end

local function whatBlobParty(ply)
	for a,b in pairs(BlobsParties) do
		for c,d in pairs(b.members) do
			if d == ply then
				return b.name
			end
		end
	end
	
	return nil
end

local function addBlobJoinRequest(ply, party)
	for a,b in pairs(BlobsParties) do
		if b.name == party then
			table.insert(b.requests, ply)
			break
		end
	end
end

local function removeBlobJoinRequest(ply, party)
	for a,b in pairs(BlobsParties) do
		if b.name == party then
			table.RemoveByValue(b.requests, ply)
			break
		end
	end
end

local function wantsToJoinBlobParty(ply, party)
	for a,b in pairs(BlobsParties) do
		if b.name == party then
			for c,d in pairs(b.invitesIn) do
				if d == ply then
					return true
				end
			end
		end
	end
	
	return false
end

local function GetBlobPartyMembers(ply)
	for a,b in pairs(BlobsParties) do
		for c,d in pairs(b.members) do
			if d == ply then
				return b.members
			end
		end
	end
end

local function blobPartyExists(partyname)
	for a,b in pairs(BlobsParties) do
		if b.name == partyname then
			return true
		end
	end
	
	return false
end

local function blobGetParty(partyname)
	for a,b in pairs(BlobsParties) do
		if b.name == partyname then
			return b
		end
	end
	
	return {}
end

local function SendPChat(party, ply, text)
	for k,v in pairs(BlobsParties) do
		if v.name == party then
			for _,v2 in pairs(v.members) do
				net.Start("blobsParty:PartyChat")
					net.WriteEntity(ply)
					net.WriteString(text)
				net.Send(v2)
			end
			
			hook.Run("blobsParty_PartyChat", ply, text, party)
		end
	end
end

local function blobsPartyChat(ply, txt)
	local args = string.Explode(" ", txt)
	if table.HasValue(BlobsPartyConfig.PartyChatCommands, args[1]) then
		if #args > 1 and isInBlobParty(ply) then
			table.remove(args, 1)
			local stxt = ""
			for k,v in pairs(args) do
				stxt = stxt .. v .. " "
			end
			SendPChat(whatBlobParty(ply), ply, stxt)
			return ""
		end
	end
end
hook.Add("PlayerSay", "blobsParty:PlayerSayPChat", blobsPartyChat)

net.Receive("blobsParty:GetDetails", function(len,ply)
	local partyname = net.ReadString()
	if blobPartyExists(partyname) then
		net.Start("blobsParty:GetDetails")
			net.WriteTable(blobGetParty(partyname))
			net.WriteBool(isInBlobParty(ply))
		net.Send(ply)
	end
end)

net.Receive("blobsParty:PartyCheck", function(len,ply)
		net.Start("blobsParty:PartyCheck")
	if isOwnerOfBlobParty(whatBlobParty(ply), ply) then
			net.WriteString("owner")
	elseif isInBlobParty(ply) then
			net.WriteString("member")
	else
			net.WriteString("no party")
	end
		net.Send(ply)
end)

net.Receive("blobsParty:CreateParty", function(len,ply)
	if not isInBlobParty(ply) then
		local newparty = {}	
		local partyname = net.ReadString()
		local partysize = net.ReadUInt(32)
		local invite = net.ReadString()
		local enfriendlyfire = false
		if BlobsPartyConfig.FriendlyFireToggle then
			enfriendlyfire = net.ReadBool()
		end
		local errors = {}
		if string.len(partyname) < BlobsPartyConfig.MinNameSize then
			table.insert(errors, BlobsPartyConfig.NameTooShort)
		end
		if string.len(partyname) > BlobsPartyConfig.MaxNameSize then
			table.insert(errors, BlobsPartyConfig.NameTooLong)
		end
		
		if partysize < BlobsPartyConfig.MinSize then
			table.insert(errors, BlobsPartyConfig.SizeTooSmall)
		end
		if partysize > BlobsPartyConfig.MaxSize then
			table.insert(errors, BlobsPartyConfig.SizeTooBig)
		end
		
		if blobPartyExists(partyname) then
			table.insert(errors, BlobsPartyConfig.PartyNameExists)
		end
		
		if #errors == 0 then
			newparty.owner = ply
			newparty.name = partyname
			newparty.size = partysize
			
			if invite == "true" or invite == "false" then
				newparty.invite = invite
			else
				newparty.invite = "true"
			end
			
			local members = {}
			local requests = {}
			table.insert(members, ply)
			newparty.members = members
			newparty.requests = requests
			newparty.usering = true
			newparty.useglow = false
			if BlobsPartyConfig.FriendlyFireToggle then
				newparty.friendlyfire = enfriendlyfire
			else
				newparty.friendlyfire = false
			end
			newparty.ringcolor = ColorRand()
			newparty.glowcolor = ColorRand()
			
			table.insert(BlobsParties, newparty)
			UpdateParty(partyname)
			ply:ConCommand("partymenu")
			
			hook.Run("blobsParty_PartyCreate", ply, partyname)
		else
			net.Start("blobsParty:ErrorPopup")
				net.WriteTable(errors)
			net.Send(ply)
		end
	end
end)

net.Receive("blobsParty:ManagePlayers", function(len,ply)
	if isOwnerOfBlobParty(whatBlobParty(ply), ply) then
		net.Start("blobsParty:ManagePlayers")
			net.WriteString("owner")
			net.WriteTable(blobGetParty(whatBlobParty(ply)))
		net.Send(ply)
	elseif isInBlobParty(ply) then
		net.Start("blobsParty:ManagePlayers")
			net.WriteString("member")
		net.Send(ply)
	else
		net.Start("blobsParty:ManagePlayers")
			net.WriteString("none")
		net.Send(ply)
	end
end)

net.Receive("blobsParty:ModifyParty", function(len,ply)
	local PartyCommand = net.ReadString()
	
	if PartyCommand == "status" then
		if isOwnerOfBlobParty(whatBlobParty(ply), ply) then
			net.Start("blobsParty:PartySettings")
				net.WriteString("owner")
				net.WriteTable(blobGetParty(whatBlobParty(ply)))
			net.Send(ply)
		elseif isInBlobParty(ply) then
			net.Start("blobsParty:PartySettings")
				net.WriteString("member")
			net.Send(ply)
		else
			net.Start("blobsParty:PartySettings")
				net.WriteString("none")
			net.Send(ply)
		end
	elseif PartyCommand == "modify" then
		if not isOwnerOfBlobParty(whatBlobParty(ply), ply) then return end
		
		local newpartyname = net.ReadString()
		local newpartysize = net.ReadUInt(32)
		local newinvite = net.ReadString()
		local newff = false
		if BlobsPartyConfig.FriendlyFireToggle then
			newff = net.ReadBool()
		end
		local errors = {}
		if string.len(newpartyname) < BlobsPartyConfig.MinNameSize then
			table.insert(errors, BlobsPartyConfig.NameTooShort)
		end
		if string.len(newpartyname) > BlobsPartyConfig.MaxNameSize then
			table.insert(errors, BlobsPartyConfig.NameTooLong)
		end
		
		if newpartysize < BlobsPartyConfig.MinSize then
			table.insert(errors, BlobsPartyConfig.SizeTooSmall)
		end
		if newpartysize > BlobsPartyConfig.MaxSize then
			table.insert(errors, BlobsPartyConfig.SizeTooBig)
		end
		
		if newpartyname != whatBlobParty(ply) then
			if blobPartyExists(newpartyname) then
				table.insert(errors, BlobsPartyConfig.PartyNameExists)
			end
		end
		
		if #errors == 0 then
			local PartyTBL = blobGetParty(whatBlobParty(ply))
			local oldpartyname = PartyTBL.name
			
			PartyTBL.name = newpartyname
			PartyTBL.size = newpartysize
			PartyTBL.invite = newinvite
			if BlobsPartyConfig.FriendlyFireToggle then
				PartyTBL.friendlyfire = newff
			end
			
			ply:ConCommand("partymenu")
			UpdateParty(newpartyname)
			
			if oldpartyname != newpartyname then
				hook.Run("blobsParty_PartyNameEdit", ply, oldpartyname, newpartyname)
			end
		else
			net.Start("blobsParty:ErrorPopup")
				net.WriteTable(errors)
			net.Send(ply)
		end
	elseif PartyCommand == "ring" then
		if not isOwnerOfBlobParty(whatBlobParty(ply), ply) then return end
		local BoolEnabled = net.ReadBool()
		local RingColor = net.ReadColor()
		
		local PartyTBL = blobGetParty(whatBlobParty(ply))
		PartyTBL.usering = BoolEnabled
		PartyTBL.ringcolor = RingColor
		UpdateParty(whatBlobParty(ply))
	elseif PartyCommand == "glow" then
		if not isOwnerOfBlobParty(whatBlobParty(ply), ply) then return end
		local BoolEnabled = net.ReadBool()
		local GlowColor = net.ReadColor()
		
		local PartyTBL = blobGetParty(whatBlobParty(ply))
		PartyTBL.useglow = BoolEnabled
		PartyTBL.glowcolor = GlowColor
		UpdateParty(whatBlobParty(ply))
	elseif PartyCommand == "disband" then
		if isOwnerOfBlobParty(whatBlobParty(ply), ply) then
			local PartyTBL = blobGetParty(whatBlobParty(ply))
			local partyname = PartyTBL.name
			UpdatePartyDisband(whatBlobParty(ply))
			messageBlobParty(whatBlobParty(ply), BlobsPartyConfig.PartyDisbanded)
			disbandBlobParty(ply)
			ply:ConCommand("partymenu")
			
			hook.Run("blobsParty_PartyDisband", ply, partyname)
		end
	elseif PartyCommand == "leave" then
		local party = whatBlobParty(ply)
		net.Start("blobsParty:PartyDisband")
		net.Send(ply)
		removeFromBlobParty(ply, party)
		ply:ConCommand("partymenu")
		UpdateParty(party)
		messageBlobParty(party, string.Replace(BlobsPartyConfig.PlayerLeave, "{p}", ply:Nick()))
		
		hook.Run("blobsParty_PartyLeave", ply, party)
	elseif PartyCommand == "accept" then
		if not isOwnerOfBlobParty(whatBlobParty(ply), ply) then return end
		local PartyName = whatBlobParty(ply)
		local AcceptedPlayer = net.ReadEntity()
		if IsValid(AcceptedPlayer) and AcceptedPlayer:IsPlayer() then
			removeBlobJoinRequest(AcceptedPlayer, whatBlobParty(ply))
			addToBlobParty(AcceptedPlayer, PartyName)
			ply:ConCommand("partymenu")
			UpdateParty(PartyName)
			
			messageBlobParty(PartyName, string.Replace(BlobsPartyConfig.PlayerJoin, "{p}", AcceptedPlayer:Nick()))
			
			hook.Run("blobsParty_PartyAccept", ply, whatBlobParty(ply), AcceptedPlayer)
		end
	elseif PartyCommand == "join" then
		local party = blobGetParty(net.ReadString())
		if isInBlobParty(ply) then
			local errors = {BlobsPartyConfig.AlreadyIn}
			net.Start("blobsParty:ErrorPopup")
				net.WriteTable(errors)
			net.Send(ply)
		else
			if #party.members + 1 > party.size then
				local errors = {BlobsPartyConfig.Full}
				net.Start("blobsParty:ErrorPopup")
					net.WriteTable(errors)
				net.Send(ply)
			else
				if tobool(party.invite) then
					if table.HasValue(party.requests, ply) then
						ply:ChatPrint(BlobsPartyConfig.AlreadyRequested)
					else
						ply:ChatPrint(BlobsPartyConfig.ReqSent)
						addBlobJoinRequest(ply, party.name)
						party.owner:ChatPrint(string.Replace(BlobsPartyConfig.PlayerReqToJoin, "{p}", ply:Nick()))
					end
				else
					addToBlobParty(ply, party.name)
					ply:ConCommand("partymenu")
					UpdateParty(party.name)
					messageBlobParty(party.name, string.Replace(BlobsPartyConfig.PlayerJoin, "{p}", ply:Nick()))
					
					hook.Run("blobsParty_PartyJoin", ply, party.name)
				end
			end
		end
	elseif PartyCommand == "giveowner" then
		local party = whatBlobParty(ply)
		if not isOwnerOfBlobParty(party, ply) then return end
		local GiveOwnerEnt = net.ReadEntity()
		if party == whatBlobParty(GiveOwnerEnt) and ply != GiveOwnerEnt then
			local PartyTBL = blobGetParty(party)
			PartyTBL.owner = GiveOwnerEnt
			ply:ConCommand("partymenu")
			UpdateParty(party)
			messageBlobParty(PartyTBL.name, string.Replace(BlobsPartyConfig.NewOwner, "{p}", GiveOwnerEnt:Nick()))
			
			hook.Run("blobsParty_PartyGiveOwner", ply, GiveOwnerEnt, PartyTBL.name)
		else
			local errors = {"Cannot give owner to this member, they are not in your party!"}
			net.Start("blobsParty:ErrorPopup")
				net.WriteTable(errors)
			net.Send(ply)
		end
	elseif PartyCommand == "kick" then
		local party = whatBlobParty(ply)
		if not isOwnerOfBlobParty(party, ply) then return end
		local KickedPlayer = net.ReadEntity()
		if party == whatBlobParty(KickedPlayer) and ply != KickedPlayer then
			net.Start("blobsParty:PartyDisband")
			net.Send(KickedPlayer)
			messageBlobParty(party, string.Replace(BlobsPartyConfig.PlayerKicked, "{p}", KickedPlayer:Nick()))
			removeFromBlobParty(KickedPlayer, party)
			
			net.Start("blobsParty:ManagePlayers")
				net.WriteString("owner")
				net.WriteTable(blobGetParty(party))
			net.Send(ply)
			
			UpdateParty(party)
			
			hook.Run("blobsParty_PartyKick", ply, KickedPlayer, party)
		else
			local errors = {"Cannot kick this member, they are not in your party!"}
			net.Start("blobsParty:ErrorPopup")
				net.WriteTable(errors)
			net.Send(ply)
		end
	end
end)

hook.Add("PlayerDisconnected", "blobsParty:PlayerDisconnected", function(ply)
	if isInBlobParty(ply) then
		local theParty = whatBlobParty(ply)
		if isOwnerOfBlobParty(theParty, ply) then
			UpdatePartyDisband(theParty)
			messageBlobParty(theParty, BlobsPartyConfig.OwnerLeaveDisband)
			disbandBlobParty(ply)
		else
			removeFromBlobParty(ply, theParty)
			UpdateParty(theParty)
			messageBlobParty(theParty, string.Replace(BlobsPartyConfig.PlayerLeave, "{p}", ply:Nick()))
		end
	end
end)

hook.Add("PlayerShouldTakeDamage", "blobsParty:PlayerShouldTakeDamage", function(ply,att)
	if BlobsPartyConfig.FriendlyFireToggle then
		if IsValid(ply) and IsValid(att) then
			if ply:IsPlayer() and att:IsPlayer() then
				local PartyTBL = blobGetParty(whatBlobParty(ply))
				if whatBlobParty(ply) == whatBlobParty(att) and PartyTBL.friendlyfire then
					return false
				end
			end
		end
	end
end)