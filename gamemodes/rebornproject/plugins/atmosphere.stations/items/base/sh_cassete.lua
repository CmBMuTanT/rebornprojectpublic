ITEM.name = "Audio Player Base"
ITEM.cassete = true
ITEM.width = 1
ITEM.height = 1
ITEM.exRender = true
ITEM.model = "models/devcon/mrp/props/casette.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(729.93, 12.38, 76.78),
	ang = Angle(5.86, 180.97, 0),
	fov = 0.61
}


function ITEM:GetDescription()
    return "Кассета с записью: " .. self.name .. "\nЧтобы её включить, явно потребуется проигрыватель"
end