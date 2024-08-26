
local PLUGIN = PLUGIN
PLUGIN.name = "Компас"
PLUGIN.author = ""
PLUGIN.description = "Компас"


ix.lang.AddTable( "russian", {
	optShowCompass = "Отображение компаса"
} )


if CLIENT then
	ix.option.Add( "showCompass", ix.type.bool, true, {
		category = "Compass"
	} )


    local elements = { "", "С", "СЗ", "З", "ЮЗ", "Ю", "ЮЗ", "З", "СЗ", "С", "СВ", "В", "ЮВ", "Ю", "ЮЗ", "З", "СЗ", "С", "З" }
    
	do


		

		local firstVal, secVal = -450, -345
		local defColor = Color(0, 191, 255)
		local specColor = Color( 220, 20, 60 )

		for i = 0, 46 do
			if ( i > 0 ) and ( i < 20 ) then
				if ( firstVal == 405 ) or ( firstVal == -405 ) then firstVal = firstVal + 45 end

				elements[ i ] = { x = firstVal, letter = elements[ i ], color = ( firstVal == 0 and specColor ) or defColor }
				firstVal = firstVal + 45
			end

			if ( secVal % 45 ) ~= 0 then
				elements[ #elements + 1 ] = { x = secVal }
			end

			secVal = secVal + 15
		end
	end



	local compass_x = 25

	function PLUGIN:HUDPaint()
		if ix.option.Get( "showCompass" ) == true then
			local offLimit = ScrW() / 5
			local offset = LocalPlayer():GetAngles().y
		    local offset_x = offset > 0 and offset - 360 or offset

			for i, el in ipairs( elements ) do
				local x = ( el.x + offset ) * 4.5

				if ( x < -offLimit ) or ( x > offLimit ) then continue end

				local alpha = ( offLimit - math.abs( x ) ) / offLimit * 255
				local draw_x = ScrW() / 2 + x

		        draw_x = math.Approach(
		            draw_x, draw_x,
		            math.Clamp(
		                math.abs( ( draw_x - draw_x ) * FrameTime() * 2 ),
		                FrameTime() * 2,
		                FrameTime() * 2
		            )
		        )

				surface.SetDrawColor( Color( 255, 255, 255, alpha ) )

				local color = el.color and ColorAlpha( el.color, alpha * 6 ) or ColorAlpha( color_white, alpha )

				draw.SimpleText( "╵╵│╵╵", "ixToolTipText", draw_x, compass_x + 24, ColorAlpha( color, color.a - 30 ), 1, 0 )

				if el.letter ~= nil then
					draw.SimpleText( el.letter, "ixToolTipText", draw_x, compass_x - 2, color, 1, 0 )
				else
					local x_ = el.x > 0 and el.x or 360 + el.x
					draw.SimpleText( x_, "ixToolTipText", draw_x, compass_x + 2, ColorAlpha( color, color.a - 30 ), 1, 0 )
				end
			end
			
			draw.SimpleText( "▽", "ixToolTipText", ScrW() / 2, compass_x - 25, Color( 255, 255, 255, 100 ), 1, 0 )
		end
	end
end
