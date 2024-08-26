function PLUGIN:SaveData()
    local data = {}

    for _, entity in ipairs(ents.FindByClass("box")) do

        data[#data + 1] = {
            pos = entity:GetPos(),
            angles = entity:GetAngles(),
            --model = entity:GetModel(),
        }
    end

    ix.data.Set("lootboxez", data)
end

function PLUGIN:LoadData()
    local lootboxez = ix.data.Get("lootboxez")

    if lootboxez then
        for _, v in ipairs(lootboxez) do
            local entity = ents.Create("box")
            entity:SetPos(v.pos)
            entity:SetAngles(v.angles)
            entity:Spawn()

            entity:SetSolid(SOLID_BBOX)
            entity:PhysicsInit(SOLID_BBOX)
            entity:DropToFloor()

            local physobj = entity:GetPhysicsObject()

            if (IsValid(physobj)) then
                physobj:EnableMotion(false)
                physobj:Sleep()
            end
        end
    end

    PLUGIN:SaveData()
end
