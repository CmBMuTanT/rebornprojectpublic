PLUGIN.name = "Q Menu Invisibility"
PLUGIN.author = "AngryBaldMan"
PLUGIN.desc = "Hids the q menu if you do not have pet flags."

hook.Add( "SpawnMenuOpen", "FlagCheckPET", function()
   if not LocalPlayer():GetCharacter():HasFlags("pet") then
       return false
   end
end )