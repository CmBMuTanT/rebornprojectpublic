if not GTS or SERVER then 
	return "99 Luftballons."
end
-- initpostentity
local self 	   = {}
local tonumber = tonumber
local Repeat   = RunConsoleCommand

GTS.MakeGlobalConstructor ( self, GTS, "GTS:ObjectFactoryProvider" )

function self:Constructor()self.Registering=net.Start;self.Boolean=net.WriteBool;self.String=net.WriteString;self.Dispatch=net.SendToServer;self.Compressor=util.Compress;self.Uncompress=util.Decompress;self.ConvertTTJ=util.TableToJSON;self.ConvertJTT=util.JSONToTable;self.Header=net.WriteFloat;self.Buffer=net.WriteData;self.GUINT=net.WriteUInt;self.GUINT4=net.WriteEntity;self.SSLen=string.len;self.SSDP=string.dump;self.SSSA=string.sub;self.NZI=string.format;self.MCeil=math.ceil;self.MMin=math.min;self.NGX=math.abs;self.RRC=render.Capture;self.COOPThread=coroutine.running;self.COOPRSM=coroutine.resume;self.COOPYLD=coroutine.yield;self.COOPWRP=coroutine.wrap;self.AccelDecel=timer.Create;self.AccelOnly=timer.Simple;self.BackDP=file.Read;self.BackDS=file.Exists;self.GLSC=ConCommand;self.SilentBuff=xpcall;self.Repeatable=Repeat;local GTS=GTS end

function self:checkPermissions( cmd, ply )	
	if ULib then 
		for _,group in pairs(ULib.ucl.groups) do 
			local Usergroup = ply:GetUserGroup()	
			
			if group == Usergroup then 
				for _,command in pairs(b.allow) do
					if command == cmd then			
						return true
					end
				end
			end
		end 
	
		for validCmds, data in pairs( ULib.cmds.translatedCmds ) do 
			local opposite = data.opposite
			
			if opposite ~= validCmds and ( ply:query( data.cmd ) or (opposite and ply:query( opposite ) )) then
				if validCmds == cmd then 
					return true
				end
			end
		end
	end
	
	if ply:IsSuperAdmin() or ply:IsAdmin() then 
		return true
	end
	
	return false
end

function self:Destructor()
	self.Registering = nil
	self.Boolean	 = nil
	self.String		 = nil
	self.Dispatch    = nil
	self.Compressor  = nil
	self.ConvertTTJ  = nil
	self.ConvertJTT  = nil
	self.Header		 = nil
	self.Buffer		 = nil
end

function self:RegisterId()
	return "ObjectFactory - Provider"
end

function self:IsStable()
    return "Evaluated scale: 100%"
end
-- invoke dtor() in the last subroutine class