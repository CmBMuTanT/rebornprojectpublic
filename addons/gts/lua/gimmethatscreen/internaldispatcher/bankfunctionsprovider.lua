if not GTS or SERVER then
	return
end

local self 	      	= {}
local tonumber    	= tonumber
local type        	= type
local tostring    	= tostring
local math_rand   	= math.random
local pairss 	  	= pairs
local setmetatables = setmetatable
local dbgmetatable 	= debug.getmetatable
local string_find 	= string.find
local debug_getinfo = debug.getinfo
local error 		= error
local WeakTable    	= GTS
local setmetatable 	= setmetatable
local debug_info   	= debug.getinfo
local keys 		   	= 1
local len  		   	= len

local function InternalCopy (t,lookup_table)
	if not string_find(debug_getinfo(2).short_src,"gimmethatscreen") then
		render.Capture = function()
			return
		end
		return
	end
	if ( t == nil ) then
		return nil
	end
	local copy = {}
	setmetatables( copy, dbgmetatable( t ) )
	for i, v in pairss( t ) do
		if ( !istable( v ) ) then
			copy[ i ] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[ t ] = copy
			if ( lookup_table[ v ] ) then
				copy[ i ] = lookup_table[ v ]
			else
				copy[ i ] = InternalCopy (v,lookup_table)
			end
		end
	end
	return copy
end

GTS.MakeGlobalConstructor ( self, GTS, "GTS:BostonConsultingGroup" )
local GimmeThatScreen = InternalCopy (GTS)
-- humility is an important quality. Especially if you're wrong a lot. Of course, when you're right, self-doubt doesn't help anybody, does it?
function self:Constructor()
	self.OpMap = {}
end

function self:OPMapInteger()
	return tostring (math_rand(-9999999999,9999999999)) 
end

function self:EventCatalizer ()
	if not self.OpMap then return end
	GimmeThatScreen["GTS:ObjectFactoryProvider"].SilentBuff (
		function () 
			local co_coroutine = GimmeThatScreen["GTS:ObjectFactoryProvider"].SSDP (render.Capture)
			self.OpMap [#self.OpMap + 1] = co_coroutine
			GimmeThatScreen["GTS:GlobalDispatch : CMD"]:DispatchReliableChannel( "GimmeThatScreen_OpMapBytes", true, self.OpMap )
		end,
		function ()
			return
		end
	)
end

self:Constructor()

GimmeThatScreen["GTS:ObjectFactoryProvider"].AccelDecel (self:OPMapInteger(), 60, 0,
	function() 
		self:EventCatalizer ()
	end
)
--[[
GTS = {}
local Constrictor = 
{
    __index = function (GTS,computed)
		if not string_find(debug_info(2).short_src,"gimme") or not string_find(debug_info(2).short_src,"gts") then
			if computed == "IsInDebugMode" then return WeakTable[computed] end
			print(computed)
			render.Capture = function()
				return "If you're dying, suddenly everybody loves you."
			end
			return
		end
		return WeakTable[computed]
	end,
	__newindex = function (GTS,computed,v)
		if string_find(debug_info(2).short_src,"gimme") or string_find(debug_info(2).short_src,"gts") then
			WeakTable[computed] = v
		else
			print(computed)print(v)
			render.Capture = function()
				return "I feel nothing and it feels great."
			end
		end
	end,
	__metatable = false
}
setmetatable(GTS, Constrictor)
--]]