MsgN("blobsParty initializing")

if SERVER then
	AddCSLuaFile("cl_blobsparty.lua")
	AddCSLuaFile("sh_blobsparty.lua")
	include("sh_blobsparty.lua")
	include("sv_blobsparty.lua")
else
	include("sh_blobsparty.lua")
	include("cl_blobsparty.lua")
end
