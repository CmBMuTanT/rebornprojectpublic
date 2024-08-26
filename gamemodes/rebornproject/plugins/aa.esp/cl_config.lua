local PLUGIN = PLUGIN

--[[
    Players
]]--
PLUGIN:AddPlayerESPCustomization("name_pl", {
    dist = 0,
    config = {
        name = "Имя персонажа",
        desc = "Включить показатель имени персонажа"
    },
    data = function(entity)
        return entity:Name()
    end
})

PLUGIN:AddPlayerESPCustomization("steamname_pl", {
    dist = 0,
    config = {
        name = "Стим Ник игрока",
        desc = "Включить показатель стим ника игрока"
    },
    data = function(entity)
        return entity:SteamName()
    end
})

PLUGIN:AddPlayerESPCustomization("rank_pl", {
    dist = 1500,
    config = {
        name = "Ранг игрока",
        desc = "Включить показатель ранга игрока"
    },
    data = function(entity)
        return entity:GetUserGroup()
    end
})

PLUGIN:AddPlayerESPCustomization("faction_pl", {
    dist = 1500,
    config = {
        name = "Фракция игрока",
        desc = "Включить показатель фракции игрока"
    },
    data = function(entity)
        return ix.faction.indices[entity:Team()].name
    end
})

PLUGIN:AddPlayerESPCustomization("hp_armor_pl", {
    dist = 1000,
    config = {
        name = "Состояние игрока",
        desc = "Включить показатель состояния игрока"
    },
    data = function(entity)
        return entity:Health() .. "/" .. entity:Armor()
    end
})

PLUGIN:AddPlayerESPCustomization("weapon_pl", {
    dist = 1000,
    config = {
        name = "Оружие игрока",
        desc = "Включить показатель информации о оружии игрока"
    },
    data = function(entity)
        local weapon = entity:GetActiveWeapon()
        if weapon and IsValid(weapon) then
            return weapon:GetPrintName() .. "[" .. weapon:GetClass() .. "] — " .. weapon:Clip1() .. "/" .. entity:GetAmmoCount(weapon:GetPrimaryAmmoType())
        end
    end
})

PLUGIN:AddPlayerESPCustomization("vector_pl", {
    dist = 500,
    config = {
        name = "Позиция игрока",
        desc = "Включить показатель позиции игрока"
    },
    data = function(entity)
        return "Vector(" .. math.Round(entity:GetPos().x, 2) .. ", " .. math.Round(entity:GetPos().y, 2) .. ", " .. math.Round(entity:GetPos().z, 2) .. ")"
    end
})

PLUGIN:AddPlayerESPCustomization("dist_pl", {
    dist = 0,
    config = {
        name = "Дистанция игрока",
        desc = "Включить показатель дистанции игрока"
    },
    data = function(entity)
        return math.Round(LocalPlayer():GetPos():Distance(entity:GetPos()), 1)
    end
})

PLUGIN:AddPlayerESPCustomization("chams_pl", {
    dist = 1000,
    config = {
        name = "Чамсы игрока",
        desc = "Включить чамсы игроков"
    },
    data = function(entity)
        local col = team.GetColor(entity:Team())

        cam.Start3D(EyePos(), EyeAngles())
            render.SuppressEngineLighting(true)
            render.MaterialOverride(PLUGIN.mat)
            render.SetColorModulation(col.r / 255, col.g / 255, col.b / 255)
            entity:DrawModel()
            render.MaterialOverride()
            render.SuppressEngineLighting(false)
        cam.End3D()
    end
})

PLUGIN:AddPlayerESPCustomization("trace_pl", {
    dist = 1000,
    config = {
        name = "Прицел игрока",
        desc = "Показывать куда смотрит игрок"
    },
    data = function(entity)
        local col = team.GetColor(entity:Team())

        local tr = {}
        tr.start = entity:EyePos()
        tr.endpos = (entity:GetAimVector() * 99999)
        tr.filter = {entity}

        local trace = util.TraceLine(tr).HitPos

        surface.SetDrawColor(col)
        if trace:ToScreen().visible and entity:EyePos():ToScreen().visible then
            surface.DrawLine(entity:EyePos():ToScreen().x, entity:EyePos():ToScreen().y, trace:ToScreen().x, trace:ToScreen().y)
        end
        surface.DrawRect(trace:ToScreen().x - 2.5, trace:ToScreen().y - 2.5, 5, 5)
    end
})

PLUGIN:AddPlayerESPCustomization("observer_pl", {
    dist = 0,
    config = {
        name = "ОбСервер статус",
        desc = "Включить показатель состояния ОбСервера игрока"
    },
    data = function(entity)
        if entity:GetMoveType() == MOVETYPE_NOCLIP then
            return "[OBSERVER]"
        end
    end
})

--[[
    Entity
]]--
PLUGIN:AddEntityESPCustomization("name_en", {
    dist = 3000,
    config = {
        name = "Название энтити",
        desc = "Включить показатель названия энтити"
    },
    data = function(entity)
        if entity:GetClass() == "ix_item" then
            local itemTable = entity:GetItemTable()
            return itemTable:GetName()
        elseif entity:GetClass() == "ix_vendor" then
            local name = entity:GetDisplayName()
            return name
        elseif entity:GetClass() == "ix_container" then
            local name = entity:GetDisplayName()
            return name
        end
    end
})

PLUGIN:AddEntityESPCustomization("class_en", {
    dist = 1000,
    config = {
        name = "Класс энтити",
        desc = "Включить показатель класса энтити"
    },
    data = function(entity)
        return entity:GetClass()
    end
})

PLUGIN:AddEntityESPCustomization("hp_en", {
    dist = 1000,
    config = {
        name = "Состояние энтити",
        desc = "Включить показатель состояния энтити"
    },
    data = function(entity)
        return entity:Health() .. "/" .. entity:GetMaxHealth()
    end
})

PLUGIN:AddEntityESPCustomization("model_en", {
    dist = 200,
    config = {
        name = "Модель энтити",
        desc = "Включить показатель модели энтити"
    },
    data = function(entity)
        return entity:GetModel()
    end
})

PLUGIN:AddEntityESPCustomization("vector_en", {
    dist = 500,
    config = {
        name = "Позиция энтити",
        desc = "Включить показатель энтити"
    },
    data = function(entity)
        return "Vector(" .. math.Round(entity:GetPos().x, 2) .. ", " .. math.Round(entity:GetPos().y, 2) .. ", " .. math.Round(entity:GetPos().z, 2) .. ")"
    end
})

PLUGIN:AddEntityESPCustomization("chams_en", {
    dist = 1000,
    config = {
        name = "Чамсы энтити",
        desc = "Включить чамсы энтити"
    },
    data = function(entity)
        local col = PLUGIN.entslist[entity:GetClass()] or Color(255, 255, 255)

        cam.Start3D(EyePos(), EyeAngles())
            render.SuppressEngineLighting(true)
            render.MaterialOverride(PLUGIN.mat)
            render.SetColorModulation(col.r / 255, col.g / 255, col.b / 255)
            entity:DrawModel()
            render.MaterialOverride()
            render.SuppressEngineLighting(false)
        cam.End3D()
    end
})