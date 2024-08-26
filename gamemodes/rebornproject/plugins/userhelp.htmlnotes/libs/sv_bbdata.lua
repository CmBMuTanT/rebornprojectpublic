local PLUGIN = PLUGIN
PLUGIN.bureaucracy = {}
local data = PLUGIN.bureaucracy.PaperData or {}
PLUGIN.bureaucracy.PaperData = data

PLUGIN.bureaucracy.BBCodes =
{
	["[b]"] =
	{
		replace = "<b>",
		check = function() return true end,
	},

	["[/b]"] =
	{
		replace = "</b>",
		check = function() return true end,
	},

	["[i]"] =
	{
		replace = "<i>",
		check = function() return true end,
	},

	["[/i]"] =
	{
		replace = "</i>",
		check = function() return true end,
	},

	["[u]"] =
	{
		replace = "<u>",
		check = function() return true end,
	},

	["[/u]"] =
	{
		replace = "</u>",
		check = function() return true end,
	},

	["[large]"] =
	{
		replace = "<span class=\"large\">",
		check = function() return true end,
	},

	["[/large]"] =
	{
		replace = "</span>",
		check = function() return true end,
	},

	["[small]"] =
	{
		replace = "<span class=\"small\">",
		check = function() return true end,
	},

	["[/small]"] =
	{
		replace = "</span>",
		check = function() return true end,
	},

	["[big]"] = 
	{
		replace = "<span class=\"big\">",
		check = function() return true end,
	},

	["[/big]"] =
	{
		replace = "</span>",
		check = function() return true end,
	},

	["[center]"] =
	{
		replace = "<span class=\"center\">",
		check = function() return true end,
	},

	["[/center]"] =
	{
		replace = "</span>",
		check = function() return true end,
	},

	["[list]"] =
	{
		replace = "<ul type=\"square\">",
		check = function() return true end,
	},

	["[/list]"] =
	{
		replace = "</ul>",
		check = function() return true end,
	},

	["[*]"] =
	{
		replace = "<li>",
		check = function() return true end,
	},

	["[hr]"] =
	{
		replace = "<hr>",
		check = function() return true end,
	},

	["[br]"] =
	{
		replace = "<br>",
		check = function() return true end,
	},

	["[blue]"] =
	{
		replace = "<span class=\"blue\">",
		check = function() return true end,
	},

	["[/blue]"] =
	{
		replace = "</span>",
		check = function() return true end,
	},

	["[red]"] =
	{
		replace = "<span class=\"red\">",
		check = function() return true end,
	},

	["[/red]"] =
	{
		replace = "</span>",
		check = function() return true end,
	},

	["[green]"] =
	{
		replace = "<span class=\"green\">",
		check = function() return true end,
	},

	["[/green]"] =
	{
		replace = "</span>",
		check = function() return true end,
	},

	["[img]"] =
	{
		replace = "<img src=\"",
		check = function() return true end,
	},
	["[/img]"] =
	{
		replace = "\" alt=\"1\"/>",
		check = function() return true end,
	},
}

function PLUGIN.bureaucracy:bb_StringToHTML_P(PaperData)
	if !PaperData.Text then return end

	local lines = string.Explode(string.char(10), PaperData.Text)
	text = string.Replace(PaperData.Text, string.char(10), "")

	local final_text = ""
	for k, v in pairs(lines) do
		for bbcode, tbl in pairs(PLUGIN.bureaucracy.BBCodes) do
			if string.find(v, bbcode) then
				if tbl.check( PaperData ) then
					local replace = (type(tbl.replace) == "function") and tbl.replace( PaperData ) or tbl.replace
					v = string.Replace(v, bbcode, tbl.replace)
				else
					v = string.Replace(v, bbcode, "")
				end
			end
		end

		local addBR = "<br>"
		if v == "<br>" then
			addBR = ""
		elseif v == "<hr>" then
			addBR = ""
		end

		final_text = final_text .. v .. addBR
	end

	return final_text
end

function PLUGIN.bureaucracy:bb_CanPlayerEdit(itemID, client)
	local item = ix.item:FindInstance(itemID)

	if (item) then
		if PLUGIN.bureaucracy:bb_HasFields(item) then
			for k, v in pairs(player.GetAll()) do
				if v == client then continue end
				if v.bb_writing_itemid == itemID then
					return false
				end
			end
		end

		return true
	end	
end

function PLUGIN.bureaucracy:bb_SendPaper(item, client)
	if !item then return end
	if !IsValid(client) then return end
	if client.bb_writing_itemid != item.id then return end

	local paperObject = item.PaperObjectData or item:GetData("PaperObjectData")
	--PrintTable(paperObject)
	if paperObject then
		local formattedText = PLUGIN.bureaucracy:bb_StringToHTML_P( paperObject )
		if formattedText then
			netstream.Start(client, "bb_OpenEditEditor")
			netstream.Start(client, "bb_LoadEditData", formattedText, item:GetData("PaperTitle"))
		end
	end
end

function PLUGIN.bureaucracy:bb_HasFields(item)
	if item.PaperObjectData then
		local originalText = item.PaperObjectData.Text
		local pattern = "<span class%=%ptextarea%p contenteditable><%/span>"

		local i = 0
		for field in string.gmatch(originalText, pattern) do
			i = i + 1
		end

		return (i > 0)
	end
end

netstream.Hook("bb_SendWrite", function(client, data, title, pickup)
	if !client.bb_writing_itemid then return end
	local item = ix.item:FindInstance(client.bb_writing_itemid)
	if !item then return end
	if !item:GetData("CanWrite") then return end
	if !PLUGIN.bureaucracy:bb_CanPlayerEdit(client.bb_writing_itemid, client) then return end

	item:SetData("CanWrite", false)
	item:SetData("CanPickup", !pickup)
	item:SetData("PaperTitle", title)


	data = string.gsub(data,"<.->(.-)</.->","%1")
	data = string.utf8sub(data, 1, MAX_PAPER_CHARACTERS)
	data = string.Replace(data,"[sign]","<span class=\"sign\">"..client:GetName().."</span>")
	data = string.Replace(data,"[field]","<span class=\"textarea\" contenteditable></span>")

	local PaperObjectData = {}
	PaperObjectData.ItemID = client.bb_writing_itemid
	PaperObjectData.Writer = client:SteamID()
	PaperObjectData.Text = data

	item.PaperObjectData = PaperObjectData
	item:SetData("PaperObjectData", PaperObjectData)
	client.bb_writing_itemid = nil
end)

netstream.Hook("bb_SendEdit", function(client, data)
	if !client.bb_writing_itemid then return end
	local item = ix.item:FindInstance(client.bb_writing_itemid)

	if !item then return end

	if item:GetData("CanWrite") then return end
	--if item:GetData("PaperID") == 0 then return end
	if !PLUGIN.bureaucracy:bb_CanPlayerEdit(client.bb_writing_itemid, client) then return end

	local fields = data
	local formatted_fields = {}
	local originalfields = {}
	local originalText = item.PaperObjectData.Text
	local modifiedText = originalText
	local pattern = "<span class%=%ptextarea%p contenteditable><%/span>"

	local i = 1
	for field in string.gmatch(originalText, pattern) do
		local replacement = "[field]"
		local field_text = fields[i]
		--print(field_text,i,field)
		if field_text and #field_text != 0 and !string.match(field_text,"^s*$") then
			field_text = string.gsub(field_text,"<.->(.-)</.->","%1")
			field_text = string.utf8sub(field_text, 1, MAX_PAPER_CHARACTERS)
			field_text = string.Replace(field_text,"[sign]","<span class=\"sign\">"..client:GetName().."</span>")
			field_text = string.Replace(field_text,"[field]","<span class=\"textarea\" contenteditable></span>")
			replacement = "[u]"..field_text.."[/u]"
		end
		
		modifiedText = string.gsub(modifiedText, pattern, replacement, 1)
		i = i + 1
	end
	modifiedText = string.Replace(modifiedText,"[field]","<span class=\"textarea\" contenteditable></span>")

	item.PaperObjectData.Text = modifiedText
	client.bb_writing_itemid = nil
end)

netstream.Hook("bb_Closed", function(client, data)
	if !client.bb_writing_itemid then return end
	client.bb_writing_itemid = nil
end)