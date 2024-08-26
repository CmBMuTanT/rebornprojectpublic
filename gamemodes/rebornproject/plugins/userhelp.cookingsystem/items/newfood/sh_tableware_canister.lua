ITEM.name = "Канистра"
ITEM.exRender = true
ITEM.model = "models/cmbmtk/eft/gasoline.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(731.23, 4.32, 53.4),
	ang = Angle(3.11, 180.36, 0),
	fov = 2.19
}
ITEM.Weight = 10

-- ITEM.iconCam = {
-- 	pos = Vector(730.98, 35.76, 57.25),
-- 	ang = Angle(4.41, 182.8, 0),
-- 	fov = 0.63
-- }


ITEM.description = "Обычная канистра - предназначенная и использующаяся как вариант переноса и хранения воды. Имеется гравировка - 30Л/VLRU. Дыр, или заметных дефектов - не наблюдается."

 

ITEM.destroy_item = false
ITEM.empty_item = nil
ITEM.EQSsound = nil

ITEM.Type = nil
ITEM.quality = nil -- то же самое что и с type

ITEM.MaxIngredients = 0
ITEM.IsDishes = true

ITEM.IsWaterCan = true -- только для переносимых фляг/и прочего говна


function ITEM:OnInstanced(invID, x, y, item)
	item:SetData("BrokenData", math.random(8, 12)) -- это количество
end


ITEM.functions.Refill = {
    name = "Заполнить водой",
    icon = "icon16/feed.png",
    OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()

        if item:GetData("BrokenData") > 0 then

            item:SetData("quantity", 30)
            item:SetData("ingredients", {"Канистра с жидкостью"})

            item:SetData("saturation", {["thirst"] = 10, ["hunger"] = 0})

            item:SetData("type", "dirty")

            client:EmitSound("ambient/water/water_splash"..math.random(1, 3)..".wav")

            item:SetData("BrokenData", math.max(0, item:GetData("BrokenData") - 1))
        else
            item:Remove()
            character:GetInventory():Add("brokencanister")
        end

        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        local tr = client:GetEyeTrace()
        local distance = tr.StartPos:Distance(tr.HitPos)

        return (!IsValid(item.entity)) and (game.GetMap() == "rp_qanon_v1") and (item:GetData("quantity", 0) == 0) and ( distance <= 512 and bit.band( util.PointContents( tr.HitPos ), CONTENTS_WATER ) == CONTENTS_WATER ) -- будет один незначительный баг ибо я не понял как его исправить
    end
}


ITEM.functions.addto = {
    name = "Перелить",
    tip = "useTip",
    icon = "icon16/add.png",
    isMulti = true,
    multiOptions = function( item, client )
        local targets = {}

        for k, v in next, client:GetCharacter():GetInventory():GetItems() do
            if v.base == "base_newfood" and item:GetData("quantity", 0) ~= 0 and item:GetID() ~= v:GetID() and v:GetData("quantity") ~= 4 and v.IsWaterCan then				
                table.insert( targets, {
                    name = v.name,
                    data = {v.id, v.name},
                } )
            end
        end

        return targets
    end,
    OnCanRun = function( item)
        local client = item.player
        return !IsValid(item.entity) and IsValid(client) and item.invID == client:GetCharacter():GetInventory():GetID() and item:GetData("quantity", 0) ~= 0
    end,
	OnRun = function( item, data )
		if data and data[1] and data[2] then
			local client = item.player
			local item2 = client:GetCharacter():GetInventory():GetItemByID( data[1], true )

			if not item2 then return false end


			item2:SetData("ingredients", {"Жидкость"})


			item2:SetData("Maxquantity", item2:GetData("Maxquantity", 0) + 1)
			item2:SetData("type", item:GetData("type", "raw"))
			item2:SetData("quality", item:GetData("quality", 0))
			item2:SetData("saturation", item:GetData("saturation"))

			item2:SetData("quantity", item2:GetData("quantity", 0) + 1)
			item:SetData("quantity", item:GetData("quantity", 0) - 1)

			if item:GetData("quantity") <= 0 then
				if (item.destroy_item) then
					return true
				else
					item:SetData("type", "dirty")
					item:SetData("ingredients", nil)
					item:SetData("quality", 0)
				end
			end
		end
	
		return false
	end,
}
