 
ITEM.name = "Музыкальный проигрыватель"
ITEM.description = "Старый проигрывать для кассет. Неплохо сохранился с довоенных времён"
ITEM.audioplayer = true
ITEM.price = 50
ITEM.category = "Кассеты"
ITEM.exRender = true 
ITEM.model = "models/devcon/mrp/props/player_3.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(731.62, 59.75, -3.59),
	ang = Angle(-0.66, 184.67, 0),
	fov = 1.22
}


-- Item functions

ITEM.functions.music = {
    name = "Музыка",
    tip = "useTip",
    sound = "weapons/shelk_1.mp3",
    icon = "icon16/music.png",
    isMulti = true,
    multiOptions = function( item, client )
        local musiclist = {}

        for k, v in next, client:GetCharacter():GetInventory():GetItems() do
            if v.musicID then
                table.insert( musiclist, {
                    name = v.name,
                    data = { track = v.music, i_id = v.uniqueID},
                } )
            end
        end

        return musiclist
    end,
    OnCanRun = function( item )
        local client = item.player
        return !IsValid(item.entity) and IsValid(client) and !item:GetData("Play")
    end,
    OnRun = function( item, data )
        item:SetData("Play", false)
        local client = item.player
        if data and data.i_id and data.track then
            if item:GetData("CurMusicData") then
                client:StopSound(item:GetData("CurMusicData").track)
                item:SetData("CurMusicData",nil)
            end
            item:SetData("Play", true)
            client:GetCharacter():GetInventory():Remove(client:GetCharacter():GetInventory():HasItem(data.i_id):GetID())
            item:SetData("CurMusicData", {track = data.track, cassette = data.i_id})
            timer.Simple(0.2, function()
                client:EmitSound(data.track,75,100)
            end)
        end 

        return false
    end,
}

ITEM.functions.off = {
    name = "Выключить",
    tip = "useTip",
    sound = "weapons/shelk_1.mp3",
    icon = "icon16/stop.png",
    OnCanRun = function( item )
        local client = item.player
        return !IsValid(item.entity) and IsValid(client) and item:GetData("Play")
    end,
    OnRun = function( item, data )
        local client = item.player
        item:SetData("Play", false)
        if item:GetData("CurMusicData") then
            client:StopSound(item:GetData("CurMusicData").track)
            client:GetCharacter():GetInventory():Add(item:GetData("CurMusicData").cassette)
            --item:SetData("CurMusicData",nil)
        else
            client:Notify("Проигрывание остановлено")
        end

        return false
    end,
}

-- Entity

ITEM.functions.enton = {
    name = "Выбрать кассету",
    tip = "useTip",
    sound = "weapons/shelk_1.mp3",
    icon = "icon16/music.png",
    OnCanRun = function( item )
        return IsValid(item.entity) && item.entity:GetNetVar("CurMusic", "") == ""
    end,
    OnRun = function( itemTable, data )
        local client = itemTable.player
        local ent = itemTable.entity
        netstream.Start(client, "ixPlayCassete", ent)
        return false
    end,
}

ITEM.functions.entoff = {
    name = "Выключить",
    tip = "useTip",
    sound = "weapons/shelk_3.mp3",
    icon = "icon16/stop.png",
    OnCanRun = function( item )
        return IsValid(item.entity) && item.entity:GetNetVar("CurMusic", "") != ""
    end,
    OnRun = function( item, data )
        --item.entity:StopSound(item.entity:GetNetVar("CurMusic", ""))
        item.player:GetCharacter():GetInventory():Add(item.entity:GetNetVar("Casette"))
        item.entity:SetNetVar("Casette",nil)
        item.entity:SetNetVar("CurMusic",nil)
        return false
    end,
}

ITEM.functions.setVolume = {
    name = "Изменить громкость",
    tip = "useTip",
    sound = "weapons/shelk_1.mp3",
    icon = "icon16/sound.png",
    OnCanRun = function( item )
        return IsValid(item.entity) && item.entity:GetNetVar("CurMusic", "") ~= ""
    end,
    OnRun = function( itemTable, data )
        net.Start("ixMusicVolume")
            net.WriteEntity(itemTable.entity)
        net.Send(itemTable.player)

        return false
    end,
}

ITEM.functions.setRewind = {
    name = "Перемотать",
    tip = "useTip",
    sound = "weapons/shelk_1.mp3",
    icon = "icon16/control_end_blue.png",
    OnCanRun = function( item )
        return IsValid(item.entity) && item.entity:GetNetVar("CurMusic", "") ~= ""
    end,
    OnRun = function( itemTable, data )
        net.Start("ixMusicRewind")
            net.WriteEntity(itemTable.entity)
        net.Send(itemTable.player)

        return false
    end,
}

-- Stop music if take

ITEM:Hook("take", function(item)
    local ent = item.entity
    ent:StopSound(ent:GetNetVar("CurMusic", ""))
    ent:SetNetVar("CurMusic", nil)
    if ent:GetNetVar("Casette") then
        item.player:GetCharacter():GetInventory():Add(ent:GetNetVar("Casette"))
        ent:SetNetVar("Casette",nil)
    end
    item:SetData("Play", false)
end)

ITEM.functions.drop = {
    tip = "dropTip",
	icon = "icon16/world.png",
    OnRun = function(item)

        local bSuccess, error = item:Transfer(nil, nil, nil, item.player)

        if (!bSuccess and isstring(error)) then
            item.player:NotifyLocalized(error)
        else
            item.player:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and !item:GetData("Play", true)
    end
}

-- Paint green square in inventory if play = true

if (CLIENT) then
	-- Draw camo if it is available.
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)

			surface.SetDrawColor(100, 255, 120, 5)
			surface.SetTexture(surface.GetTextureID("vgui/gradient-u"))
			surface.DrawTexturedRect(0, 0, w, h)

			surface.SetDrawColor(100, 255, 120, 5)
			surface.SetTexture(surface.GetTextureID("vgui/gradient-d"))
			surface.DrawTexturedRect(0, 0, w, h)
		end
	end
end
