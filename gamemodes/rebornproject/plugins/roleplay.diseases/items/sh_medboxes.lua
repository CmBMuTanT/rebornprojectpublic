local ITEM = ix.item.Register("paracetamol_box", nil, false, nil, true)
ITEM.name = "Пачка Парацетамола"
ITEM.category = "[REBORN] MEDICINE"
ITEM.exRender = true
ITEM.model = "models/cmbmtk/meds/paracetamol.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.08, 21.35, 733.76),
	ang = Angle(91.67, 89.8, 0),
	fov = 1.13
}

ITEM.description = "Пачка содержащая блистер с таблетками"
ITEM.width = 2
ITEM.height = 1
ITEM.functions.Unbox = {
    name = "Распаковать",
    icon = "icon16/box.png",
    sound = "physics/cardboard/cardboard_box_break3.wav",
    OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()
        local inventory = character:GetInventory()

        inventory:Add("paracetamol")
        inventory:Add("paracetamol")

        return true
    end
}
---------------------------------
local ITEM = ix.item.Register("novox_box", nil, false, nil, true)
ITEM.name = "Пачка Новокса"
ITEM.category = "[REBORN] MEDICINE"
ITEM.exRender = true
ITEM.model = "models/cmbmtk/meds/novox.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 21.46, 733.76),
	ang = Angle(91.68, 90, 0),
	fov = 0.85
}

ITEM.description = "Пачка содержащая блистер с таблетками"
ITEM.width = 2
ITEM.height = 1
ITEM.functions.Unbox = {
    name = "Распаковать",
    icon = "icon16/box.png",
    sound = "physics/cardboard/cardboard_box_break3.wav",
    OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()
        local inventory = character:GetInventory()

        inventory:Add("novox")

        return true
    end
}
---------------------------------
local ITEM = ix.item.Register("aztreonam_box", nil, false, nil, true)
ITEM.name = "Пачка Азтреонама"
ITEM.category = "[REBORN] MEDICINE"
ITEM.exRender = true
ITEM.model = "models/cmbmtk/meds/aztreonam.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 21.46, 733.76),
	ang = Angle(91.68, 90, 0),
	fov = 0.8
}

ITEM.description = "Пачка содержащая блистер с таблетками"
ITEM.width = 2
ITEM.height = 1
ITEM.functions.Unbox = {
    name = "Распаковать",
    icon = "icon16/box.png",
    sound = "physics/cardboard/cardboard_box_break3.wav",
    OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()
        local inventory = character:GetInventory()

        inventory:Add("aztreonam")

        return true
    end
}
---------------------------------