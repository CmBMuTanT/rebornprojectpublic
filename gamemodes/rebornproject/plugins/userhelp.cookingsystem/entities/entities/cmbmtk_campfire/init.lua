local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/galaxy/rust/campfire.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end

    self.CurTime = 0
    self.ShouldRemoved = false
    self.item = nil
    self.status = nil
    self.client = nil
end

function ENT:DoFirstUpgrade()
    local xOffset = 30
    local angle = self:GetAngles()
    angle:RotateAroundAxis(angle:Up(), 90)
    
    local offset = angle:Forward() * xOffset
    local posLeft = self:GetPos() - offset
    local posRight = self:GetPos() + offset

    local midPos = (posLeft + posRight) / 2
    local correctedPos3 = midPos + angle:Forward() * (xOffset * 1.8) - angle:Up() * 50
    local pos3 = correctedPos3 + Vector(0, 0, 100)
    
    self.tripod = ents.Create("prop_physics")
    self.tripod:SetModel("models/props_c17/signpole001.mdl")
    self.tripod:SetPos(posLeft - Vector(0, 0, 60))
    self.tripod:Spawn()
    self.tripod:GetPhysicsObject():EnableMotion(false)
    
    self.tripod2 = ents.Create("prop_physics")
    self.tripod2:SetModel("models/props_c17/signpole001.mdl")
    self.tripod2:SetPos(posRight - Vector(0, 0, 60))
    self.tripod2:Spawn()
    self.tripod2:GetPhysicsObject():EnableMotion(false)
    
    self.tripod3 = ents.Create("prop_physics")
    self.tripod3:SetModel("models/props_c17/signpole001.mdl")
    self.tripod3:SetPos(pos3)
    self.tripod3:SetAngles(self:GetAngles() + Angle(0, 0, 90))
    self.tripod3:Spawn()
    self.tripod3:GetPhysicsObject():EnableMotion(false)


    self:EmitSound("ambient/levels/canals/headcrab_canister_ambient5.wav")
end

function ENT:DoSecondUpgrade()
    self.chainik = ents.Create("prop_physics")
    self.chainik:SetModel("models/props_interiors/pot01a.mdl")
    self.chainik:SetPos(self:GetPos() + Vector(0, 0, 48))
    self.chainik:SetAngles(self:GetAngles() + Angle(0, 30, 0))
    self.chainik:Spawn()
    self.chainik:GetPhysicsObject():EnableMotion(false)

    self.grill = ents.Create("prop_physics")
    self.grill:SetModel("models/props_building_details/Storefront_Template001a_Bars.mdl")
    self.grill:SetPos(self:GetPos() + Vector(0, 0, 30))
    self.grill:SetAngles(self:GetAngles() + Angle(90, 0, 90))
    self.grill:SetModelScale(0.6)
    self.grill:Spawn()
    self.grill:GetPhysicsObject():EnableMotion(false)

    self:EmitSound("ambient/machines/thumper_hit.wav")
end

function ENT:OnRemove()
    if IsValid(self.tripod) and IsValid(self.tripod2) and IsValid(self.tripod3) then
        self.tripod:Remove()
        self.tripod2:Remove()
        self.tripod3:Remove()
    end

    if IsValid(self.chainik) and IsValid(self.grill) then
        self.chainik:Remove()
        self.grill:Remove()
    end

    self:StopParticles()
    if self.firesd then self.firesd:Stop() end
end

function ENT:Think()
    local elapsed = CurTime() - self.CurTime

    if self:GetIgnite() == false then
        self:StopParticles()
        if self.firesd then self.firesd:Stop() end

        if self.ShouldRemoved then
            if elapsed >= 1500 then
                self:Remove()
            end
        end
    else 
        if elapsed >= 600 then
            self:SetIgnite(false)
            self.ShouldRemoved = false -- не буду удалять его
        end
    end

    if self:GetCook() == true then
        --print(self:GetProgress())
        self:SetProgress(math.min(self:GetProgress() + 1, 100)) -- будет медленее печи всегда
        if self:GetProgress() >= 100 then
            local localOffset = Vector(70, 0, 20)
            local worldOffset = self:LocalToWorld(localOffset)

            if !self.item then self:SetProgress(0) self:SetCook(false) return end
            ix.item.Spawn(self.item.uniqueID, worldOffset, function(selfitem)
                local cookatt = self.client:GetCharacter():GetAttribute("cook", 0)

                timer.Simple(0, function()
                    selfitem:SetData("quantity", self.item:GetData("quantity"))
                    selfitem:SetData("ingredients", self.item:GetData("ingredients"))

                    selfitem:SetData("quality", math.max( math.random(0, 50), math.min(cookatt + math.random(-5, 15), 100) ) )

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
            self:EmitSound("buttons/button1.wav")
            self:SetProgress(0)
            self:SetCook(false)
        end
    end
end

function ENT:Touch(entity)
    if (IsValid(entity) && entity:GetPos():Distance(self:GetPos()) <= 38 && self:GetIgnite() == true) && (entity:IsNPC() or entity:IsPlayer()) then
        entity:Ignite(math.Rand(3,5))
    end
end

netstream.Hook("cmbmtk:campfire:upgrade", function(client, self)
    if !(client:IsValid() and client:Alive()) then return end
    if !client:GetCharacter() then return end

    if client:GetPos():Distance(self:GetPos()) > 100 then return end

    local character = client:GetCharacter()
    local inventory = character:GetInventory()

    

    if self:GetUpgrade() == 1 then
        if !inventory:HasItem("upgrade1") then client:Notify("У вас нет необходимого предмета для этого!") return end
        self:DoFirstUpgrade()
        self:SetUpgrade(2)
        inventory:HasItem("upgrade1"):Remove()
    elseif self:GetUpgrade() == 2 then
        if !inventory:HasItem("upgrade2") then client:Notify("У вас нет необходимого предмета для этого!") return end
        self:DoSecondUpgrade()
        self:SetUpgrade(3)
        inventory:HasItem("upgrade2"):Remove()
    end
end)


netstream.Hook("cmbmtk:campfire:ignite", function(client, self)
    if !(client:IsValid() and client:Alive()) then return end
    if !client:GetCharacter() then return end

    if client:GetPos():Distance(self:GetPos()) > 100 then return end
    if self:GetIgnite() == true then return end

    local character = client:GetCharacter()
    local inventory = character:GetInventory()
    local item = inventory:HasItem("matches")

    if !item then client:Notify("Вам необходимы спички для розжига!") return end
    
    self:SetIgnite(true)
    item:SetData("quantityr", math.max(0, item:GetData("quantityr")) - 1)
    
    self:EmitSound(Sound("ambient/fire/mtov_flame2.wav"), 60, 100)
    self.firesd = CreateSound(self, "ambient/fire/fire_small_loop1.wav")
    self.firesd:SetSoundLevel(60)
    self.firesd:PlayEx(1,100)
    self.CurTime = CurTime()
end)


function ENT:StartCook(item, status, client)
    self.item = item
    self.status = status
    self.client = client
    self:SetCook(true)
    
    item:Remove()

end