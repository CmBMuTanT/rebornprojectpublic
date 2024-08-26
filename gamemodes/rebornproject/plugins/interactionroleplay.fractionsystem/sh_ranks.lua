--[[---------------------------------------------------------

-------------------------------
------------ USAGE ------------
-------------------------------

Add Ranks table into faction you need

FACTION.Ranks = {
    [1] = {"Private", "icon16/medal_bronze_1.png", CLASS_RECRUIT, true}
}

Let's look at the table in more detail:

"Recruit" ---> name of the rank
------------------------------------
"icon16/medal_bronze_1.png" ---> icon, used in PopulateCharacterInfo (tooltip). If you don't need this, just set nil
------------------------------------
CLASS_ELITE ---> class (you need put class index), sets when rank changed. If you don't need this, just set nil
------------------------------------
true ---> Boolean for high ranks. "true" means that a player can assign ranks to other players. If you don't need this, just don't set anything

The finished table looks like this:

FACTION.Ranks = {
    [1] = {"Private", nil, CLASS_RECRUIT},
    [2] = {"Corporal", nil, CLASS_RECRUIT},
    [3] = {"Specialist", nil, nil},
    [4] = {"Sergeant", "icon16/medal_bronze_1.png", CLASS_OFFICER},
    [5] = {"Master Sergeant", "icon16/medal_silver_1.png", CLASS_SENIOR, true},
    [6] = {"Sergeant Major", "icon16/medal_gold_1.png", CLASS_SENIOR, true}
}

----------------------------------
------------ COMMANDS ------------
----------------------------------

CharSetRank /// Chat command ONLY for admins. If you need set rank for any character, use this.

----------------------------------

CharRaise /// Chat command for everyone. Player may raise a character if:

    1. The client rank is lower than the target rank
    2. Client character rank has the fourth true expression in the rank table ( [6] = {"Sergeant Major", nil, nil, true} )
    3. Client faction == Target faction
    4. If client != target

-----------------------------------
------------ FUNCTIONS ------------
-----------------------------------

Plugin has function called when character rank changed

You need add this into your faction:

function FACTION:OnRankChanged(client, oldValue, value)
    --- Do something ---
end


FACTION.Ranks = {
    [1] = {"PV1", nil, CLASS_HANZA},
    [2] = {"CPL", nil, CLASS_HANZA},
    [3] = {"SGT", "icon16/medal_bronze_1.png", nil},
    [4] = {"1LT", "icon16/medal_silver_1.png", nil},
    [5] = {"CPT", "icon16/medal_silver_1.png", nil},
    [6] = {"LTC", "icon16/medal_silver_1.png", nil, true},
    [7] = {"COL", "icon16/medal_gold_1.png", nil, true}
}
FACTION.Ranks = {
    [1] = {"Рядовой", nil, CLASS_REDLINE},
    [2] = {"Ефрейтор", nil, CLASS_REDLINE},
    [3] = {"Мл.Сержант", nil, nil},
    [4] = {"Сержант", nil, nil},
	[5] = {"Ст.Сержант", nil, nil},
    [6] = {"Старшина", nil, nil},
    [7] = {"Прапорщик", nil,nil},
	[8] = {"Мл.Лейтенант", "icon16/medal_silver_1.png", nil},
    [9] = {"Лейтенант", "icon16/medal_silver_1.png", nil},
    [10] = {"Ст.Лейтенант", "icon16/medal_silver_1.png", nil},
    [11] = {"Капитан", "icon16/medal_gold_1.png",nil},
    [12] = {"Майор", "icon16/medal_gold_1.png", nil, true},
    [13] = {"Подполковник", "icon16/medal_gold_1.png", nil, true},
    [14] = {"Полковник", "icon16/medal_gold_1.png", nil, true}
}

FACTION.Ranks = {
    [1] = {"Рекрут ВДНХ", nil},
    [2] = {"Рядовой ВДНХ", nil},
    [3] = {"Ефрейтор ВДНХ", nil, nil},
    [4] = {"Капрал ВДНХ", "icon16/medal_bronze_1.png", nil},
    [5] = {"Мл.Охранник ВДНХ", "icon16/medal_bronze_1.png", nil},
    [6] = {"Постовой ВДНХ", "icon16/medal_silver_1.png", nil},
    [7] = {"Нач.Охраны ВДНХ", "icon16/medal_gold_1.png", nil, true}
    [8] = {"Нач.Станции ВДНХ", "icon16/medal_gold_1.png", nil, true}
}


FACTION.Ranks = {
    [1] = {"Штурмманн", nil, nil},
    [2] = {"Роттенфюрер",nil, nil},
    [3] = {"Шарфюрер", nil, nil},
    [4] = {"Обершарфюрер", "icon16/medal_silver_1.png", nil},
    [5] = {"Штурмшарфюрер", "icon16/medal_silver_1.png", nil},
    [6] = {"Унтерштурмфюрер", "icon16/medal_silver_1.png", nil, true},
    [7] = {"Гауптштурмфюрер", "icon16/medal_gold_1.png", nil, true},
    [8] = {"Штурмбанфюрер", "icon16/medal_gold_1.png", nil, true},
    [9] = {"Штандартенфюрер", "icon16/medal_gold_1.png", nil, true}
}


FACTION.Ranks = {
    [1] = {"Петух", nil, CLASS_BANDITS},
    [2] = {"Шнырь", nil, CLASS_BANDITS},
    [3] = {"Форшмак", nil, nil},
    [4] = {"Козел", "icon16/medal_silver_1.png", nil},
	[5] = {"Мужик", "icon16/medal_silver_1.png", nil},
    [6] = {"Блатной", "icon16/medal_silver_1.png", nil, true},
    [7] = {"Смотрящий", "icon16/medal_gold_1.png", nil, true},
	[8] = {"Пахан", "icon16/medal_gold_1.png", nil, true}
}
-----------------------------------------------------------]]

ix.char.RegisterVar("rank", { 
    field = "rank",
    fieldType = ix.type.number,
    default = 1
})

ix.command.Add("CharRank", {
    arguments = {
        ix.type.player,
        ix.type.number
    },
    description = "@cmdCharSetRank",
    adminOnly = true,
    OnRun = function(self, client, target, rank)
        local factionTable = ix.faction.Get(target:Team())
        local rankTable = factionTable.Ranks
        local character = target:GetCharacter()

        if not rankTable or not rankTable[rank] or not isnumber(rank) or (rank > #rankTable) then return client:NotifyLocalized("undefinedRank") end

        if rankTable[rank][3] then
            local class = ix.class.list[rankTable[rank][3]]
            character:SetClass(class.index)
        end

        character:SetRank(rank)
        client:NotifyLocalized("characterRaiseAdmin", target:Name(), rankTable[rank][1])
        target:NotifyLocalized("characterRaiseNotify", rankTable[rank][1])
    end
})

ix.command.Add("FactionRaise", {
    arguments = {
        ix.type.player,
        ix.type.number
    },
    description = "@cmdCharRaise",
    OnRun = function(self, client, target, rank)
        local factionTable = ix.faction.Get(target:Team())
        local rankTable = factionTable.Ranks
        local character = target:GetCharacter()

        if (client:SteamID() == target:SteamID()) then return client:NotifyLocalized("cannotAllowRaiseYourself") end
        if not rankTable or not rankTable[rank] or not isnumber(rank) or (rank > #rankTable) then return client:NotifyLocalized("undefinedRank") end
        if (client:Team() ~= target:Team()) or !rankTable[client:GetCharacter():GetRank()][4] or (rank >= client:GetCharacter():GetRank()) then return client:NotifyLocalized("cannotAllowRaise") end

        if rankTable[rank][3] then
            local class = ix.class.list[rankTable[rank][3]]
            character:SetClass(class.index)
        end

        character:SetRank(rank)
        client:NotifyLocalized("characterRaisePlayer", target:Name(), rankTable[rank][1])
        target:NotifyLocalized("characterRaiseNotify", rankTable[rank][1])
    end
})

ix.command.Add("FactionInvite", {
	description = "Добавить во фракцию",
	arguments = {
		ix.type.character
	},
	OnRun = function(self, client, target)

	local OwnFaction = client:Team()
	local name = target:GetName()
	
	local factionTable = ix.faction.Get(client:Team())
    local rankTable = factionTable.Ranks
    --local character = target:GetCharacter()

	---if (self:SteamID() == target:SteamID()) then return client:NotifyLocalized("cannotAllowRaiseYourself") end
   -- if (!rankTable[rank][4]) then return client:Notify("У вас нет прав.") end
		if (target:GetPlayer():Team() == FACTION_NOV) and (rankTable[client:GetCharacter():GetRank()][4]) then
			target:SetFaction(OwnFaction)
			target:SetRank(1)
			client:Notify("Вы зачислили "..target:GetName().." в своё подразделение...")
		else
			return "Ваше звание не позволяет это сделать или игрок находится в другом подразделении..."
		end

	end
})

ix.command.Add("FactionKick", {
	description = "Исключить во фракцию",
	arguments = {
		ix.type.character
	},
	OnRun = function(self, client, target)

	local OwnFaction = client:Team()
	local name = target:GetName()
	local factionTable = ix.faction.Get(client:Team())
    local rankTable = factionTable.Ranks

	
		if (target:GetPlayer():Team() == client:Team()) and (rankTable[client:GetCharacter():GetRank()][4]) then
			target:SetFaction(FACTION_NOV)
			client:Notify("Вы исключили "..target:GetName().." из своего подразделения...")
		else
			return "Ваше звание не позволяет это сделать или игрок находится в другом подразделении..."
		end
	--[[else
		return "Вы не являетесь командиром..."
	end]]

	end
})