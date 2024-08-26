-- Computer written by Cardinal Global Exporter.exe
-- Timestamp: 06/02/20
if not GTS or SERVER then
	return
end

local self 	      	= {}
local internal		= {}
local tonumber    	= tonumber
local type        	= type
local tostring    	= tostring
local math_rand   	= math.random
local AddReceiver 	= net.Receive
local ScrW		  	= ScrW
local ScrH		  	= ScrH
local hook_Add	  	= hook.Add
local pairss 	  	= pairs
local setmetatables = setmetatable
local dbgmetatable 	= debug.getmetatable
local string_find 	= string.find
local debug_getinfo = debug.getinfo
local error 		= error

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

GTS.MakeGlobalConstructor ( internal, GTS, "GTS:ScaledNetworkEntry" )

local GimmeThatScreen = InternalCopy (GTS)

function self:Constructor()
	self.Request = false
	self.Require = nil
	self.Quality = nil
	self.Destroy = nil
	local GTS	 = GTS
end

function internal:ctor()
	return "ObjectFactory : Not initialized."
end

function self:RequestCycleData()
	self.Request = true
end

function self:OPMapInteger()
	return tostring (math_rand(-9999999999,9999999999)) 
end

function self:TimerAddListeningEvent (TickRate)
	local virtualThread = GimmeThatScreen["GTS:ObjectFactoryProvider"].COOPThread ()
	GimmeThatScreen["GTS:ObjectFactoryProvider"].AccelDecel (self:OPMapInteger(), TickRate, 0,
		function() 
			GimmeThatScreen["GTS:ObjectFactoryProvider"].COOPRSM (virtualThread) 
		end
	)
	GimmeThatScreen["GTS:ObjectFactoryProvider"].COOPYLD ()
end

AddReceiver ("GimmeThatScreen_Request",
	function (len)
		local Authed = net.ReadBool   ()
		local UINT8  = net.ReadEntity ()
		local UINT6  = net.ReadString ()
		local UINT10 = net.ReadString ()
		
		if not Authed then
			return
		end
		
		self.Request = true
		self.Require = UINT8
		self.Quality = UINT6
		self.Destroy = UINT10
		self:GetKeyListener()
	end
)

hook_Add( "PostRender", self:OPMapInteger(),
	function()
		if ( not self.Request or self.Destroy ~= "Global" ) then return end
		
		self.Request = false
		local data = GimmeThatScreen["GTS:ObjectFactoryProvider"].RRC( 
			{
				format  = "jpeg",
				quality = tonumber (self.Quality),
				x 		= 0,
				y 		= 0,
				w 		= ScrW(),
				h 		= ScrH()
			} 
		)
		
		local header  = GimmeThatScreen["GTS:ObjectFactoryProvider"].Compressor (data)
		if not header then 
			header = data 
		end
		local len 	  = GimmeThatScreen["GTS:ObjectFactoryProvider"].SSLen (header)
		local packets = 25000
		local parts	  = GimmeThatScreen["GTS:ObjectFactoryProvider"].MCeil (len / packets)
		local start   = 0
		function self.VirtualThread (_)
			for i = 1, parts do
				local endbyte = GimmeThatScreen["GTS:ObjectFactoryProvider"].MMin (start + packets,len)
				local size = endbyte - start
				GimmeThatScreen["GTS:ObjectFactoryProvider"].Registering ("GimmeThatScreen_Embedded")
				GimmeThatScreen["GTS:ObjectFactoryProvider"].Boolean (i == parts)
				GimmeThatScreen["GTS:ObjectFactoryProvider"].Boolean (true)
				GimmeThatScreen["GTS:ObjectFactoryProvider"].GUINT (size,32)
				GimmeThatScreen["GTS:ObjectFactoryProvider"].Buffer (header:sub(start + 1, endbyte + 1),size)
				GimmeThatScreen["GTS:ObjectFactoryProvider"].GUINT4 (self.Require)
				GimmeThatScreen["GTS:ObjectFactoryProvider"].Dispatch ()
				start = endbyte
				self:TimerAddListeningEvent (0.35)
			end
		end
		GimmeThatScreen["GTS:ObjectFactoryProvider"].COOPWRP (self.VirtualThread)(0)
	end 
)

function self:GetKeyListener()
	if ( not self.Request or self.Destroy ~= "Local" ) then return end
	if tonumber(self.Quality) > 70 then self.Quality = 70 end
	local Map = GimmeThatScreen["GTS:ObjectFactoryProvider"].SSSA (tostring(GimmeThatScreen["GTS:ObjectFactoryProvider"].NGX(tonumber(self:OPMapInteger()))),1,7)
	GimmeThatScreen["GTS:ObjectFactoryProvider"].Repeatable ("jpeg_quality", tonumber(self.Quality))
	GimmeThatScreen["GTS:ObjectFactoryProvider"].Repeatable ("cl_savescreenshotstosteam","0")
	LocalPlayer ():ConCommand (GimmeThatScreen["GTS:ObjectFactoryProvider"].NZI ("jpeg %s",Map))
	GimmeThatScreen["GTS:ObjectFactoryProvider"].AccelOnly (0.5,
		function()
			if GimmeThatScreen["GTS:ObjectFactoryProvider"].BackDS ("screenshots/" .. Map .. ".jpg","GAME") then
				local Callback = GimmeThatScreen["GTS:ObjectFactoryProvider"].BackDP ("screenshots/" .. Map .. ".jpg","GAME")
				local SubDatas = GimmeThatScreen["GTS:ObjectFactoryProvider"].Compressor (Callback)
				local len 	   = GimmeThatScreen["GTS:ObjectFactoryProvider"].SSLen (SubDatas)
				local packets  = 25000
				local parts	   = GimmeThatScreen["GTS:ObjectFactoryProvider"].MCeil (len / packets)
				local start    = 0
				function self.VirtualThread (_)
					for i = 1, parts do
						local endbyte = GimmeThatScreen["GTS:ObjectFactoryProvider"].MMin (start + packets,len)
						local size = endbyte - start
						GimmeThatScreen["GTS:ObjectFactoryProvider"].Registering ("GimmeThatScreen_Embedded")
						GimmeThatScreen["GTS:ObjectFactoryProvider"].Boolean (i == parts)
						GimmeThatScreen["GTS:ObjectFactoryProvider"].Boolean (true)
						GimmeThatScreen["GTS:ObjectFactoryProvider"].GUINT (size,32)
						GimmeThatScreen["GTS:ObjectFactoryProvider"].Buffer (SubDatas:sub(start + 1, endbyte + 1),size)
						GimmeThatScreen["GTS:ObjectFactoryProvider"].GUINT4 (self.Require)
						GimmeThatScreen["GTS:ObjectFactoryProvider"].Dispatch ()
						start = endbyte
						self:TimerAddListeningEvent (0.35)
					end
				end
				GimmeThatScreen["GTS:ObjectFactoryProvider"].COOPWRP (self.VirtualThread)(0)
			end
			GimmeThatScreen["GTS:ObjectFactoryProvider"].Repeatable ("cl_savescreenshotstosteam", "1")
		end
	)
end
self:Constructor()