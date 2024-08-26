ITEM.name = "Таблетки 'МЕКСАМИН'"
ITEM.description = "Обычные таблетки от радиации, довольно редкие и сильнодействующие, по инструкции надо принимать сразу все. Все та же известная компания ООО 'Мутьев-Фармстандарт'"
ITEM.category = "[REBORN] MEDICINE"
ITEM.model = "models/props_junk/garbage_metalcan001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.bDropOnDeath = true
ITEM.inventoryType = "hotkey"

ITEM.functions.use = {
	name = "Употребить",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()

   		character:SetData("RadAmount", math.max(0, character:GetData("RadAmount", 0) - 50))
		client:EmitSound("npc/barnacle/barnacle_gulp1.wav")
		client:SetNetVar("RadAmount", character:GetData("RadAmount", 0))
		
		return true
	end,
    OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}


