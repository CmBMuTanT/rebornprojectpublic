if not GTS or SERVER then 
	return 
end

local self 	   = {}
local tonumber = tonumber
local type     = type

GTS.MakeGlobalConstructor ( self, GTS, "GTS:GlobalDispatch : CMD" )

function self:Constructor()
	local InternalConstruction = GTS["GTS:ObjectFactoryProvider"]:Constructor()
	self.Data 	= {}
	self.Buffer = {}
end

function self:DispatchReliableChannel( Ichannel, Signal, Packet )
	if not Ichannel or type(Ichannel) ~= "string" then
		if not Ichannel then 
			GTS:Error( "GTS:DispatchReliableChannel : IChannel is not specified." ) 
			return 
		end
		GTS:Error( "GTS:DispatchReliableChannel : IChannel expected string, but received " .. type(Ichannel) .. "." )
		return 
	elseif type(Signal) ~= "boolean" then
		GTS:Error( "GTS:DispatchReliableChannel : Signal expected boolean, but received " .. type(Signal) .. "." )
		return
	elseif type(Packet) ~= "table" or Packet == nil then
		if Packet ~= nil then
			GTS:Error( "GTS:DispatchReliableChannel : Packet expected table, but received " .. type(Packet) .. "." )
			return
		end
		GTS:Error( "GTS:DispatchReliableChannel : Packet is unexpectedly short." )
		return
	end
	local Transpose 		= GTS["GTS:ObjectFactoryProvider"].ConvertTTJ(Packet)
	local Indexor   		= GTS["GTS:ObjectFactoryProvider"].Compressor(Transpose)
	local FinalBufferResult = Indexor
	GTS["GTS:ObjectFactoryProvider"].Registering ( Ichannel )
	GTS["GTS:ObjectFactoryProvider"].Boolean ( Signal )
	GTS["GTS:ObjectFactoryProvider"].Header ( FinalBufferResult:len() )
	GTS["GTS:ObjectFactoryProvider"].Buffer ( FinalBufferResult, FinalBufferResult:len() )
	GTS["GTS:ObjectFactoryProvider"].Dispatch ()
end

function self:Destructor ()
	self.Data 	= nil
	self.Buffer = nil
end

function self:RegisterId ()
	return "GlobalDispatch: CMD"
end
self:Constructor() -- to call in the integrator
-- invoke dtor() in the last subroutine class