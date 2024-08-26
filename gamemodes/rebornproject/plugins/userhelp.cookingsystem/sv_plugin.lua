local PLUGIN = PLUGIN


netstream.Hook("cmbmtk:fry", function(client, item, self)
    if !IsValid(self) then return end
    if !(client:IsValid() and client:Alive()) then return end
    if !client:GetCharacter() then return end

    if client:GetPos():Distance(self:GetPos()) > 100 then return end

    if self:GetClass() == "cmbmtk_stove" then
        if self.Uses <= 0 then client:Notify("В плите недостаточно газа.") return end
    elseif self:GetClass() == "cmbmtk_campfire" then
        if self:GetIgnite() == false then client:Notify("Для начала готовки подожгите костер!") return end
    end


    local character = client:GetCharacter()
    local inventory = character:GetInventory()
    local item = inventory:GetItemByID(item.id)

   self:StartCook(item, "fried", client)
end)

netstream.Hook("cmbmtk:bake", function(client, item, self)
    if !IsValid(self) then return end
    if !(client:IsValid() and client:Alive()) then return end
    if !client:GetCharacter() then return end

    if client:GetPos():Distance(self:GetPos()) > 100 then return end

    if self:GetClass() == "cmbmtk_stove" then
        if self.Uses <= 0 then client:Notify("В плите недостаточно газа.") return end
    elseif self:GetClass() == "cmbmtk_campfire" then
        if self:GetIgnite() == false then client:Notify("Для начала готовки подожгите костер!") return end
    end



    local character = client:GetCharacter()
    local inventory = character:GetInventory()
    local item = inventory:GetItemByID(item.id)

   self:StartCook(item, "baked", client)
end)

netstream.Hook("cmbmtk:boil", function(client, item, self)
    if !IsValid(self) then return end
    if !(client:IsValid() and client:Alive()) then return end
    if !client:GetCharacter() then return end

    if client:GetPos():Distance(self:GetPos()) > 100 then return end

    if self:GetClass() == "cmbmtk_stove" then
        if self.Uses <= 0 then client:Notify("В плите недостаточно газа.") return end
    elseif self:GetClass() == "cmbmtk_campfire" then
        if self:GetIgnite() == false then client:Notify("Для начала готовки подожгите костер!") return end
    end


    local character = client:GetCharacter()
    local inventory = character:GetInventory()
    local item = inventory:GetItemByID(item.id)
    --item.

   self:StartCook(item, "boiled", client)
end)
