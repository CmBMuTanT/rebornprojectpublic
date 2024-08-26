local PLUGIN = PLUGIN

PLUGIN.name = "Hunger system"
PLUGIN.author = "Hikka"
PLUGIN.description = "Я сидел тихо, мирно. Потом проголодался. Дальше, как в тумане."

COOKLEVEL = {
	[0] = {0, "Не приготовлено"},

	[1] = {1, "Не очень хорошо"},
	[2] = {2, "Плохо"},
	[3] = {3, "Нормально"},
	[4] = {4, "Хорошо"},
	[5] = {5, "Очень хорошо"},
	[6] = {6, "Замечательно"},
	[7] = {7, "Высший класс"},
}

--[[ Hunger ]]
ix.config.Add("hungrySeconds", 6100, "Голод, чем выше значение, тем медленее тратится голод", nil, {
	data = {min = 1, max = 99999},
	category = PLUGIN.name
})

ix.config.Add("hungerTime", 15, "Время которого вычитается из голода, когда не ешь.", nil, {
	data = {min = 0, max = 9999},
	category = PLUGIN.name
})

--[[ Thirst ]]
ix.config.Add("thirstySeconds", 6100, "Жажда, чем выше значение, тем медленее тратится жажда", nil, {
	data = {min = 1, max = 99999},
	category = PLUGIN.name
})

ix.config.Add("thirstTime", 7, "Время которого вычитается из жажды, когда не пьешь.", nil, {
	data = {min = 0, max = 9999},
	category = PLUGIN.name
})

--[[ Drunk ]]
ix.config.Add("drunkySeconds", 150, "Опьянение, чем выше значение, тем медленее проходит опьянение", nil, {
	data = {min = 1, max = 99999},
	category = PLUGIN.name
})

ix.config.Add("drunkBloomEffect", true, "Заблюривать экран когда персонаж опьянел", nil, {
    category = PLUGIN.name
})

local HUNGER_ID, DRUNK_ID, THIRST_ID = "hunger", "drunk", "thirst"

local playerMeta = FindMetaTable("Player")

--[[ Hunger ]]
function playerMeta:GetHungerVar(bRound)
	if (bRound) then
		return math.Round((1 - self:GetHungerPercent())*100)
	end
	
	return self:GetNetVar(HUNGER_ID, 0)
end

function playerMeta:GetHungerPercent()
	return math.Clamp(((CurTime() - self:GetHungerVar()) / ix.config.Get("hungrySeconds", 1100)), 0, 1)
end

--[[ Thirst ]]
function playerMeta:GetThirstVar(bRound)
	if (bRound) then
		return math.Round((1 - self:GetThirstPercent())*100)
	end
	
	return self:GetNetVar(THIRST_ID, 0)
end

function playerMeta:GetThirstPercent()
	return math.Clamp(((CurTime() - self:GetThirstVar()) / ix.config.Get("thirstySeconds", 3000)), 0, 1)
end

--[[ Drunk ]]
function playerMeta:GetDrunkVar(bRound)
	if (bRound) then
		return math.Round(self:GetDrunkPercent() * 100)
	end
	
	return self:GetNetVar(DRUNK_ID, 0)
end

function playerMeta:GetDrunkPercent()
	return math.Clamp(((self:GetDrunkVar() - CurTime()) / ix.config.Get("drunkySeconds", 200)), 0, 1)
end

ix.util.Include("sv_plugin.lua", 'server')

if (CLIENT) then
	local check
	function PLUGIN:RenderScreenspaceEffects()
		local client = LocalPlayer()
		check = ix.config.Get("drunkBloomEffect")
		
		if (!check or !IsValid(client) or not client:GetCharacter() or client:GetMoveType() == MOVETYPE_NOCLIP) then
			return
		end
		
		local value = client:GetDrunkVar(true)
		if (value > 9) then
			local blur = 3 - math.Remap(value, 20, 0, 0, 3)
			ix.util.DrawBlurAt(0, 0, ScrW(), ScrH(), blur)
		end
	end
	
	do
		ix.bar.Add(function()
			return (1 - LocalPlayer():GetHungerPercent())
		end, Color(0, 153, 51), nil, "hunger")
		
		ix.bar.Add(function()
			return (1 - LocalPlayer():GetThirstPercent())
		end, Color(0, 255, 255), nil, "thirst")
	end
end

--[[ Clockwork ]]
function PLUGIN:SetupMove(player, moveData)
--[[
	if (IsValid(player) and player:Alive() and not IsValid(player.ixRagdoll)) then
		if CurTime() > player:GetDrunkVar() then return end
		local percent = player:GetDrunkVar(true)
		
		local frameTime = FrameTime()
		local curTime = CurTime()
		
		if percent > 0 and player.DrunkSwerve then
			player.DrunkSwerve = math.Clamp(player.DrunkSwerve + frameTime, 0, math.min(percent * 2, 16))
			
			moveData:SetMoveAngles(moveData:GetMoveAngles() + Angle(0, math.cos(curTime) * player.DrunkSwerve, 0))
		elseif (player.DrunkSwerve and player.DrunkSwerve > 1 and percent > 0) then
			player.DrunkSwerve = math.max(player.DrunkSwerve - frameTime, 0)
			
			moveData:SetMoveAngles(moveData:GetMoveAngles() + Angle(0, math.cos(curTime) * player.DrunkSwerve, 0))
		elseif (player.DrunkSwerve ~= 1) then
			player.DrunkSwerve = 1
		end
	end
]]--
end

hook.Add("RenderScreenspaceEffects", "ixGetDrunk", function()
	if CurTime() > LocalPlayer():GetDrunkVar() or LocalPlayer():Alive() == false then return end
	DrawMotionBlur( 0.03, 10, 0 )
end)