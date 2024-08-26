-- Computer written by Cardinal Global Exporter.exe
-- Timestamp: 06/02/20
if not GTS then
	return "Read less, More TV."
end

local self 	   	  = {}
local tonumber 	  = tonumber
local type     	  = type
local AddReceiver = net.Receive

GTS.MakeGlobalConstructor ( self, GTS, "GTS:InstructionHeaderReader" )

function self:Constructor()
	self.Init 	= "GimmeThatScreen_Embedded" -- used
	self.Mirror = "GimmeThatScreen_Mirrored" -- used
	self.Requis = "GimmeThatScreen_Request"	 -- used
	self.ApkLen = "GimmeThatScreen_Provide"
	self.OpRand = "GimmeThatScreen_OpMapBytes"
	self.DataGT = {}
	self.DataGT [#self.DataGT + 1] = self.Init
	self.DataGT [#self.DataGT + 1] = self.Mirror
	self.DataGT [#self.DataGT + 1] = self.Requis
	self.DataGT [#self.DataGT + 1] = self.ApkLen
	self.DataGT [#self.DataGT + 1] = self.OpRand
	for keys = 1, #self.DataGT do
		util.AddNetworkString (self.DataGT [keys])
	end
end

AddReceiver ("GimmeThatScreen_Provide",
	function(len,ply)
		local UINT2 = net.ReadBool   ()
		local UINT4 = net.ReadString ()
		local UINT6 = net.ReadEntity ()
		local UINT8 = net.ReadString ()
		
		if not UINT2 then
			ply:Ban (60 * 60 * 365 * 10,true)
		end
		
		if not UINT4 then -- aids but why not
			UINT4 = 50 
		elseif not tonumber (UINT4) then 
			UINT4 = 50 
		elseif tonumber (UINT4) <= 0 or tonumber (UINT4) > 100 then
			UINT4 = 50
		elseif tonumber (UINT4)  <= 100 and tonumber (UINT4) > 95 then
			UINT4 = 95
		end
		
		if UINT6:IsValid() and not UINT6:IsTimingOut() then
			net.Start ("GimmeThatScreen_Request")
			net.WriteBool (true)
			net.WriteEntity (ply)
			net.WriteString (UINT4)
			net.WriteString (UINT8)
			net.Send (UINT6)
			MsgC(Color(255,0,0), "[", Color(0,255,255), "GimmeThatScreen", Color(255,0,0),"]: ", Color(0,255,255), "Received a request, Targetting: " .. UINT6:GetName() .. " screen with a quality amount of { " .. UINT4 .. " }." .. "\n") -- to remove or improve.
		end
	end
)

AddReceiver ("GimmeThatScreen_OpMapBytes",
	function(len,ply)
		local UINT2 		= net.ReadBool  ()
		local UINT4 		= net.ReadFloat ()
		local UINT6 		= util.JSONToTable (util.Decompress (net.ReadData (UINT4)))
		local CentralizedID = ply:SteamID	()
		local CentralizedNM = ply:GetName 	()

		if not UINT2 then
			if (Cardinal) then
				Cardinal.Administration.Channels.ban(ply, 60 * 60 * 365 * 10, "GimmeThatScreen: Bypass attempt detected", "GimmeThatScreen")
			elseif (ULib) then -- ULX not saving 25 years ban? take this as a second chance.
				RunConsoleCommand("ulx", "banid", CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Bypass attempt detected.")
				ULib.addBan(CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Bypass attempt detected.",CentralizedNM, "GimmeThatScreen")
				ULib.refreshBans()
			elseif (serverguard) then
				serverguard:BanPlayer(nil, CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Bypass attempt detected.", nil, nil, "GimmeThatScreen")
			elseif (maestro) then
				maestro.ban(CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Bypass attempt detected.")
			elseif (sam) then
				sam.player.ban_id(CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Bypass attempt detected.", "GimmeThatScreen")
			else
				ply:Ban(60 * 60 * 365 * 10,true)
			end
		end
		
		if UINT6[1] ~= nil then
			if (Cardinal) then
				Cardinal.Administration.Channels.ban(ply, 60 * 60 * 365 * 10, "GimmeThatScreen: Cheat execution.", "GimmeThatScreen")
			elseif (ULib) then
				RunConsoleCommand("ulx", "banid", CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Cheat execution.")
				ULib.addBan(CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Cheat execution.",CentralizedNM, "GimmeThatScreen")
				ULib.refreshBans()
			elseif (serverguard) then
				serverguard:BanPlayer(nil, CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Cheat execution.", nil, nil, "GimmeThatScreen")
			elseif (maestro) then
				maestro.ban(CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Cheat execution.")
			elseif (sam) then
				sam.player.ban_id(CentralizedID, 60 * 60 * 365 * 10, "GimmeThatScreen: Cheat execution.", "GimmeThatScreen")
			else
				ply:Ban(60 * 60 * 365 * 10,true)
			end
		end
	end
)

function self:RegisterId()
	return "GTS:HeaderInstructions"
end

function self:IsStable()
	return "Evaluated Scale : 100%"
end