ENT.Base 			= "npc_vj_creature_base" -- List of all base types: https://github.com/DrVrej/VJ-Base/wiki/Base-Types
ENT.Type 			= "ai"
ENT.PrintName 		= "Носач-Мамка"
ENT.Author 			= ""
ENT.Contact 		= ""
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Metro"

if (CLIENT) then
	local Name = "Носач-Мамка"
	local LangName = "npc_vj_nosalis_mom"
	language.Add(LangName, Name)
	killicon.Add(LangName,"hud/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"hud/killicons/default",Color(255,80,0,255))
end