local PLUGIN = PLUGIN

PLUGIN.name = "ESP"
PLUGIN.author = "хочу здохнуть"
PLUGIN.description = ""

PLUGIN.playerinfo = {}
PLUGIN.entityinfo = {}

depression = {
    ["superadmin"] = true,
    ["tex.admin"] = true,
    ["gl.admin"] = true,
    ["st.admin"] = true,
    ["admin"] = true,
    ["moderator"] = true,
    ["operator"] = true
} -- можешь переписать с заменой файлов, мне похуй.... Будешь с вх ходить.......

PLUGIN.entslist = {
    ["ix_item"] = Color(157, 111, 210),
    ["ix_vendor"] = Color(197, 199, 62),
    ["ix_container"] = Color(41, 175, 34)
}

if CLIENT then
    PLUGIN.mat = PLUGIN.mat or CreateMaterial("deznutz", "VertexLitGeneric", {
        ["$basetexture"] = "models/debug/debugwhite",
        ["$model"] = 1,
        ["$ignorez"] = 1
    })
end

local function addLang(name, index, data)
    if data.config and ix.lang.stored then
        data.config.index = index

        local c_index = "AdminESP_" .. index
        local c_name = "optAdminESP_" .. index
        local c_desc = "optdAdminESP_" .. index

        local newindex = index
        newindex = newindex:gsub("_pl", "")
        newindex = newindex:gsub("_en", "")

        for k, v in pairs(ix.lang.stored) do
            ix.lang.stored[k][c_name] = data.config.name .. " [" .. newindex .. "]"
            ix.lang.stored[k][c_desc] = data.config.desc
        end

        ix.option.Add(c_index, ix.type.bool, true, {
            category = "AdminESP" .. " " .. name,
            hidden = function()
                return !depression[LocalPlayer():GetUserGroup()]
            end
        })
    end
end

function PLUGIN:AddPlayerESPCustomization(index, data)
    if !index then return end
    if !data then return end

    data.index = index
    self.playerinfo[#self.playerinfo + 1] = data

    addLang("Player", index, data)
end

function PLUGIN:AddEntityESPCustomization(index, data)
    if !index then return end
    if !data then return end

    data.index = index
    self.entityinfo[#self.entityinfo + 1] = data

    addLang("Entity", index, data)
end

function PLUGIN:DistanceFits(vec1, vec2, dist)
    if dist == 0 then return true end

    return vec1:Distance(vec2) <= dist
end

local function addStructure(entity, dist, data, settings)
    if isfunction(data) and PLUGIN:DistanceFits(LocalPlayer():GetPos(), entity:GetPos(), dist) then
        if settings and settings.index then
            if ix.option.Get("AdminESP_" .. settings.index, true) then
                data = data(entity)
            else
                data = nil
            end
        else
            data = data(entity)
        end
    end

    return {data, dist, entity:GetClass()}
end

local metaPl = FindMetaTable("Player")
function metaPl:ESPInfo()
    local data = {}

    for k, v in SortedPairs(PLUGIN.playerinfo) do
        data[#data + 1] = addStructure(self, v.dist, v.data, v.config)
    end

    return data
end

local metaEn = FindMetaTable("Entity")
function metaEn:ESPInfo()
    local data = {}

    for k, v in SortedPairs(PLUGIN.entityinfo) do
        data[#data + 1] = addStructure(self, v.dist, v.data, v.config)
    end

    return data
end

ix.util.Include("cl_config.lua")
ix.util.Include("cl_plugin.lua")