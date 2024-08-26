ITEM.name = "Ведро с водой"
ITEM.description = "Там есть вода."
ITEM.category = "[REBORN] FERM`S"
ITEM.model = "models/props_junk/MetalBucket01a.mdl"

ITEM.width = 1
ITEM.height = 1


ITEM.functions.Use = {
    name = "Полить",
    icon = "icon16/feed.png",
    OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()

        client:EmitSound("ambient/water/water_splash"..math.random(1, 3)..".wav")
        character:GetInventory():Add("emptybucket")
        client:GetEyeTrace().Entity:SetWatered(true)

        return true
    end,
    OnCanRun = function(item)
        local client = item.player
        local tr = client:GetEyeTrace()
        local trclass = tr.Entity:GetClass()
        local distance = tr.StartPos:Distance(tr.HitPos)
       -- print(trclass)
        return (!IsValid(item.entity)) and (distance <= 100 and trclass == "ix_mtk_mushshroom") or (distance <= 100 and trclass == "ix_mtk_potato") or (distance <= 100 and trclass == "ix_mtk_trufel") or (distance <= 100 and trclass == "ix_mtk_mohovik")
    end
}

