AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

-- Networking between client and server
	util.AddNetworkString("TF2R_OpenSongMenu") 
	util.AddNetworkString("TF2R_SelectedSong") 
	util.AddNetworkString("TF2R_StopSong") 
--

for k, v in pairs(file.Find("sound/tf2_radio/*.mp3","GAME")) do

	sound.Add( {
		name = "tf2_radio_song_"..string.sub(v,1,2),
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 80,
		pitch = 100,
		sound = "tf2_radio/"..v,
	} )

end

function ENT:Initialize()

	self.Songtable = file.Find("sound/tf2_radio/*.mp3","GAME")
	self.CurrentSong = 0

	self:SetModel("models/metro_redux/other_exodus/radio_station.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetNWInt("TrackNr", "...") 

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then

		phys:Wake()

	end
	
end


function ENT:Use(ply)

	self:SetUseType(SIMPLE_USE)

	net.Start("TF2R_OpenSongMenu", false )
		net.WriteTable( self.Songtable )
	net.Send( ply ) 

	net.Receive("TF2R_SelectedSong",function()
		local song = net.ReadFloat()
		self:PlaySong(song)
	end)

end

function ENT:PlaySong(song)
	if song == 0 then
		self:StopSound("tf2_radio_song_"..self.CurrentSong)
		self:StopSound("tf2_radio_song_0"..self.CurrentSong)
		self:SetNWInt("TrackNr","...")
		self:SetNWInt("CurrentSong","Nothing")
	return
end

-- Be lazy
self:SetNWInt("TrackNr",song)
self:SetNWInt("CurrentSong",self.Songtable[song])
self:StopSound("tf2_radio_song_"..self.CurrentSong)
self:StopSound("tf2_radio_song_0"..self.CurrentSong)

self.CurrentSong = song
	if song < 9 then
		self:EmitSound("tf2_radio_song_0"..song,100, nil, 1, CHAN_ITEM)
	else 
		self:EmitSound("tf2_radio_song_"..song,100, nil, 1, CHAN_ITEM)
	end
end

function ENT:OnRemove()
	-- Be lazy
	self:StopSound("tf2_radio_song_"..self.CurrentSong)
	self:StopSound("tf2_radio_song_0"..self.CurrentSong)
end

function ENT:Think()
	self:RemoveAllDecals()
end