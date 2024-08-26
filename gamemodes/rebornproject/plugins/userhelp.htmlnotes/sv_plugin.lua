local PLUGIN = PLUGIN

function PLUGIN:SaveData()
    local notedata = {}

    for _, v in ipairs(ents.FindByClass("ix_item")) do
        if (v.ixItemID) then
            local itemtbl = ix.item.instances[v.ixItemID]
            if itemtbl.uniqueID != "note" then continue end
    
            local itemPaper = itemtbl.PaperObjectData
            
            if itemPaper then
                notedata[#notedata + 1] = {
                    itemID = itemPaper.ItemID,
                    writer = itemPaper.Writer,
                    text = itemPaper.Text
                }
            end       
        end
    end
    ix.data.Set("cmbmtkhtmlnotes", notedata)
end

function PLUGIN:LoadData()
    for _, v in ipairs(ix.data.Get("cmbmtkhtmlnotes") or {}) do
        local noteid = ix.item.instances[v.itemID]
    
        noteid.PaperObjectData = {
            ItemID = v.itemID,
            Text = v.text,
            Writer = v.writer,
        }
    end
end