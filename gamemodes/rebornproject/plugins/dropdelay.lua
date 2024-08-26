local PUGIN = PLUGIN

PLUGIN.name = "Item Pickup & Drop Delay"
PLUGIN.description = "Добавляет задержки между выбрасыванием/взятием предметов снова."
PLUGIN.author = "Riggs.mackay"

ix.config.Add("dropDelay",30, "Задержка выпадения предметов в секундах.", nil, {
    category = PLUGIN.name,
    data = {
        decimals = 1,
        min = 0,
        max = 60,
    },
})

ix.config.Add("takeDelay", 5, "Задержка взятия предметов в секундах.", nil, {
    category = PLUGIN.name,
    data = {
        decimals = 1,
        min = 0,
        max = 60,
    },
})

if ( SERVER ) then
    function PLUGIN:PlayerInteractItem(ply, action, item)
        if ( action == "drop" ) then
            ply.dropDelay = true
            
            timer.Create("ixDropDelay."..ply:SteamID64(), ix.config.Get("dropDelay", 1), 1, function()
                if ( IsValid(ply) ) then
                    ply.dropDelay = nil
                end
            end)
        elseif ( action == "take" ) then
            ply.takeDelay = true

            timer.Create("ixTakeDelay."..ply:SteamID64(), ix.config.Get("takeDelay", 1), 1, function()
                if ( IsValid(ply) ) then
                    ply.takeDelay = nil
                end
            end)
        end
    end

    function PLUGIN:CanPlayerDropItem(ply)
        if ( ply.dropDelay ) then
            ply:Notify("Вам нужно подождать, прежде чем снова что-то уронить!")
            return false
        end
    end

    function PLUGIN:CanPlayerTakeItem(ply)
        if ( ply.takeDelay ) then
            ply:Notify("Вам нужно подождать, прежде чем забрать что-то снова!")
            return false
        end
    end
end