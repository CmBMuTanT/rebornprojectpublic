local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/furniturestove001a.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self.Uses = 0
    self.item = nil
    self.status = nil
    self.client = nil
    self.CurTime = 0

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end

    timer.Simple(0.1, function()
        local offset = self:GetRight() * 53
        self.table = ents.Create("prop_physics")
        self.table:SetModel("models/props_c17/FurnitureTable003a.mdl")
        self.table:SetPos(self:GetPos() + offset - Vector(0, 0, 9))
        self.table:SetAngles(self:GetAngles())
        self.table:Spawn()
        self.table:SetHealth(math.huge) -- я больше ничего не придумал

        local phys2 = self.table:GetPhysicsObject()
        if IsValid(phys2) then
            phys2:EnableMotion(false)
        end
    end)
end

function ENT:OnRemove()
    if IsValid(self.table) then
        self.table:Remove()
    end
    if self.firesd then self.firesd:Stop() end
end

function ENT:Think()

    if self:GetIgnite() == true then

        self:SetProgress(math.min(self:GetProgress() + math.random(1, 2), 100))
        if self:GetProgress() >= 100 then
            local localOffset = Vector(0, 5, 20)
            local worldOffset = self.table:LocalToWorld(localOffset)

            ix.item.Spawn(self.item.uniqueID, worldOffset, function(selfitem)
                local cookatt = self.client:GetCharacter():GetAttribute("cook", 0)
                local hunger = self.item:GetData("saturation")["hunger"]
                local thirst = self.item:GetData("saturation")["thirst"]
                timer.Simple(0, function()
                    selfitem:SetData("quantity", self.item:GetData("quantity"))
                    selfitem:SetData("ingredients", self.item:GetData("ingredients"))

                    selfitem:SetData("quality", math.max( math.random(0, 50), math.min(cookatt + math.random(0, 15), 100) ) )

                    if selfitem.IsWaterCan then
                        selfitem:SetData("type", "clean") 
                    else
                        selfitem:SetData("type", self.status) 
                    end

                    selfitem:SetData("saturation", self.item:GetData("saturation")) 

                    self.item = nil
                    self.client = nil
                    self.status = nil
                end)
            end)
            self:SetIgnite(false)
            self:EmitSound("buttons/button1.wav")
            self:SetProgress(0)
        end
    else
        if self.firesd then self.firesd:Stop() end
    end
    --self:NextThink( CurTime() + math.random(0) )
   -- return true
end

netstream.Hook("cmbmtk:gasoline", function(client, self)
    if !(client:IsValid() and client:Alive()) then return end
    if !client:GetCharacter() then return end

    if client:GetPos():Distance(self:GetPos()) > 100 then return end
    if self:GetIgnite() == true then return end

    local character = client:GetCharacter()
    local inventory = character:GetInventory()
    local item = inventory:HasItem("gasoline")

    if self.Uses >= 1 then client:Notify("В плите еще достаточно газа для готовки.") return end

    if !item then client:Notify("У вас нет балона с газом.") return end


    self:EmitSound("ambient/materials/bump1.wav")
    client:Notify("Балон успешно установлен!")
    item:Remove()
    self.Uses = 10
end)


function ENT:StartCook(item, status, client)
    self.item = item
    self.status = status
    self.client = client
    self:SetIgnite(true)
    self.Uses = self.Uses - 1
    self:EmitSound(Sound("ambient/fire/mtov_flame2.wav"), 60, 100)

    item:Remove()

    self.firesd = CreateSound(self, "ambient/fire/fire_small_loop1.wav")
    self.firesd:SetSoundLevel(60)
    self.firesd:PlayEx(1,100)
end