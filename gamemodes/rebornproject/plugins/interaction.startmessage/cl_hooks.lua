local PLUGIN = PLUGIN

netstream.Hook("ixStartMessage", function()
    if ix.option.Get("showStartMessage", true) then
        local panel = vgui.Create("ixStartMessage")
    end
end)
		
function PLUGIN:LoadFonts(font, genericFont)
    font = genericFont
	surface.CreateFont("ixGuideItalicFont", {
		font = font,
		size = math.max(ScreenScale(8), 21),
		extended = true,
        italic = true,
		weight = 500
	})

	surface.CreateFont("ixGuideSmallFont", {
		font = font,
		size = math.max(ScreenScale(8), 21),
		extended = true,
		weight = 500
	})

	surface.CreateFont("ixGuideTinyFont", {
		font = font,
		size = math.max(ScreenScale(6), 19),
		extended = true,
		weight = 500
	})
end