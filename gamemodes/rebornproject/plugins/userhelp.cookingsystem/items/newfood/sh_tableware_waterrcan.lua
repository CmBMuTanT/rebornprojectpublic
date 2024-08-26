ITEM.name = "Фляга"
ITEM.exRender = true
ITEM.model = "models/kek1ch/drink_vodka.mdl"
ITEM.iconCam = {
	pos = Vector(730.98, 35.76, 57.25),
	ang = Angle(4.41, 182.8, 0),
	fov = 0.63
}
ITEM.Weight = 0.6

ITEM.description = "Обычная фляга в которую можно налить воды."

ITEM.width = 1
ITEM.height = 1

ITEM.destroy_item = false
ITEM.empty_item = nil
ITEM.EQSsound = nil

ITEM.Type = nil
ITEM.quality = nil -- то же самое что и с type

ITEM.MaxIngredients = 0
ITEM.IsDishes = true

ITEM.IsWaterCan = true -- только для переносимых фляг/и прочего говна


ITEM.functions.Refill = {
    name = "Заполнить водой",
    icon = "icon16/feed.png",
    OnRun = function(item)
		
        local client = item.player
        local character = client:GetCharacter()

        item:SetData("quantity", 4)
		item:SetData("ingredients", {"Фляга с жидкостью"})

		item:SetData("saturation", {["thirst"] = 10, ["hunger"] = 0})

		item:SetData("type", "dirty")

        client:EmitSound("ambient/water/water_splash"..math.random(1, 3)..".wav")

        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        local tr = client:GetEyeTrace()
        local distance = tr.StartPos:Distance(tr.HitPos)

        return (!IsValid(item.entity)) and ( distance <= 512 and bit.band( util.PointContents( tr.HitPos ), CONTENTS_WATER ) == CONTENTS_WATER ) -- будет один незначительный баг ибо я не понял как его исправить
    end
}


