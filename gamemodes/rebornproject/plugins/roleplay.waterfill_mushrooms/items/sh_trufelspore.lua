ITEM.name = "Семена быстрорастущего трюфеля"
ITEM.description = "Семена - что были разработаны на Пушкинской, как вариант решения разнообразия грибной пищи. Конечно, трюфель это напоминает очень отдаленно - но, вцелом съедобно"
ITEM.category = "[REBORN] FERM`S"
ITEM.model = "models/props_junk/cardboard_box004a.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.functions.Use = {
    name = "Посадить",
	icon = "icon16/add.png",
	OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()
        client:EmitSound("physics/surfaces/sand_impact_bullet"..math.random(1, 4)..".wav")

        --пока что я не буду использовать scripted_ents.Get(), так как Рубат чето наебнул и он нормально не работает на x86, но за то прекрасно работает на x64!.
        local mushrooment = ents.Create( "ix_mtk_trufel" )
        mushrooment:SetPos(client:GetEyeTrace().HitPos)
        mushrooment:Spawn()
    
        return true
    end,
    OnCanRun = function(item)
        local client = item.player
        local tr = client:GetEyeTrace()
        local trmodel = tr.Entity:GetModel()
        local distance = tr.StartPos:Distance(tr.HitPos)

		return (!IsValid(item.entity)) and (distance <= 100 and trmodel == "models/z-o-m-b-i-e/metro_ll/station_props/m_ll_mushrooms_shelving_01_3.mdl") -- модель на которой будет расти гриб
	end
}

