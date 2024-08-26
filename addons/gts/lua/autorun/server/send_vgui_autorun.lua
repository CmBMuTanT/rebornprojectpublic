local files = {	"vgui/dbutton_gts.lua",	"vgui/dimagebutton_gts.lua", "vgui/dslider.lua", "vgui/dnumslider_gts.lua", "vgui/dscrollpanel_gts.lua" }
for _, p in pairs ( files ) do 
	AddCSLuaFile( p )
end

util.AddNetworkString( "GimmeThatScreen_RequestPVS" )
net.Receive( "GimmeThatScreen_RequestPVS", function( len, ply )
	local nEnt = net.ReadEntity()
	if ( IsValid( nEnt ) ) then
		ply.GTS_TargetPVS = nEnt
	else
		ply.GTS_TargetPVS = nil
	end
end )

hook.Add("SetupPlayerVisibility", "GimmeThatScreen", function( pPlayer, pViewEntity )
	if ( IsValid( pPlayer.GTS_TargetPVS ) ) then
		AddOriginToPVS( pPlayer.GTS_TargetPVS:GetPos() )
	end
end)