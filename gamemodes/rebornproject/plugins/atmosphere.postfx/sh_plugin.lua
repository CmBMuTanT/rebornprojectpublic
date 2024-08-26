local PLUGIN = PLUGIN
PLUGIN.name = "POSTFX"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[

———————————No cmbmutant.xyz?———————————
⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
—————————————————————————————————————
]]

ix.config.Add("Enabled", false, "Включить/Выключить постобработку", nil, {
	category = "POSTFX"
})

ix.config.Add("pfx_colour_addr", 0, "Добавочный цвет: Красный", nil, {
	data = {min = 0, max = 1, decimals = 2},
	category = "POSTFX"
})
ix.config.Add("pfx_colour_addg", 0, "Добавочный цвет: Зеленый", nil, {
	data = {min = 0, max = 1, decimals = 2},
	category = "POSTFX"
})
ix.config.Add("pfx_colour_addb", 0, "Добавочный цвет: Синий", nil, {
	data = {min = 0, max = 1, decimals = 2},
	category = "POSTFX"
})
ix.config.Add("pfx_colour_brightness", 0, "Яркость", nil, {
	data = {min = -2, max = 2, decimals = 2},
	category = "POSTFX"
})
ix.config.Add("pfx_colour_contrast", 1, "Контрастность", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "POSTFX"
})
ix.config.Add("pfx_colour_colour", 1, "Множитель цвета", nil, {
	data = {min = 0, max = 5, decimals = 2},
	category = "POSTFX"
})
ix.config.Add("pfx_colour_mulr", 0, "Цвет множителя: Красный", nil, {
	data = {min = 0, max = 255, decimals = 1},
	category = "POSTFX"
})
ix.config.Add("pfx_colour_mulg", 0, "Цвет множителя: Зеленый", nil, {
	data = {min = 0, max = 255, decimals = 1},
	category = "POSTFX"
})
ix.config.Add("pfx_colour_mulb", 0, "Цвет множителя: Синий", nil, {
	data = {min = 0, max = 255, decimals = 1},
	category = "POSTFX"
})

hook.Add( "RenderScreenspaceEffects", "color_modify_example", function()
	local enabled = ix.config.Get("Enabled")

	if enabled then
		local shader = {
			[ "$pp_colour_addr" ] = ix.config.Get("pfx_colour_addr", 0),
			[ "$pp_colour_addg" ] = ix.config.Get("pfx_colour_addg", 0),
			[ "$pp_colour_addb" ] = ix.config.Get("pfx_colour_addb", 0),
			[ "$pp_colour_brightness" ] = ix.config.Get("pfx_colour_brightness", 0),
			[ "$pp_colour_contrast" ] = ix.config.Get("pfx_colour_contrast", 1),
			[ "$pp_colour_colour" ] = ix.config.Get("pfx_colour_colour", 1),
			[ "$pp_colour_mulr" ] = ix.config.Get("pfx_colour_mulr", 0),
			[ "$pp_colour_mulg" ] = ix.config.Get("pfx_colour_mulg", 0),
			[ "$pp_colour_mulb" ] = ix.config.Get("pfx_colour_mulb", 0),
		}
		DrawColorModify( shader )
	end

end )