PLUGIN.name = "Show FPS"
PLUGIN.author = "L7D, Pokernut, Frosty"
PLUGIN.description = "Show FPS."

if (CLIENT) then
	local helix_fps = {
		font = "mailart rubberstamp",
		size = 27,
		weight = 500,
		antialias = true,
	}
	
	ix.option.Add("fpsEnabled", ix.type.bool, false, {
		category = "appearance"
	})
end

ix.lang.AddTable("english", {
	optFpsEnabled = "Показать FPS",
	optdFpsEnabled = "Показать счетчик кадров в секунду в правой части экрана.",
})


function PLUGIN:HUDPaint( )
	if ( !ix.option.Get( "fpsEnabled", false ) ) then return end
	local curFPS = math.Round( 1 / FrameTime( ) )
	local minFPS = self.minFPS or 60
	local maxFPS = self.maxFPS or 100

	if ( !self.barH ) then
		self.barH = 1
	end
	
	self.barH = math.Approach( self.barH, ( curFPS / maxFPS ) * 100, 0.5 )
	
	local barH = self.barH 
	
	if ( curFPS > maxFPS ) then
		self.maxFPS = curFPS
	end
	
	if ( curFPS < minFPS ) then
		self.minFPS = curFPS
	end
	
	draw.SimpleText( curFPS .. " FPS", helix_fps, ScrW( ) - 10, ScrH( ) / 2 + 20, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, 1 )
	draw.RoundedBox( 0, ScrW( ) - 30, ( ScrH( ) / 2 ) - barH, 20, barH, Color( 255, 255, 255, 255 ) )
	draw.SimpleText( "Макс: " .. maxFPS, helix_fps, ScrW( ) - 10, ScrH( ) / 2 + 40, Color( 150, 255, 150, 255 ), TEXT_ALIGN_RIGHT, 1 )
	draw.SimpleText( "Мин: " .. minFPS, helix_fps, ScrW( ) - 10, ScrH( ) / 2 + 55, Color( 255, 150, 150, 255 ), TEXT_ALIGN_RIGHT, 1 )
end