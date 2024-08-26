ITEM.name = "Паспорт"
ITEM.description = "Обычная бумажка которая подтверждает мою личность."
ITEM.category = "[REBORN] ALL PAPER`S"
ITEM.exRender = true
ITEM.model = "models/kek1ch/notes_writing_book_2.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 3.6
}

function ITEM:GetDescription()
	return self.description
end


ITEM.functions.see = {
	name = "Посмотреть данные",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		netstream.Start(client, "cmbmtk.ShowMePassport", item:GetData("PassportInfo", {}), client, item:GetData("PassportStamps", {}))

		return false
	end,
}

ITEM.functions.show = {
	name = "Показать данные",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local target = client:GetEyeTrace().Entity

		if target:IsPlayer() then
			netstream.Start(target, "cmbmtk.ShowMePassport", item:GetData("PassportInfo", {}), client, item:GetData("PassportStamps", {}))
			target:SetNetVar("PassportRequest", item:GetData("PassportInfo", {}))
			target:SetNetVar("PassportRequest2", item:GetData("PassportStamps", {}))
		end

		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		local tr = client:GetEyeTrace()
        local distance = tr.StartPos:Distance(tr.HitPos)

		return !IsValid(item.entity) and client:GetEyeTrace().Entity:IsPlayer() and distance <= 50
	end
}


ITEM.functions.tell = {
	name = "Сказать данные (всем)",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player

		for k,v in pairs(ents.FindInSphere(client:GetPos(), 280)) do
			if v:IsPlayer() then
				local text = "Данные "..client:Name()..": "
				local info = item:GetData("PassportInfo", {})

				v:ChatPrint("Данные "..client:Name()..": ")
				for kk,vv in next, info do
					if kk == "Печать" then continue end
					v:ChatPrint(kk..": "..vv)
				end

			end
		end
		return false
	end,
}

ITEM.functions.drop = {
    OnRun = function(item)
        return false;
    end,
    OnCanRun = function(item)
        return false;
    end
}
