local PLUGIN = PLUGIN
PLUGIN.name = "Рендер курсора"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[спизжено от incredible-gmod.ru, но переделано под плагин (вельзевул ты совсем ебанулся уже?) + добавлены описания, и прочая ебалда которая планируется обновлятся.]]
ix.util.Include("ui/cl_vguiz.lua")

if CLIENT then

    local config = {
        minDist = 100 ^ 2,
        maxDist = 128 ^ 2,
        alphaSpeed = 6,
        iconSize = 8,
        classList = { -- class = icon (path or url)
            func_door  = {
                material = "https://i.imgur.com/gF0v0Oh.png",
                description = [[
                    ВАМ НЕОБХОДИМА КНОПКА ДЛЯ ВЗАИМОДЕЙСТВИЯ]],
                col = Color(255, 0, 0),
            },

            func_button  = {
                material = "https://i.imgur.com/8iPmaPo.png",
                description = [[
                    НАЖМИТЕ ]]..string.upper(input.LookupBinding("+use") or "+use")..[[ ДЛЯ ВЗАИМОДЕЙСТВИЯ]],
                col = Color(0, 255, 0),
            },

            func_door_rotating  = {
                material = "https://i.imgur.com/ohnjb0z.png",
                description = [[
                    НАЖМИТЕ ]]..string.upper(input.LookupBinding("+use") or "+use")..[[ ДАБЫ ОТКРЫТЬ ДВЕРЬ]],
                col = Color(255, 255, 255),
            },
            prop_door_rotating  = {
                material = "https://i.imgur.com/ohnjb0z.png",
                description = [[
                    НАЖМИТЕ ]]..string.upper(input.LookupBinding("+use") or "+use")..[[ ДАБЫ ОТКРЫТЬ ДВЕРЬ
                    НАЖМИТЕ ]]..string.upper(input.LookupBinding("+walk") or "+walk")..[[ + ]]..string.upper(input.LookupBinding("+use"))..[[ ДАБЫ ТИХО ОТКРЫТЬ ДВЕРЬ
                    НАЖМИТЕ ]]..string.upper(input.LookupBinding("+speed") or "+speed")..[[ + ]]..string.upper(input.LookupBinding("+use"))..[[ ДАБЫ ВЫБИТЬ ДВЕРЬ]],
                col = Color(255, 255, 255),
            },
        }
    }
    
    -----------------------------
    
    file.CreateDir("helix/plugins/cursor.render/materials")
    local empty_material = Material("dev/clearalpha")
    
    local WebMaterial = setmetatable({storage = {}}, {
        __index = function(self, url)
            return self(url)
        end,
        __call = function(self, url, flags)
            local storage = rawget(self, "storage")
            if storage[url] then return storage[url] end
    
            if url:find("https?://[%w-_%.%?%.:/%+=&]+") == nil then
                return Material(url, flags)
            end
    
            local fname = url:match("([^/]+)$")
            if fname:match("^.+(%..+)$") == nil then
                fname = fname ..".png"
            end
    
            local path = "helix/plugins/cursor.render/materials/".. util.CRC(url)  .."_".. fname
            local dpath = "data/".. path
    
            if file.Exists(path, "DATA") then
                storage[url] = Material(dpath, flags)
                return storage[url]
            end
    
            http.Fetch(url, function(img)
                file.Write(path, img)
                storage[url] = Material(dpath, flags)--, "smooth mips")
            end)
    
            storage[url] = empty_material
            return empty_material
        end
    })
    
    -----------------------------

    local Panel = vgui.Create( "Panel3D2D2D" )

    -----------------------------
    
    function PLUGIN:PostDrawOpaqueRenderables()
        local ply = LocalPlayer()
        local tr = ply:GetEyeTrace()
        local ent = tr.Entity

        if IsValid(ent) and config.classList[ent:GetClass()] then
            local dist = ent:GetPos():DistToSqr(ply:GetPos())
            if dist > config.maxDist then return end


            local icon = WebMaterial(config.classList[ent:GetClass()].material, "smooth mips")
            local size = config.iconSize

            local ang = tr.HitNormal:Angle()
            ang:RotateAroundAxis(ang:Forward(), 90)
            ang:RotateAroundAxis(ang:Right(), -90)

            surface.SetAlphaMultiplier(1 - ((dist - config.minDist) / config.maxDist) * config.alphaSpeed)



            cam.Start3D2D(tr.HitPos, ang, 1)
                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(icon)
                surface.DrawTexturedRect(-size * 0.5, -size * 0.7, size, size + 2)
            cam.End3D2D()

            cam.Start3D2D(tr.HitPos, ang, 0.1) -- и не пиздите что я мог сделать это в 1 каме ДА МОГ НО НЕ БУДУ!
                Panel:SetText(config.classList[ent:GetClass()].description)
                Panel:SetColor(config.classList[ent:GetClass()].col)
                Panel:PaintManual()
            cam.End3D2D()

            surface.SetAlphaMultiplier(1)
        end
    end
end