PLUGIN.name = "Ограничения Персонажей"
PLUGIN.description = "Установит лимит персонажей в зависимости от ранга игрока."
PLUGIN.author = "Azrael"

local overrideCharLimit = {
  ["superadmin"] = 10,
  ["admin"] = 2,
  ["stager"] = 2,  
  ["twochar"] = 2,
  ["user"] = 1,
}


hook.Add("GetMaxPlayerCharacter", "returnRankCharLimit", function(ply)
    local rank = ply:GetNWString("usergroup", nil)
    local defchars = ix.config.Get("maxCharacters", 5)

    if not rank then return defchars end
  for group,slots in pairs(overrideCharLimit) do
    if rank == group then
      return slots
    end
  end

  return defchars
end)