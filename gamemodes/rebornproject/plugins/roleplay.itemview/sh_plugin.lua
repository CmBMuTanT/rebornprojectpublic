
local PLUGIN = PLUGIN
PLUGIN.name = "Resident Evil Item Pickup"
PLUGIN.author = "ZweiProbleme"
PLUGIN.description = "Осмотр предмета"

if (CLIENT) then
    function PLUGIN:OpenViewMenu(uniqueID)
        local itemMenu = vgui.Create("ixREItemPopup")
        itemMenu:Populate(uniqueID)
    end

    -- String->Bool mappings for whether font has been created
    local _createdFonts = {}

    -- Cached IMGUIFontNamd->GModFontName
    local _imguiFontToGmodFont = {}

    local EXCLAMATION_BYTE = string.byte("!")
    function vgui.xFont(font, defaultSize)
        -- special font
        if string.byte(font, 1) == EXCLAMATION_BYTE then

            local existingGFont = _imguiFontToGmodFont[font]
            if existingGFont then
                return existingGFont
            end

            -- Font not cached; parse the font
            local name, size = font:match("!([^@]+)@(.+)")
            if size then size = tonumber(size) end

            if not size and defaultSize then
                name = font:match("^!([^@]+)$")
                size = defaultSize
            end

            local fontName = string.format("IMGUI_%s_%d", name, size)
            _imguiFontToGmodFont[font] = fontName
            if not _createdFonts[fontName] then
                surface.CreateFont(fontName, {
                    font = name,
                    size = size
                })
                _createdFonts[fontName] = true
            end

            return fontName
        end
        return font
    end

    function PLUGIN:GenerateViewButton(itemTable)
        local item = ix.item.list[itemTable]
        item.functions.viewIt = {
            name = 'Осмотреть',
            description = 'Осмотреть предмет в 3Д-режиме',
            icon = 'icon16/eye.png',
            OnClick = function(item)
                self:OpenViewMenu(item.uniqueID)
            end
        }
    end
    
    function PLUGIN:InitializedPlugins()
        local itemList = ix.item.list
        for k, v in pairs( itemList ) do
            self:GenerateViewButton(k)
        end
    end
end