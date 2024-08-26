ITEM.name = "Дозиметр КМБ-3"
ITEM.description = "Универсальный электроприбор для каждого радиофила, имеет все возможные примочки. Имеет знакомую компанию ООО 'Мутьев-Стандарт'"
ITEM.category = "[REBORN] ELECTRONIC"
ITEM.width = 1
ITEM.height = 1

ITEM.exRender = true
ITEM.model = "models/cmbmtk/eft/geigercounter.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(39.63, 0.25, 733),
	ang = Angle(86.92, 180.19, 0),
	fov = 1.16
}



ITEM.inventoryType = "armband"

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("Equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:OnInstanced()
    self:SetData("Equip", false)
end

-- ITEM.functions.equip = {
-- 	name = "Включить/Выключить",
-- 	tip = "useTip",
-- 	icon = "icon16/arrow_up.png",
-- 	OnRun = function(item)
-- 		local client = item.player

        -- if !item:GetData("Equip") then
        --     item:SetData("Equip", true)
        --     client:EmitSound("buttons/button14.wav", 75, 110)
		-- 	client:Give("dosimetr")
        -- else
        --     item:SetData("Equip", false)
        --     client:EmitSound("buttons/button17.wav", 75, 110)
		-- 	client:StripWeapon("dosimetr")
        -- end
		
-- 		return false
-- 	end,
--     OnCanRun = function(item)
-- 		return !IsValid(item.entity)
-- 	end
-- }

if SERVER then
	function ITEM:Equip(client)
		self:SetData("Equip", true)
		client:EmitSound("buttons/button14.wav", 75, 110)
		client:Give("dosimetr")
	end

	function ITEM:Unequip(client)
		self:SetData("Equip", false)
		client:EmitSound("buttons/button17.wav", 75, 110)
		client:StripWeapon("dosimetr")
	end
end


ITEM.functions.measureself = {
	name = "Замерить радиацию (на себе)",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
        local character = client:GetCharacter()


        client:Notify("RAD.SELF=> "..character:GetData("RadAmount", 0))
		
		return false
	end,
    OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetData("Equip", true) and item:GetData("BatteryCondition") ~= nil and item:GetData("BatteryCondition") ~= 0
	end
}

ITEM.functions.measureplayer = {
	name = "Замерить радиацию (на ком то)",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
        local target = client:GetEyeTrace().Entity
        local targetchar = target:GetCharacter()

        client:Notify("RAD.SELF=> "..targetchar:GetData("RadAmount", 0)) -- да-да именно SELF, ведь он не будет же узнавать что это другой человек.
		
		return false
	end,
    OnCanRun = function(item)
        local client = item.player
        local tr = client:GetEyeTrace()
        local target = tr.Entity
        local distance = tr.StartPos:Distance(tr.HitPos)

		return (!IsValid(item.entity)) and item:GetData("Equip", true) and (distance <= 90 and target:IsPlayer()) and item:GetData("BatteryCondition") ~= nil and item:GetData("BatteryCondition") ~= 0
	end
}

ITEM.functions.measurezone = {
	name = "Замерить радиацию в области",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
        local position = client:GetPos() + client:OBBCenter()
		local inRadiationZone = false

        for id, info in pairs(ix.area.stored) do
            if (position:WithinAABox(info.startPosition, info.endPosition)) then
                if info.type == "RadiationZone" then
                    client:Notify("RAD.ZONE=> "..info.properties.Radiationamount)
					inRadiationZone = true
                end
            end
        end

		if not inRadiationZone then
			client:Notify("RAD.ZONE=> SAFE ZONE")
		end
		
		return false
	end,
    OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetData("Equip", true) and item:GetData("BatteryCondition") ~= nil and item:GetData("BatteryCondition") ~= 0
	end
}


ITEM:Hook("drop", function(item)
	if (item:GetData("Equip")) then

		item.player:StripWeapon("dosimetr")
		item:SetData("Equip", false)
	end
end)