local PLUGIN = PLUGIN
MAX_PAPER_CHARACTERS = 20000

local PANEL = {}
PANEL.TextHTML =
[[
	<html content="text/html; charset=UTF-8">
	<head>
	<style type="text/css">
		html {
			margin: 0;
			padding: 0;
			background-color: rgba(0,0,0,0.01);
		}
		body {
			margin: 0;
			padding: 0;
		}
		
		::-webkit-scrollbar {
			width: 10px;
		}
		::-webkit-scrollbar-thumb {
			background-color: #3E65A0;
		}
		::-webkit-scrollbar-thumb:active {
			background-color: #4A78BF;
		}
	</style>
	</head>
	<textarea id="textentry"; style="overflow-y: scroll; height: 100%; width: 100%; resize: none; font-size: 87%; font-family: sans-serif;" maxlength = ]]..MAX_PAPER_CHARACTERS..[[;></textarea>
	<script>
		function SetText( text ) {
			document.getElementById("textentry").value = text;
		};
		function GetText() {
			if ("gmodinterface" in window) {
				gmodinterface._GetText(document.getElementById("textentry").value);
			}
		};
		function GetSelectedText() {
			if ("gmodinterface" in window) {
				var text = "";
				var textentry = document.getElementById("textentry");
				text = textentry.value.substring(textentry.selectionStart, textentry.selectionEnd);
				gmodinterface._GetSelectedText(text);
			}
		};
		function SetReadOnly( bool ) {
			if (bool) {
				document.getElementById("textentry").setAttribute("readonly",true);
			} else {
				document.getElementById("textentry").removeAttribute("readonly");
			}
		};
		function GetReadOnly() {
			if ("gmodinterface" in window) {
				gmodinterface._GetReadOnly(document.getElementById("textentry").getAttribute("readonly"));
			}
		};
		function escapeRegExp(str) {
    		return str.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
		}
		function InsertCode( format ) {
			var textentry = document.getElementById("textentry");
			var len = textentry.value.length;
		    var start = textentry.selectionStart;
			var end = textentry.selectionEnd;
			var selectedText = textentry.value.substring(start, end);
			var replacement = selectedText.replace(new RegExp(escapeRegExp(selectedText), 'g'), format);

			textentry.value = textentry.value.substring(0, start) + replacement + textentry.value.substring(end, len);
		};
	</script>
	<body>
	</html>
]]

function PANEL:Init()
	self.Text = ""
	self.ReadOnly = nil
	self:InitSecond()
	hook.Add("ShutDown", self, function() if not ValidPanel(self) or not self.HTML then return end end)
end

function PANEL:InitSecond()
	local HTML = vgui.Create( "DHTML", self )
	self.HTML = HTML
	self.HTML:Dock( FILL )
	self:InvalidateLayout()
	self.HTML:InvalidateLayout(true)
	self.HTML:SetHTML( self.TextHTML )
	self.HTML:RequestFocus()
	self.HTML.Paint = function(s, w, h) end

	self.HTML:AddFunction("gmodinterface", "_GetText", function( text )
		self.Text = text
	end)

	self.HTML:AddFunction("gmodinterface", "_GetReadOnly", function( bool )
		self.ReadOnly = bool
	end)

	self.HTML:AddFunction("gmodinterface", "_GetSelectedText", function( text )
		self.SelectedText = text
	end)
end

function PANEL:Paint()
	if IsValid(self.HTML) then return end

	self:InitSecond()
end

function PANEL:InsertCode(format)
	self.HTML:Call("InsertCode(\""..format.."\")")
end

function PANEL:GetSelectedText()
	self.HTML:Call("GetSelectedText()")
	return self.SelectedText
end

function PANEL:GetReadOnly()
	self.HTML:Call("GetReadOnly()")

	return self.ReadOnly
end

function PANEL:SetReadOnly( bool )
	self.HTML:Call("SetReadOnly("..tostring(bool)..")")

	self.ReadOnly = bool
end

function PANEL:GetText()
	self.HTML:Call("GetText()")

	return self.Text
end

function PANEL:SetText( text )
	self.HTML:Call("SetText(\""..text.."\")")

	self.Text = text
end
vgui.Register("HTextEntry", PANEL, "EditablePanel")

PANEL = {}
function PANEL:Init()
	-- local w = math.max( ScrW() / 4, 450 )
	-- local h = math.max( ScrH() / 2, 600 )
		
	self:SetSize(ScrW()*.4, ScrH()*.9)	
	self:MakePopup()
	self:Center()
	self:SetTitle("Лист бумаги")

	self.controls = self:Add("DPanel")
	self.controls:Dock(BOTTOM)
	self.controls:SetTall(30)
	self.controls:DockMargin(0, 0, 0, 0)

	self.titletext = self:Add("DTextEntry")
	self.titletext:SetValue("Безымянный")
	self.titletext:Dock(TOP)

	self.content = self:Add("DLabel")
	self.content:SetText("Содержимое:")
	self.content:Dock(TOP)

	self.contents = self:Add("HTextEntry")
	self.contents:DockMargin(0, 0, 0, 4)
	self.contents:Dock(TOP)
	self.contents:SetTall(self:GetTall() * .85)

	self.editbuttonsframe = self:Add("DPanel")
	self.editbuttonsframe:Dock(TOP)
	self.editbuttonsframe:SetTall(self:GetTall()*.035)
	self.editbuttonsframe.Paint = function(this,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(20,20,20))
	end

	for k,v in ipairs(PLUGIN.EditCodes) do
		self.editbuttons = self.editbuttonsframe:Add("DButton")
		self.editbuttons:Dock(LEFT)
		self.editbuttons:SetText(v.id)
		self.editbuttons:SetTooltip(v.hint)
		local x, y = surface.GetTextSize(v.id)
		self.editbuttons:SetWide(x - 7)

		self.editbuttons.DoClick = function(s)
			self.contents:InsertCode(v.format)
		end
	end

	self.confirm = self.controls:Add("DButton")
	self.confirm:Dock(RIGHT)
	self.confirm:SetDisabled(true)
	self.confirm:SetText("Готово")
	
	self.controls.Paint = function(this, w, h)
		local text = self.contents:GetText()
		draw.SimpleText(Format("Размер: %s/"..MAX_PAPER_CHARACTERS, string.utf8len(text)), "DermaDefault", 1, h/2 + 8, color_white, TEXT_ALIGN_LEFT, 1)
	end

	self.confirm.DoClick = function(this)
		local text = self.contents:GetText()
		netstream.Start( "bb_SendWrite", text, self.titletext:GetValue(), self.canpickup:GetChecked() )
		self:Close()
	end

	self.canpickup = self.controls:Add("DCheckBoxLabel")
	self.canpickup:SetText("Нельзя взять в инвентарь")
	self.canpickup:Dock(TOP)
end

function PANEL:allowEdit(bool)
	if (bool == true) then
		self.contents:SetReadOnly(false)
		self.confirm:SetDisabled(false)
	else
		self.contents:SetReadOnly(true)
		self.confirm:SetDisabled(true)
	end
end

function PANEL:setText(text)
	self.contents:SetText(text)
end

function PANEL:OnClose()
	netstream.Start("bb_Closed", {})
end
vgui.Register("BB_NoteWrite", PANEL, "DFrame")

local function DOMToTable(xml)
	local h = gxml.domHandler()
	local x = gxml.xmlParser(h)
	x:parse(xml)

	return h.root
end

PANEL = {}
function PANEL:Init()
	-- local w = math.max( ScrW() / 4, 480 ) + 10
	-- local h = math.max( ScrH() / 2, 580 ) + 10
		
	self:SetSize(ScrW()*.4, ScrH()*.9)	
	self:MakePopup()
	self:Center()
	self:SetTitle("Лист бумаги")

	self.controls = self:Add("DPanel")
	self.controls:Dock(BOTTOM)
	self.controls:SetTall(30)
	self.controls:DockMargin(0, 5, 0, 0)

	local HTML = self:Add("DHTML")
	HTML.Paint = function(s, w, h) end

	self.contents = HTML
	self.contents:Dock(FILL)
	self.contents:InvalidateLayout(true)
	self.contents:RequestFocus()
	self.contents:AddFunction("gmodinterface", "_GetHTMLEntry", function(html)
		local htmlcode = html
		htmlcode = string.Replace(htmlcode,"<br>","<br></br>")
		htmlcode = string.Replace(htmlcode,"<hr>","<hr></hr>")
		local htmltable = DOMToTable(htmlcode)
		local fields = {}

		local function processFields(tbl)
			if tbl["n"] then
				tbl["n"] = nil 
			end

			if !tbl[1] then
				tbl[1] = { ["_text"] = "" }
			end

			for k, v in pairs(tbl) do
				if type(v) == "table" and k != "_parent" then
					table.insert(fields, v["_text"])
				end
			end
		end
		local function processHTML(tbl)
			for k, v in pairs(tbl) do
				if type(v) == "table" and k != "_parent" then
					processHTML(v)
				end
			end

			if tbl["_name"] == "span" then
				if tbl["_attr"] then 
					if tbl["_attr"]["class"] == "textarea" then
						processFields(tbl["_children"])
					end
				end
			end
		end
		processHTML(htmltable)

		netstream.Start("bb_SendEdit", fields)
		self:Close()
	end)
	
	self.confirm = self.controls:Add("DButton")
	self.confirm:Dock(RIGHT)
	self.confirm:SetDisabled(false)
	self.confirm:SetText("Готово")
	self.confirm.DoClick = function(this)
		self.contents:Call("gmodinterface._GetHTMLEntry(document.getElementById('entry').innerHTML);")
	end
end

function PANEL:Load(data)
	self.contents:SetHTML(
	[[<!DOCTYPE html>
	<html content="text/html; charset=UTF-8">
	<head>
	<style type="text/css">
		html {
			margin: 0;
			padding: 0;
			background-color: #FFF;
		}
		body {
			margin: 0;
			padding: 0;
			font-family: sans-serif;
		}
		span {
			display: inline-block;
			text-align: left;
		}
		div {
			display: inline-block;
		}
		div.content {
			display: block;
			width: calc(100% - 20px);
			height: 100%;
			font-size: 12px;
			text-align: left;
			margin: 20px 20px 20px 20px;
			word-break: break-all;
		}
		.big {
			font-size: 16px;
		}
		.small {
			font-size: 10px;
		}
		.center {
			width: 100%;
			text-align: center;
		}
		.large {
			font-size: 20px;
		}
		.red {
			color: rgb(255,40,40);
		}
		.green {
			color: rgb(40,255,40);
		}
		.blue {
			color: rgb(40,40,255);
		}
		.sign {
			font-style: italic;
			font-size: 90%;
			font-family: "Trebuchet MS", monospace;
		}
		.textarea {
			display: inline-block;
			font-size: 12px;
			word-break: break-all;
			min-width: 32px;
			min-height: 100%;
			vertical-align:top;
			text-decoration: underline;
		}
	</style>
	</head>
	<div id="entry" class="content">
	]]..data..[[
	</div>
	<body>
	</html>
	]])
end

function PANEL:OnClose()
	netstream.Start("bb_Closed", {})
end
vgui.Register("BB_NoteEdit", PANEL, "DFrame")

netstream.Hook("bb_OpenWriteEditor", function(data)
	if BB_WRITE_EDITOR then BB_WRITE_EDITOR:Remove() BB_WRITE_EDITOR = nil end

	BB_WRITE_EDITOR = vgui.Create("BB_NoteWrite")
	BB_WRITE_EDITOR:allowEdit(true)
end)

netstream.Hook("bb_OpenEditEditor", function()
	if BB_EDIT_EDITOR then BB_EDIT_EDITOR:Remove() BB_EDIT_EDITOR = nil end

	BB_EDIT_EDITOR = vgui.Create("BB_NoteEdit")
	BB_EDIT_EDITOR:Load("LOADING DATA...<br>PLEASE WAIT!")
	BB_EDIT_EDITOR.confirm:SetDisabled(true)
end)

netstream.Hook("bb_LoadEditData", function(data, title)
	if BB_EDIT_EDITOR then
		BB_EDIT_EDITOR:Load(data)
		BB_EDIT_EDITOR.confirm:SetDisabled(false)
		BB_EDIT_EDITOR:SetTitle(title)
	end
end)