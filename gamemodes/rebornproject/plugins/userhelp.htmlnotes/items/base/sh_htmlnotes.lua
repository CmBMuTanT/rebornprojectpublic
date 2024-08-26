
ITEM.name = "Пошел нахуй HTML.com"
ITEM.description = "Книга нахуй ок"
ITEM.category = "[HTML-NOTES]"
ITEM.model = Model("models/props_lab/bindergraylabel01b.mdl")
ITEM.contents = ""
local BOOK_HTML = [[
<html>
	<body style="background-color: #ECECEC; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">
		%s
	</body>
</html>
]]

ITEM.functions.Read = {
	OnClick = function(itemTable)
		local frame = vgui.Create("DFrame")
		frame:SetSize(ScrW()*.5, ScrH()*.9)
		frame:SetTitle(itemTable.name)
		frame:MakePopup()
		frame:Center()

		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		frame.html:SetHTML(string.format(BOOK_HTML, itemTable.contents))
	end,
	OnRun = function(itemTable)
		return false
	end,
	name = "Прочитать",
	icon = "icon16/book_open.png"
}
