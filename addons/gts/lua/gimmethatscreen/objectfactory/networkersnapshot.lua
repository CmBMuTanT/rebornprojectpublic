if not GTS or SERVER then
	return
end

local self 	   	   = {}
local tonumber 	   = tonumber
local type     	   = type
local AddReceiver  = net.Receive
local WeakTable    = GTS
local setmetatable = setmetatable
local string_find  = string.find
local debug_info   = debug.getinfo
local tostring	   = tostring
local type		   = type
local keys 		   = 1
local len  		   = len

GTS.MakeGlobalConstructor ( self, GTS, "GTS:NetworkerSnapShot" )

local GTS 	 = GTS
local UINT16 = ""

AddReceiver ("GimmeThatScreen_Mirrored", 
	function (len)
	
		local cutchannels 	  = net.ReadBool ()
		local passedstack 	  = net.ReadBool ()
		local reliablelength  = net.ReadUInt (32)
		local reliablechannel = net.ReadData (reliablelength)	

		if not passedstack then
			return "self: Malformed Packet."
		end
		
		UINT16 = UINT16 .. reliablechannel
		
		if ( not cutchannels ) then 
			return 
		end
		MsgC(Color(255,0,0), "[", Color(0,255,255), "GimmeThatScreen", Color(255,0,0),"]: ", Color(0,255,0), "Received packets. Current UINT16 size: " .. UINT16:len() .. "\n" )
		local decompress = GTS["GTS:ObjectFactoryProvider"].Uncompress (UINT16)
		if not decompress then 
			MsgC(Color(255,0,0), "[", Color(0,255,255), "GimmeThatScreen", Color(255,0,0),"]: ", Color(0,255,255), "Failure, received data but cannot decompress it.")
			surface.PlaySound( "buttons/button16.wav" )
			UINT16 = ""
			return 
		end
		GTS.Interface.ShowScreen(util.Base64Encode(decompress))
		UINT16 = ""
	end
)