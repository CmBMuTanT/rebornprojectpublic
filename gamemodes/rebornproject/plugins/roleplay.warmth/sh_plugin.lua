
local PLUGIN = PLUGIN

PLUGIN.name = "Warmth"
PLUGIN.description = "Adds a warmth dependency for characters."
PLUGIN.author = "`impulse + Б.О! Джеймс Б.О!"

--[[
	Переписал функции с SF1 на SF2, так же сделал проверку по одежде, чтоб быстрее согревались или меньше мерзли епта)
——————————————————————————————————————no cmbmutant.xyz?———————————————————————————
          .                                                      .
        .n                   .                 .                  n.
  .   .dP                  dP                   9b                 9b.    .
 4    qXb         .       dX                     Xb       .        dXp     t
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'
        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP
                     `'      9XXXXXX(   )XXXXXXP      `'
                              XXXX X.`v'.X XXXX
                              XP^X'`b   d'`X^XX
                              X. 9  `   '  P )X
                              `b  `       '  d'
                               `             '
—————————————————————————————————————————————————————————————————————————————————
]]


PLUGIN.warmthEntityDistance = 128 -- how close you need to be to the entity to start gaining warmth
PLUGIN.warmthEntities = { -- list of entities that provide warmth
	["st_vj_fireplace3"] = true,
	["st_vj_fireplace"] = true,
	["st_vj_gaslight"] = true,
	["st_vj_fireplace2"] = true,
    ["sent_vj_fireplace"] = true,
}

ix.config.Add("warmthEnabled", false, "ВКЛ/ВЫКЛ", function(oldValue, newValue)
	if (newValue) then
		hook.Run("WarmthEnabled")
	else
		hook.Run("WarmthDisabled")
	end
end, {category = "warmth"})

-- we'll default to stormfox's temperature settings if the server has it installed
if (!StormFox) then
	ix.config.Add("warmthTemp", 20, "The current temperature in celsius.", nil, {
		data = {min = -40, max = 40, decimals = 1},
		category = "warmth"
	})
end

ix.config.Add("warmthDamage", 2, "Сколько урона наносить за холод", nil, {
	data = {min = 0, max = 100},
	category = "warmth"
})

ix.config.Add("warmthMinTemp", 10, "Минимальное кол-во температуры которое можно держать", nil, {
	data = {min = -40, max = 40, decimals = 1},
	category = "warmth"
})

ix.config.Add("warmthRecoverScale", 0.25, "How much warmth you regain by being indoors. This is a multiplier of warmthLossTime.", nil, {
	data = {min = 0.01, max = 2, decimals = 2},
	category = "warmth"
})

ix.config.Add("warmthFireScale", 2, "How much warmth you regain by being near an entity that produces warmth (i.e a fire).", nil, {
	data = {min = 0.01, max = 10, decimals = 2},
	category = "warmth"
})

ix.config.Add("warmthLossTime", 5, "How many minutes it takes for a player to lose all their warmth.", nil, {
	data = {min = 0.1, max = 1440, decimals = 1},
	category = "warmth"
})

ix.config.Add("warmthTickTime", 5, "How many seconds to wait before calculating each player's warmth. You should usually leave this as the default.", function(oldValue, newValue)
	if (SERVER) then
		PLUGIN:SetupAllTimers()
	end
end, {data = {min = 1, max = 60}, category = "warmth"})

ix.config.Add("warmthKill", false, "Whether or not to kill characters if they reach zero warmth.", nil, {
	category = "warmth"
})

ix.char.RegisterVar("warmth", {
	field = "warmth",
	fieldType = ix.type.number,
	default = 100,
	isLocal = true,
	bNoDisplay = true
})

function PLUGIN:InitializedConfig()
	if (ix.config.Get("warmthEnabled")) then
		hook.Run("WarmthEnabled")
	else
		hook.Run("WarmthDisabled")
	end
end

function PLUGIN:GetTemperature()
	return StormFox2 and StormFox2.Temperature.Get() or ix.config.Get("warmthTemp", 20)
end

function PLUGIN:PlayerIsInside(client)
	if (StormFox2) then
		return !StormFox2.Wind.IsEntityInWind(client)
	end
	

	local trace = {
		start = client:GetPos(),
		endpos = client:GetPos() + Vector(0, 0, 524288),
		mask = MASK_SHOT,
		filter = client
	}

	trace = util.TraceLine(trace)
	return !trace.HitSky
end

ix.util.Include("sv_hooks.lua")
ix.util.Include("cl_hooks.lua")
