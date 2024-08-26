ITEM.name = "ПНВ"
ITEM.description = "Прибор ночного видения"
ITEM.category = "[NightVisions]"
ITEM.model = "models/kek1ch/dev_torch_light.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1

ITEM.inventoryType = "pnv"

ITEM.Color = "Green"

if SERVER then
    function ITEM:Equip(client)
        netstream.Start( client, "pickcolor", self.Color )
    end

    function ITEM:Unequip(client)
        net.Start("vrnvgnetflip")
        net.WriteBool(false)
        net.Send(client)
    end
end