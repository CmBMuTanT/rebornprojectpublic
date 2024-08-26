ITEM.name = "Российский военный паёк «M.R.E. | МО.РФ»"
ITEM.description = "Набор продуктов, ранее предназначенный для питания военнослужащих, а также гражданских лиц в условиях отсутствия возможности готовить горячую пищу.. Сейчас-же - это фактический деликатес! В нём есть всё, и для завтрака - и для ужина.. И даже для полдника! М-м-м... Вкуснотень!"
ITEM.category = "[REBORN] Довоенная еда"
ITEM.exRender = true
ITEM.model = "models/rusrationopen.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-0.14, 17.21, 199.25),
	ang = Angle(87.23, -90.56, 0),
	fov = 8.64
}
ITEM.price = 10
ITEM.bDropOnDeath = true

ITEM.functions.Use = {
	name = "Распаковать",
	icon = "icon16/basket_remove.png",
	OnRun = function(item)
	local client = item.player
		item.player:GetCharacter():GetInventory():Add("canfood_proteinbaton")
		item.player:GetCharacter():GetInventory():Add("canfood_milkisconserve")	
		item.player:GetCharacter():GetInventory():Add("canfood_conserve2")	
		item.player:GetCharacter():GetInventory():Add("canfood_conserve2")	
		item.player:GetCharacter():GetInventory():Add("water_sok")	
		item.player:EmitSound("eftsounds/item_bandage_01_open.wav")
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		return true
	end
}
 