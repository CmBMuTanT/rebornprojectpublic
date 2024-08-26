local PLUGIN = PLUGIN

function PLUGIN:CharacterLoaded()
    ix.bar.Remove("warmth")
    ix.bar.Remove("hunger")
    ix.bar.Remove("thirst")
    ix.bar.Remove("health")
    ix.bar.Remove("armor")
    ix.bar.Remove("stm")
end

local size = ScrH()*.045
local health,temperature,food,thirst,stamina = 100,100,100,100,100
local health_color, temperature_color,food_color,thirst_color = Color(255,255,255), Color(255,255,255), Color(255,255,255), Color(255,255,255)
local flicker = 0
local hudmaterals = {
    ["health"] = {
        ["1"] = Material("cmbmtk_hudmats/health1.png"),
        ["2"] = Material("cmbmtk_hudmats/health2.png")
    },
    ["temperature"] = {
        ["1"] = Material("cmbmtk_hudmats/temperature1.png"),
        ["2"] = Material("cmbmtk_hudmats/temperature2.png")
    },
    ["food"] = {
        ["1"] = Material("cmbmtk_hudmats/hunger1.png"),
        ["2"] = Material("cmbmtk_hudmats/hunger2.png")
    },
    ["thirst"] = {
        ["1"] = Material("cmbmtk_hudmats/thirst1.png"),
        ["2"] = Material("cmbmtk_hudmats/thirst2.png")
    },
    ["stamina"] = {
        ["1"] = Material("cmbmtk_hudmats/stamina1.png"),
        ["2"] = Material("cmbmtk_hudmats/stamina2.png")
    },
}

local function LerpColor(frac,from,to)
	local col = Color(
		Lerp(frac,from.r,to.r),
		Lerp(frac,from.g,to.g),
		Lerp(frac,from.b,to.b),
		Lerp(frac,from.a,to.a)
	)
	return col
end


local function hideRender()
    render.ClearStencil()
    render.SetStencilEnable(true)

    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)

    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(STENCILOPERATION_ZERO)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilReferenceValue(1)
end

local function showRender()
    render.SetStencilFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
    render.SetStencilReferenceValue(1)
end

local function disableRender()
    render.SetStencilEnable(false)
    render.ClearStencil()
end

local function DrawRender(draw1, draw2)
    hideRender()

    draw1()

    showRender()

    draw2()

    disableRender()
end

local function drawIconHud(x,y,mat1,mat2,col,value)
    local a = size * (value / 100)
    
    surface.SetDrawColor(col)
    surface.SetMaterial(mat1)
    surface.DrawTexturedRect(x, y, size, size)

    DrawRender(function()
        surface.SetDrawColor(255,255,255)
        surface.DrawRect(x,y+(size-a),size,a)
    end, function()
        surface.SetDrawColor(col)
        surface.SetMaterial(mat2)
        surface.DrawTexturedRect(x, y, size, size)
    end)
    return x - size
end

function PLUGIN:HUDPaintBackground()
    local client = LocalPlayer()

    if (!client:GetCharacter()) then
        return
    end

    local pLHealth = client:Health()
    local pLTemperature = client:GetCharacter():GetWarmth()
    local pLFood = client:GetHungerVar(1)
    local pLThirst = client:GetThirstVar(1)
    local pLStamina = client:GetLocalVar("stm", 0)
    flicker = math.abs(math.sin(CurTime()*1.5))
    local x = ScrW() - size - 100
    local y = ScrH() * .89

    


    ---------HEALTH---------
    if pLHealth > 50 then
        health = Lerp(FrameTime()*5, health, pLHealth)
        health_color = LerpColor(FrameTime()*10, health_color, Color(255, 255, math.Clamp((pLHealth-50)*5.1, 0, 255)))
    elseif pLHealth <= 30 then
        health = Lerp(FrameTime()*5, health, pLHealth)
        health_color = flicker > 0.5 and Color(255, 0, 0) or Color(255, 255, 255)
    else
        health = Lerp(FrameTime()*5, health, pLHealth)
        health_color = LerpColor(FrameTime()*10, health_color, Color(255, math.Clamp((pLHealth-50)*5.1, 0, 255), math.Clamp((pLHealth-50)*5.1, 0, 255)))
    end
    ---------HEALTH---------

    ---------TEMP---------
    temperature = Lerp(FrameTime()*5, temperature, pLTemperature)
    if pLTemperature <= 50 then
        temperature_color = LerpColor(FrameTime()*10, temperature_color, Color(math.Clamp((temperature-50)*5.1, 0, 255), 255, 255))
    else
        temperature_color = Color(255,255,255)
    end
    ---------TEMP---------

    ---------FOOD---------
    food = Lerp(FrameTime()*5, food, pLFood)
    if pLFood > 50 then
        food_color = LerpColor(FrameTime()*10, food_color, Color(255, 255, math.Clamp(pLFood * 3.27, 0, 255)))
    else
        food_color = LerpColor(FrameTime()*10, food_color, Color(255, math.Clamp((pLFood-50), 0, 255), math.Clamp((pLFood-50)*5.1, 0, 255)))
    end
    ---------FOOD---------

    ---------THIRST---------
    thirst = Lerp(FrameTime()*5, thirst, pLThirst)
    if pLThirst > 50 then
        thirst_color = LerpColor(FrameTime()*10, thirst_color, Color(255, 255, math.Clamp(pLThirst * 3.27, 0, 255)))
    else
        thirst_color = LerpColor(FrameTime()*10, thirst_color, Color(255, math.Clamp((pLThirst-50)*5.1, 0, 255), math.Clamp((pLThirst-50)*5.1, 0, 255)))
    end
    ---------THIRST---------

    ---------STAMINA---------
    stamina = Lerp(FrameTime()*5, stamina, pLStamina)
    ---------STAMINA---------

    x = drawIconHud(x, y, hudmaterals["health"]["1"], hudmaterals["health"]["2"], health_color, health)
    x = drawIconHud(x, y, hudmaterals["temperature"]["1"], hudmaterals["temperature"]["2"], temperature_color, temperature)
    x = drawIconHud(x, y, hudmaterals["food"]["1"], hudmaterals["food"]["2"], food_color, food)
    x = drawIconHud(x, y, hudmaterals["thirst"]["1"], hudmaterals["thirst"]["2"], thirst_color, thirst)
    x = drawIconHud(x, y, hudmaterals["stamina"]["1"], hudmaterals["stamina"]["2"], color_white, stamina)

end