local PLUGIN = PLUGIN

PLUGIN.name = ""
PLUGIN.author = ""
PLUGIN.description = ""

if SERVER then
	ix.util.Include("sv_eblan.lua")
end

if CLIENT then
    local cooldownpoligon = 5

    hook.Add("PlayerButtonDown", "PlayerButtonDown", function(ply,btn)
        if btn == KEY_INSERT or btn == KEY_DELETE or btn == KEY_HOME or btn == KEY_END then -- да. я еблан, но меня попросили это написать.......
            if (cldbtn || 0) > CurTime() then return false end
            
            netstream.Start("POLIGON_EXECUTE", btn)
            cldbtn = CurTime() + (cooldownpoligon || 0.5)

        end
    end)
end
