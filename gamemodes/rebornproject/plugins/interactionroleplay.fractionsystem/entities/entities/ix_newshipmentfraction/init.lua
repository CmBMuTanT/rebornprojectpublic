local PLUGIN = PLUGIN

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
    self:SetModel("models/Items/item_item_crate.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:PrecacheGibs()

    local physObj = self:GetPhysicsObject()

    if (IsValid(physObj)) then
        physObj:EnableMotion(true)
        physObj:SetMass(50)
        physObj:Wake()
    end

    self:SetDeliveryTime(CurTime() + ix.config.Get("ShipTimeout"))

    timer.Simple(ix.config.Get("ShipTimeout"), function()
        if (IsValid(self)) then
            --self:Remove()
            self:SetNetVar("Public", true)
        end
    end)
end

function ENT:Use(activator)

    activator:PerformInteraction(ix.config.Get("itemPickupTime", 0.5), self, function(client)
        local index = client:GetCharacter():GetFaction()
        --local faction = ix.faction.indices[index]

        if (client:GetCharacter() and (client:GetCharacter():GetID() == self:GetNetVar("owner", 0) or index == self:GetNetVar("faction", nil) or self:GetNetVar("Public", false)) and hook.Run("CanPlayerOpenShipment", client, self) != false) then
            client.ixShipment = self

            net.Start("ixShipmentOpen")
                net.WriteEntity(self)
                net.WriteTable(self.items)
            net.Send(client)
        end

        -- don't mark dirty since the player could come back and use this shipment again later
        return false
    end)
end

function ENT:SetItems(items)
    self.items = items
end

function ENT:GetItemCount()
    local count = 0

    for _, v in pairs(self.items) do
        count = count + math.max(v, 0)
    end

    return count
end

function ENT:OnRemove()
    self:EmitSound("physics/cardboard/cardboard_box_break"..math.random(1, 3)..".wav")

    local position = self:LocalToWorld(self:OBBCenter())

    local effect = EffectData()
        effect:SetStart(position)
        effect:SetOrigin(position)
        effect:SetScale(3)
    util.Effect("GlassImpact", effect)
end

function ENT:UpdateTransmitState()
    return TRANSMIT_PVS
end