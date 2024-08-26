local function run_comp(key, value, t2)
    if !istable(value) then
        if value != t2[key] then
            return false
        end
    else
        if !table.equal(value, t2[key]) then
            return false
        end
    end

    return true
end

function table.equal(tab1, tab2)
    if !istable(tab1) or !istable(tab2) then
        return false
    end

    if tab1 == tab2 then
        return true
    end

    local t1, t2 = 0, 0

    for k, v in pairs(tab1) do
        t1 = t1 + 1

        if !run_comp(k, v, tab2) then
            return false
        end
    end

    for k, v in pairs(tab2) do
        t2 = t2 + 1

        if !run_comp(k, v, tab1) then
            return false
        end
    end

    if t1 != t2 then
        return false
    end

    return true
end