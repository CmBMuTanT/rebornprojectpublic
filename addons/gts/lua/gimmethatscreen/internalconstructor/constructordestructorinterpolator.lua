if not GTS then
	return
end

local self  = {}
local error = error
local type  = type 

function GTS.MakeGlobalConstructor ( SignalAccelerator , SignalFilter, ISaveMap )
    SignalFilter [ISaveMap] = SignalAccelerator
end

function GTS:Error( Data )
	if not Data then return end
	if type (Data) ~= "string" then return end
	error (Data)
end