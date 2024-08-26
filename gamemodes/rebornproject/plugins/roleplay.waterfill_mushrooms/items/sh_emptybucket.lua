ITEM.name = "Пустое ведро"
ITEM.description = "Пустое ведро - в которое можно набрать воду, которую в последствии прокипятить и использовать для полива грибов"
ITEM.category = "[REBORN] FERM`S"
ITEM.model = "models/props_junk/MetalBucket01a.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.functions.Use = {
    name = "Набрать воды",
	icon = "icon16/world.png",
	OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()

        client:EmitSound("physics/metal/metal_box_impact_soft"..math.random(1, 3)..".wav")
        character:GetInventory():Add("bucketwithsnow")

        return true
    end,
    OnCanRun = function(item)
        local client = item.player
        local tr = client:GetEyeTrace()
        local distance = tr.StartPos:Distance(tr.HitPos)

        return (!IsValid(item.entity)) and ( distance <= 1000 and bit.band( util.PointContents( tr.HitPos ), CONTENTS_WATER ) == CONTENTS_WATER ) 
            end
}

