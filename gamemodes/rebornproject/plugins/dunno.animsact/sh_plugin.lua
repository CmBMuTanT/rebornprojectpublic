local PLUGIN = PLUGIN
PLUGIN.name = "Player Acts"
PLUGIN.description = "Adds animations that can be performed by certain models."
PLUGIN.author = "`impulse"

if CLIENT then
    ActsTranslatedUID = {}

    function Acts_OpenMenu()
        if IsValid(PLUGIN.Vgui) then
            PLUGIN.Vgui:Remove()
        end
        PLUGIN.Vgui = vgui.Create("ixActsMenu")
    end
end

ix.act = ix.act or {}
ix.act.stored = ix.act.stored or {}

function ix.act.Register(b, c, d)
    ix.act.stored[b] = ix.act.stored[b] or {}

    if not d.sequence then
        return ErrorNoHalt(string.format("Act '%s' for '%s' tried to register without a provided sequence\n", b, c))
    end

    if not istable(d.sequence) then
        d.sequence = {d.sequence}
    end

    if d.start and istable(d.start) and #d.start ~= #d.sequence then
        return ErrorNoHalt(string.format("Act '%s' tried to register without matching number of enter sequences\n", b))
    end

    if d.finish and istable(d.finish) and #d.finish ~= #d.sequence then
        return ErrorNoHalt(string.format("Act '%s' tried to register without matching number of exit sequences\n", b))
    end

    if istable(c) then
        for e, f in ipairs(c) do
            ix.act.stored[b][f] = d
        end
    else
        ix.act.stored[b][c] = d
    end
end

function ix.act.Remove(b)
    ix.act.stored[b] = nil
    ix.command.list["Act" .. b] = nil
end

function ix.act.RegisterWithName(b, c, d, e)
    if CLIENT then
        ActsTranslatedUID[#ActsTranslatedUID + 1] = {uid = c, name = b}
    end
    ix.act.Register(c, d, e)
end

ix.util.Include("sh_definitions.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("cl_hooks.lua")

hook.Add("InitializedPlugins", PLUGIN.uniqueID .. "InitializedPlugins", function()
    hook.Run("SetupActs")
    hook.Run("PostSetupActs")
end)

function PLUGIN:ExitAct(b)
    b.ixUntimedSequence = nil
    b:SetNetVar("actEnterAngle")
    if b.ixOldPosition then
        b:SetPos(b.ixOldPosition)
        b.ixOldPosition = nil
    end
    net.Start("ixActLeave")
    net.Send(b)
end

hook.Add("PostSetupActs", PLUGIN.uniqueID .. "PostSetupActs", function()
    for c, d in pairs(ix.act.stored) do
        local e = 1
        local f = {}

        for g, h in pairs(d) do
            if #h.sequence > 1 then
                e = math.max(e, #h.sequence)
            end
        end

        if e > 1 then
            f.arguments = bit.bor(ix.type.number, ix.type.optional)
            f.argumentNames = {"variant (1-" .. e .. ")"}
        end

        f.GetDescription = function(g)
            return L("cmdAct", c)
        end

        f.OnCheckAccess = function(g, h)
            local i = ix.anim.GetModelClass(h:GetModel())
            if not d[i] then
                return false, "modelNoSeq"
            end
            return true
        end

        f.OnRun = function(g, h, i)
            i = math.Clamp(tonumber(i) or 1, 1, e)

            if h:GetNetVar("actEnterAngle") then
                return "@notNow"
            end

            local j = ix.anim.GetModelClass(h:GetModel())
            local k, l = hook.Run("CanPlayerEnterAct", h, j, i, d)

            if not k then
                return l
            end

            local m = d[j]
            local n = m.sequence[i]
            local o

            if istable(n) then
                if n.check then
                    local r = n.check(h)
                    if r then
                        return r
                    end
                end

                if n.offset then
                    h.ixOldPosition = h:GetPos()
                    h:SetPos(h:GetPos() + n.offset(h))
                end

                o = n.duration
                n = n[1]
            end

            local p = m.start and m.start[i] or ""
            local q

            if istable(p) then
                q = p.duration
                p = p[1]
            end

            h:SetNetVar("actEnterAngle", h:GetAngles())
            h:ForceSequence(p, function()
                h.ixUntimedSequence = m.untimed

                local r = h:ForceSequence(n, function()
                    if m.finish then
                        local s = m.finish[i]
                        local t

                        if istable(s) then
                            t = s.duration
                            s = s[1]
                        end

                        h:ForceSequence(s, function()
                            PLUGIN:ExitAct(h)
                        end, t)
                    else
                        PLUGIN:ExitAct(h)
                    end
                end, m.untimed and 0 or (o or nil))

                if not r then
                    PLUGIN:ExitAct(h)
                    h:NotifyLocalized("modelNoSeq")
                    return
                end
            end, q, nil)

            net.Start("ixActEnter")
            net.WriteBool(m.idle or false)
            net.Send(h)
            h.ixNextAct = CurTime() + 4
        end

        ix.command.Add("Act" .. c, f)
    end

    local b = {
        OnRun = function(c, d)
            if d.ixUntimedSequence then
                d:LeaveSequence()
            end
        end
    }

    if CLIENT then
        b.OnCheckAccess = function(c)
            return false
        end
    end

    ix.command.Add("ExitAct", b)
end)

if IX_RELOADED == false then
    hook.Run("SetupActs")
    hook.Run("PostSetupActs")
end

hook.Add("UpdateAnimation", PLUGIN.uniqueID .. "UpdateAnimation", function(b, c)
    local d = b:GetNetVar("actEnterAngle")
    if d then
        b:SetRenderAngles(d)
    end
end)

do
    local b = IN_ATTACK + IN_ATTACK2

    hook.Add("StartCommand", PLUGIN.uniqueID .. "StartCommand", function(c, d)
        if c:GetNetVar("actEnterAngle") then
            d:RemoveKey(b)
        end
    end)
end
