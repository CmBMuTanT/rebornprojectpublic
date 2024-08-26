local PLUGIN = PLUGIN



function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
    local rank = character:GetRank()
    local factionTable = ix.faction.Get(client:Team())

    if (rank) and factionTable and factionTable.Ranks and factionTable.Ranks[rank] then
        if LocalPlayer():Team() == client:Team() then
            local rowRank = tooltip:AddRowAfter("name", "rank")
            rowRank:SetBackgroundColor(team.GetColor(client:Team()), rowRank)
            rowRank:SetText(factionTable.Ranks[rank][1])
            rowRank:SizeToContents()

            if factionTable.Ranks[rank][2] then
                local x, y = rowRank:GetTextSize()
                icon = rowRank:Add( "DImageButton")
                icon:SetPos(x + 8, y - 22.5)
                icon:SetImage(factionTable.Ranks[rank][2])
                icon:SetSize(32,32)
            end
        end
    end
end
