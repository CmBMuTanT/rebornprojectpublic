ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Amoeba"
ENT.Author 			= "Comrade Communist"
ENT.Contact 		= "https://steamcommunity.com/id/6601216/"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "METRO"

if (CLIENT) then
local Name = "Amoeba"
local LangName = "vj_mutant_ameba"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end