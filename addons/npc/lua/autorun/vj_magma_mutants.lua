/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Metro Mutants Redux"
local AddonName = "Metro Mutants Redux"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_magma_mutants.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "METRO" -- Category, you can also set a category individually by replacing the vCat with a string value
	
	VJ.AddNPC("Носач","npc_vj_nosalis",vCat) -- Adds a NPC to the spawnmenu
	VJ.AddNPC("Бомаса","vj_mutant_biomasa",vCat) -- Adds a NPC to the spawnmenu
	VJ.AddNPC("Кикимора","npc_vj_lurker",vCat) -- Adds a NPC to the spawnmenu
	VJ.AddNPC("Страж","npc_vj_watcher",vCat) -- Adds a NPC to the spawnmenu
	VJ.AddNPC("Скорпион","npc_vj_arachnid",vCat) -- Adds a NPC to the spawnmenu
	VJ.AddNPC("Паук","npc_vj_arachind_2",vCat) -- Adds a NPC to the spawnmenu
	VJ.AddNPC("Медведь","npc_vj_med",vCat) 
	VJ.AddNPC("Медведь тип2","vj_mutant_bear2",vCat) 
	VJ.AddNPC("Носач Мамка","npc_vj_nosalis_mom",vCat) -- Adds a NPC to the spawnmenu
	VJ.AddNPC("Пес","npc_vj_pes",vCat)-- Adds a NPC to the spawnmenu
	VJ.AddNPC("Мимик","vj_mutant_mimikria",vCat)-- Adds a NPC to the spawnmenu
	VJ.AddNPC("Амеба","vj_mutant_ameba",vCat)-- Adds a NPC to the spawnmenu
	


-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end