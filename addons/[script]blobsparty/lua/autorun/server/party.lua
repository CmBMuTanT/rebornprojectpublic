parties = {}

if party.DarkrpGamemode then
	timer.Simple(1, function() --Makes sure the table is loaded before trying to use it
		for k, v in pairs (party.AutoGroupedJobs) do
			parties[k] ={}  
			parties[k].members = {}
			parties[k].name = team.GetName(party.AutoGroupedJobs[k][1])
		end
	end)
end
local meta = FindMetaTable("Player")
  
util.AddNetworkString( "party") 
util.AddNetworkString( "partiesmenu")
util.AddNetworkString( "joinrequest")
util.AddNetworkString( "partyinvite")

function sendpartiestocl()
	net.Start("party")
	net.WriteTable(parties)
	net.Send(player:GetAll())
end



function openpartymenu( ply, text )
	if (text == party.chatcommand )then
		net.Start("partiesmenu", ply)
		net.Send(ply)
		sendpartiestocl()
		return ""
	end
end
	hook.Add( "PlayerSay", "openpartymenu", openpartymenu )

	
function meta:Startparty(name)
	local CanJoin = hook.Call( "CanJoinParty" ,_ , self, self:SteamID64()  )
	if CanJoin != false then
			self:LeaveParty()
			parties[self:SteamID64()] = {}
			parties[self:SteamID64()].members = {self:SteamID64()}
			if name != "" then
				parties[self:SteamID64()].name = string.Left( name , 20 )
			else
				parties[self:SteamID64()].name = self:Nick()
			end
			sendpartiestocl()
			self.invitedcheck = {}
			self.invited = {}
			hook.Run("SPSStartParty", self, parties[self:SteamID64()] )
	end
end
	
concommand.Add( "Startparty", function(ply,_e,args)
	ply:Startparty(args[1])
end )

function meta:joinparty(jointheparty)
	local CanJoin = hook.Call( "CanJoinParty" ,_ , self, jointheparty  )
	if CanJoin then
		self:LeaveParty()
		for v, k in pairs(parties) do
			if v != self:SteamID64() then
				if self:GetParty() == v then
					self:LeaveParty()
				end
			end
		end
		if !table.HasValue(jointheparty.members , self:SteamID64()) then
			if table.Count(jointheparty.members) <= party.maxplayers then
				table.insert(jointheparty.members, self:SteamID64())  
				hook.Run("SPSJoinParty", self, jointheparty )
			else
				self:ChatPrint( party.language["Maximum number of players in this party."].." (" .. party.maxplayers .. ")" )	
			end
		end

	else
		self:ChatPrint( party.language["You are not allowed to join this party."])
	end
	sendpartiestocl()
end

function meta:requestjoin(steam64)
	local CanJoin = hook.Call( "CanJoinParty" ,_ , self, steam64  )
	if CanJoin != false then
		self.requestedtojoin = steam64
		if self.NextRequest == nil then 
			self.NextRequest = 0
		end
		if ( self.NextRequest < CurTime() ) then
			self.NextRequest = CurTime() + party.joinrequestcooldown
			for v, k in pairs(parties) do
				if v == steam64 then
					net.Start("joinrequest")
					net.WriteString(self:SteamID64() )
					net.Send(player.GetBySteamID64(steam64))
					hook.Run("SPSRequestJoin", self, parties[steam64])
				end
			end
		else 
			self:ChatPrint( party.language["Please wait"].." " ..party.joinrequestcooldown.. " "..party.language["seconds between party requests."] )
		end
	else
		self:ChatPrint( party.language["You are not allowed to join this party."])
	end
end

concommand.Add( "requestjoin", function(ply,_e,args)
	ply:requestjoin(args[1])
end)

function meta:answerjoinrequest(steamid64joiner, bool)
	if bool == "true" then
		if player.GetBySteamID64(steamid64joiner).requestedtojoin == self:SteamID64() then
			player.GetBySteamID64(steamid64joiner):joinparty(parties[self:SteamID64()])
			player.GetBySteamID64(steamid64joiner).requestedtojoin = nil
			player.GetBySteamID64(steamid64joiner):ChatPrint( self:Nick().. ": "..party.language["accepted your party request."] )
			hook.Run("SPSRequestResponse", self,parties[self:SteamID64()], player.GetBySteamID64(steamid64joiner), true)
		end
	elseif bool == "false" then
		player.GetBySteamID64(steamid64joiner).requestedtojoin = nil
		player.GetBySteamID64(steamid64joiner):ChatPrint( self:Nick().. ": "..party.language["declined your party request."] )
		hook.Run("SPSRequestResponse", self, parties[self:SteamID64()], player.GetBySteamID64(steamid64joiner), false)
	end
end

concommand.Add( "answerjoinrequest", function(ply,_e,args)
	ply:answerjoinrequest(args[1], args[2] )
end)

function meta:answerinvite(steamid64inviter, bool)
	local CanJoin = hook.Call( "CanJoinParty" ,_ , player.GetBySteamID64(self:SteamID64()), steamid64inviter  )
	if player.GetBySteamID64(steamid64inviter) != false then
		if player.GetBySteamID64(steamid64inviter).invitedcheck then
			if CanJoin then
				if bool == "true" then
					if table.HasValue(player.GetBySteamID64(steamid64inviter).invitedcheck, self:SteamID64()) then
						self:joinparty(parties[steamid64inviter])
						player.GetBySteamID64(steamid64inviter):ChatPrint( self:Nick().. ": "..party.language["accepted your party invite."] )
						table.RemoveByValue(player.GetBySteamID64(steamid64inviter).invitedcheck, self:SteamID64() )
					end
				end
			else
				if table.HasValue(player.GetBySteamID64(steamid64inviter).invitedcheck, self:SteamID64()) then
					player.GetBySteamID64(steamid64inviter).requestedtojoin = nil
					player.GetBySteamID64(steamid64inviter):ChatPrint( self:Nick().. ": "..party.language["declined your party invite."] )
					table.RemoveByValue(player.GetBySteamID64(steamid64inviter).invitedcheck, self:SteamID64() )
				end
			end
			if bool == "false" then
				if table.HasValue(player.GetBySteamID64(steamid64inviter).invitedcheck, self:SteamID64()) then
					player.GetBySteamID64(steamid64inviter).requestedtojoin = nil
					player.GetBySteamID64(steamid64inviter):ChatPrint( self:Nick().. ": "..party.language["declined your party invite."] )
					table.RemoveByValue(player.GetBySteamID64(steamid64inviter).invitedcheck, self:SteamID64() )
				end
			end
		else
			self:ChatPrint( "This party is no longer valid" )
		end
	end
	if party.AutoGroupedJobs[tonumber(steamid64inviter)] != nil then
		if CanJoin then
			if bool == "true" then
				self:joinparty(parties[tonumber(steamid64inviter)])	
			end
			if bool == "false" then	 
				table.RemoveByValue(player.GetBySteamID64(steamid64inviter).invitedcheck, self:SteamID64() )
			end
		else
			table.RemoveByValue(player.GetBySteamID64(steamid64inviter).invitedcheck, self:SteamID64() )
		end
	end
end 

concommand.Add( "answerinvite", function(ply,_e,args)
	ply:answerinvite(args[1], args[2] )
end)

function meta:partyinvite(steamid)
	local CanJoin = hook.Call( "CanJoinParty" ,_ , player.GetBySteamID64(steamid), self:SteamID64()  )
	if CanJoin != false then
		if self.invited[steamid] == nil then
			self.invited[steamid] = {}
		end
		if self.invited[steamid].curtime == nil then 
			self.invited[steamid].curtime = 0
		end
		if ( self.invited[steamid].curtime < CurTime() ) then
			self.invited[steamid].curtime = CurTime() + party.invitecooldown
				net.Start("partyinvite")
				net.WriteString(self:SteamID64())
				net.Send(player.GetBySteamID64(steamid))
				hook.Run("SPSPartyInvite", self, parties[self:SteamID64()], player.GetBySteamID64(steamid) )
		else 
			self:ChatPrint( party.language["Please wait"].." "..party.invitecooldown.." "..party.language["seconds between party invites."] )
		end
	end
end

concommand.Add( "partyinvite", function(ply,_e,args)
	ply:partyinvite(args[1])
	table.insert(ply.invitedcheck,args[1])
end)

function meta:LeaveParty()
	local CanLeave = hook.Call( "CanLeaveParty" ,_ , self, self:GetParty()  )
	if CanLeave != false then
		for v, k in pairs(parties) do
			if table.HasValue(parties[v].members, self:SteamID64()) then
				table.RemoveByValue(parties[v].members, self:SteamID64() )
				hook.Run("SPSLeaveParty",self, parties[v])
			end
			if v == self:SteamID64() then
				self:disbanparty(self:SteamID64())
				--parties[self:SteamID64()] = nil
				self.invitedcheck = nil
			end
		end
	end
	sendpartiestocl()
end

function meta:kickfromparty(steam64)
	for v, k in pairs(parties) do
		if table.HasValue(parties[v].members, steam64) then
			if v == self:SteamID64() or self:IsAdmin() then
				if player.GetBySteamID64(steam64) != false then
					hook.Run("SPSKickedParty", self, player.GetBySteamID64(steam64), player.GetBySteamID64(steam64):GetParty())
					player.GetBySteamID64(steam64):LeaveParty()
					sendpartiestocl()
					player.GetBySteamID64(steam64):ChatPrint( self:Nick().. ": "..party.language["kicked you from the party."] )

				else
					for v, k in pairs(parties) do
						if table.HasValue(parties[v].members, steam64) then
							hook.Run("SPSKickedParty", self, player.GetBySteamID64(steam64), player.GetBySteamID64(steam64):GetParty())
							table.RemoveByValue(parties[v].members, steam64 )
							sendpartiestocl()
						end
					end
				end
			end
		end
	end
end

concommand.Add( "kickfromparty", function(ply,_e,args)
	ply:kickfromparty(args[1]) 
end)

function meta:disbanparty(steam64)
	for v, k in pairs(parties) do
		if table.HasValue(parties[v].members, steam64) then
			if self:IsAdmin() or (self == player.GetBySteamID64(steam64))then
				hook.Run("SPSDisbandedParty", self, parties[v])
				parties[v] = nil
				sendpartiestocl()
				if player.GetBySteamID64(steam64) != false then
					player.GetBySteamID64(steam64):ChatPrint( self:Nick().. ": "..party.language["disbaned your party."] )
				end

			end
		end
	end
end

concommand.Add( "disbanparty", function(ply,_e,args)
	ply:disbanparty(args[1])
end)

concommand.Add( "leaveparty", function(ply)
	ply:LeaveParty()
end)

function partyleaderleft( ply )
	for v, k in pairs(parties) do
		if v == ply:SteamID64() then
			hook.Run("SPSPartyLeaderLeft", ply, parties[v])
			parties[ply:SteamID64()] = nil
			ply.invitedcheck = nil
			sendpartiestocl()
		else
			if party.kickondisconnect then
				if table.HasValue(parties[v].members, ply:SteamID64()) then
					table.RemoveByValue(parties[v].members, ply:SteamID64() )
					sendpartiestocl()
				end
			end
		end
	end
end
hook.Add( "PlayerDisconnected", "partyleaderleft", partyleaderleft )


function partydamage(victim, attacker )
	if party.PartyDamage != true then
		if victim:IsPlayer() and attacker:IsPlayer() then
			if (victim:GetParty() != nil) and (attacker:GetParty() != nil ) then
				if (victim:GetParty() == attacker:GetParty()) then
					if victim != attacker then
						return false
					end
				end
			end
		end
	end
end
hook.Add( "PlayerShouldTakeDamage", "partydamage", partydamage)

if party.DarkrpGamemode then
	function Party_TeamChange(ply, before, after)
	local GroupedJobJoin
	local GroupedJobLeave
		for v,k in pairs (party.AutoGroupedJobs) do
			if table.HasValue(party.AutoGroupedJobs[v], after) then
				GroupedJobJoin = v
			end
		end
		for v,k in pairs (party.AutoGroupedJobs) do
			if table.HasValue(party.AutoGroupedJobs[v], before) then
				if ply:GetParty() == v then
					GroupedJobLeave = v
				end
			end
		end
		if GroupedJobLeave then
			ply:LeaveParty()
		end
		if GroupedJobJoin != nil then
			if party.ForceJobParty == true then
				ply:LeaveParty()
				ply:joinparty(parties[GroupedJobJoin])
			else
				TeamPartyInvite(ply:SteamID64(), GroupedJobJoin)
			end
		end
	end
	hook.Add("OnPlayerChangedTeam", "Party_PlayerChangedTeams", Party_TeamChange)

	function GroupedCanJoin(ply, tojoinparty)
		local canjoin = true
		
		if table.HasValue(party.BlacklistJobs, ply:Team()) then
			canjoin = false
		end
		
		if party.ForceJobParty == true then
			if party.AutoGroupedJobs[tojoinparty] then
				if !table.HasValue(party.AutoGroupedJobs[tojoinparty], ply:Team()) then
					canjoin = false
				end
			end
			for v,k in pairs(party.AutoGroupedJobs)do
				if ply:GetParty() == v and tojoinparty != parties[ply:GetParty()]then
					ply:ChatPrint( party.language["You are currently in a forced party, change jobs."])
					canjoin = false
				end
			end
		end
		
		return canjoin
	end
	hook.Add("CanJoinParty", "GroupedCanJoin" , GroupedCanJoin )


	function GroupedCanLeave(ply, toleaveparty)
	if party.ForceJobParty == true then
		for v,k in pairs(party.AutoGroupedJobs)do
				if party.AutoGroupedJobs[toleaveparty] then
					if table.HasValue(party.AutoGroupedJobs[toleaveparty], ply:Team()) then
						return false
					end
				end
			end
		end
	end
	hook.Add("CanLeaveParty", "GroupedCanLeave" , GroupedCanLeave )



	function TeamPartyInvite(steamid, team)
		local CanJoin = hook.Call( "CanJoinParty" ,_ , player.GetBySteamID64(steamid), team  )
		if CanJoin != false then
			net.Start("partyinvite")
			net.WriteString(team)
			net.Send(player.GetBySteamID64(steamid))
		end
	end
end

local function partyspawn( ply )
	sendpartiestocl()
end
hook.Add( "PlayerInitialSpawn", "partyspawn", partyspawn )