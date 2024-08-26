local PLUGIN = PLUGIN

function PLUGIN:ShowHelp(client) --F1
    if !IsValid(client) and !client:Alive() then return end
    if !client:GetCharacter() then return end

    local character = client:GetCharacter()
    local inv = client:ExtraInventory("hotkey_f1")

    if not inv then return end

    for id,item in pairs (inv:GetItems()) do
       if !item.functions then return end
       if !item.functions.use then return end

        if item.functions.use.OnCanRun(item) then
            local result
            local callback = item.functions["use"]

            if (result == nil) then
                result = callback.OnRun(item, data)
            end

            if (result != false) then
                item:Remove()
            end

            hook.Run("PlayerInteractItem", client, "use", item)
        end
    end
end

function PLUGIN:ShowTeam(client) --F2
    if !IsValid(client) and !client:Alive() then return end
    if !client:GetCharacter() then return end

    local character = client:GetCharacter()
    local inv = client:ExtraInventory("hotkey_f2")

    if not inv then return end

    for id,item in pairs (inv:GetItems()) do
       if !item.functions then return end
       if !item.functions.use then return end

        if item.functions.use.OnCanRun(item) then
            local result
            local callback = item.functions["use"]

            if (result == nil) then
                result = callback.OnRun(item, data)
            end

            if (result != false) then
                item:Remove()
            end

            hook.Run("PlayerInteractItem", client, "use", item)
        end
    end
end

function PLUGIN:ShowSpare1(client) --F3
    if !IsValid(client) and !client:Alive() then return end
    if !client:GetCharacter() then return end

    local character = client:GetCharacter()
    local inv = client:ExtraInventory("hotkey_f3")

    if not inv then return end

    for id,item in pairs (inv:GetItems()) do
       if !item.functions then return end
       if !item.functions.use then return end

        if item.functions.use.OnCanRun(item) then
            local result
            local callback = item.functions["use"]

            if (result == nil) then
                result = callback.OnRun(item, data)
            end

            if (result != false) then
                item:Remove()
            end

            hook.Run("PlayerInteractItem", client, "use", item)
        end
    end
end

function PLUGIN:ShowSpare2(client) --F4
    if !IsValid(client) and !client:Alive() then return end
    if !client:GetCharacter() then return end

    local character = client:GetCharacter()
    local inv = client:ExtraInventory("hotkey_f4")

    if not inv then return end

    for id,item in pairs (inv:GetItems()) do
       if !item.functions then return end
       if !item.functions.use then return end

        if item.functions.use.OnCanRun(item) then
            local result
            local callback = item.functions["use"]

            if (result == nil) then
                result = callback.OnRun(item, data)
            end

            if (result != false) then
                item:Remove()
            end

            hook.Run("PlayerInteractItem", client, "use", item)
        end
    end
end




--- я все испробовал. Один из единственных выходов который я пока что придумал.
function PLUGIN:PlayerLoadedCharacter(client, character)
    timer.Simple(.5, function()
        if client:GetNetVar("silly") and client:GetNetVar("cats") then
            local catsArray = client:GetNetVar("cats")
            local inventory = character:GetInventory()
            local GetItemss = ix.plugin.Get("gui.recreateui")
        
            for _, v in pairs(catsArray) do -- меня очень сильно подгоняли пришлось сделать так, абузить можно что пиздец. WIP СТРОГО.
                inventory:Add(v)
            end
        
            -- character:GiveMoney(client:GetNetVar("StartCredits", 0)) -- выдаем деньги, которые он не потратил (очки)
            -- client:SetNetVar("StartCredits", 0) -- сетим очки на 0

            client:SetNetVar("silly", nil)
            client:SetNetVar("cats", nil)
        end     
    end)   
end


net.Receive("ixCharacterChoose", function(length, client) -- переписал под более удобную тему
    local id = net.ReadUInt(32)

    if (client:GetCharacter() and client:GetCharacter():GetID() == id) then
        net.Start("ixCharacterLoadFailure")
            net.WriteString("@usingChar")
        net.Send(client)
        return
    end

    local character = ix.char.loaded[id]

    if (character and character:GetPlayer() == client) then
        local status, result = hook.Run("CanPlayerUseCharacter", client, character)

        if (status == false) then
            net.Start("ixCharacterLoadFailure")
                net.WriteString(result or "")
            net.Send(client)
            return
        end

        local currentChar = client:GetCharacter()

        if (currentChar) then
            currentChar:Save()

            for _, v in ipairs(currentChar:GetInventory(true)) do
                if (istable(v)) then
                    v:RemoveReceiver(client)
                end
            end
        end

        hook.Run("PrePlayerLoadedCharacter", client, character, currentChar)

        timer.Simple(3.5, function()
            character:Setup()
            client:Spawn()
            hook.Run("PlayerLoadedCharacter", client, character, currentChar)
        end)
    else
        net.Start("ixCharacterLoadFailure")
            net.WriteString("@unknownError")
        net.Send(client)

        ErrorNoHalt("[Helix] Attempt to load invalid character '" .. id .. "'\n")
    end
end)