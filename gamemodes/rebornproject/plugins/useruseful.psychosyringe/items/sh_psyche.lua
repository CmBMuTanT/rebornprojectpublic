ITEM.name = "Шприц 'ФОЛОТИН'"
ITEM.description = "На этом шприце есть какая то маркировка с надписью 'ФОЛОТИН'-STD и этикеткой 'МУТЬЕВ-ФАРМ', сама по себе жидкость имеет кроваво-красный оттенок, интересно что будет если я его вколю?"
ITEM.exRender = true 
ITEM.model = "models/cmbmtk/eft/medsyringe.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.9, 156, 717.3),
	ang = Angle(77.73, 270.33, 0),
	fov = 0.45
}

ITEM.category = "[REBORN] MEDICINE"

ITEM.functions.inject = {
	name = "Вколоть",
	icon = "icon16/arrow_right.png",
	OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()

        if character:GetData("PSYCHOSYN", 0) > 3 then
            character:UpdateAttrib("maxhp", -5) -- это навсегда, а бусты временные (настрой на макс-хп и сколько отнимать аттрибута будет если он дохуя вколит сразу)

			-- если не надо, можешь закоментить то что ниже, это "передоз" и его детали, как ты сказал детали это круто, вот и держи.
			if client:Health() <= 0 then client:Kill() end

			client:SetHealth(math.Clamp(client:Health() - 10, 0, client:GetMaxHealth()) )
			client:EmitSound("npc/barnacle/barnacle_die1.wav")
			client:ScreenFade( SCREENFADE.IN, Color( 255, 0, 0, 150 ), 1, 0 )
			util.Decal("Blood", client:GetPos(), client:GetPos() - Vector(0, 0, 64), client )
        end

		character:AddBoost("buff1", "str", 100) --настрой какие бусты тебе нужны, и какое колво бустов выдает
		character:AddBoost("buff2", "stm", 100)
		character:AddBoost("buff2", "end", 100)


        character:SetData("PSYCHOSYN", character:GetData("PSYCHOSYN", 0) + 1)

		hook.Run("SetupPSYCHOtimer", client, character, item.uniqueID, 160) -- сюда установи таймер сколько действовать це ебала будет

		return true
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}