ITEM.name = "Цианид"
ITEM.description = "Таблетка для самоубийства (также известная как таблетка цианида, таблетка для убийства, смертельная таблетка, таблетка смерти или L-таблетка) - это таблетка, капсула, ампула или таблетка, содержащие смертельно ядовитое вещество, которое человек проглатывает намеренно, чтобы быстро достичь смерти в результате самоубийства. Военные и шпионские организации снабжали своих агентов, которым грозила опасность быть захваченными врагом, таблетками для самоубийства и устройствами, которые можно было использовать, чтобы избежать неминуемой и гораздо более неприятной смерти (например, от пыток) или гарантировать, что их нельзя допросить и заставить раскрыть секретную информацию. В результате смертельные таблетки имеют важное психологическое значение для лиц, выполняющих миссии с высоким риском захвата и допроса."
ITEM.category = "[REBORN] MEDICINE"
ITEM.model = "models/props_junk/garbage_plasticbottle001a.mdl" -- ватермелон)
ITEM.weight = 0.5
ITEM.bDropOnDeath = true
ITEM.width = 1
ITEM.height = 1

ITEM.functions.Use = {
    name = "Выпить",
	icon = "icon16/heart_delete.png",
	OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()

        if (!client:Alive()) then return false end

		client:EmitSound("items/medshot4.wav", 40)

        client:Kill()
        timer.Simple(3, function()
        character:Ban(0)
        end)
        

        return true
    end,
    OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
