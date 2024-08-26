-- Computer written by Cardinal Global Exporter.exe
-- Timestamp: 05/30/20
local CATEGORY = "GimmeThatScreen"

local function gimmethatscreen( calling_ply )
	if not calling_ply:IsValid() then
		Msg ( "gts menu cannot be opened from the server." )
		return
	elseif calling_ply:IsAdmin() or calling_ply:IsSuperAdmin() then
		calling_ply:ConCommand( "gts" )
	else
		MsgC( Color(255,0,0), calling_ply:GetName() .. " is attempting to open GimmeThatScreen GUI without administrator privileges." )
	end
end

local gtsUlxCompatibilities = ulx.command( CATEGORY, "ulx gts", gimmethatscreen, "!gts", true )
gtsUlxCompatibilities:defaultAccess( ULib.ACCESS_ADMIN )
gtsUlxCompatibilities:help( "Open GimmeThatScreen panel." )