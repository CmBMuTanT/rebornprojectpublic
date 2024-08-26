local PLUGIN = PLUGIN

PLUGIN.name = "Fake Names"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[
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

local character = ix.meta.character

function character:DoesRecognize(id)
	if (!isnumber(id) and id.GetID) then
		id = id:GetID()
	end
	return hook.Run("IsCharacterRecognized", self, id)
end
local PerviousRecognize = function(char,id)
	if (char.id == id) then
		return true
	end

	local other = ix.char.loaded[id]

	if (other) then
		local faction = ix.faction.indices[other:GetFaction()]

		if (faction and faction.isGloballyRecognized) then
			return true
		end
	end

	local recognized = char:GetData("rgn", "")

	if (recognized != "" and recognized:find(","..id..",")) then
		return true
	end
end
function PLUGIN:IsCharacterRecognized(char, id) -- char кто знает, id кого знает
	if PerviousRecognize(char,id) then
		return true
	end

	local fakenames = char:GetData("fkname_KnowFakeNames",{})
	if fakenames[id] then
		return true
	end
end
function debug.dumptotable()
	local level = 1
	local tbl = {}
	while true do
		local info = debug.getinfo(level,"Sln")
		if !info or !info.name then break end

		tbl[info.name] = true

		level = level + 1
	end
	return tbl
end
local CharMeta = ix.meta.character
ix.meta.character.OriginalGetName = ix.meta.character.GetName

function ix.meta.character:GetName()
	local tbl = debug.dumptotable()
	tbl = (tbl.Name or tbl.Nick) and true
	if CLIENT and !tbl then
		local char = LocalPlayer():GetCharacter()
		if !char then
			return self:OriginalGetName()
		end
		if PerviousRecognize(char,self:GetID()) then
			return self:OriginalGetName()
		end

		local fakenames = char:GetData("fkname_KnowFakeNames",{})
		local fakename = fakenames[self:GetID()]

		return fakename or self:OriginalGetName()
	end
	return self:OriginalGetName()
end

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")