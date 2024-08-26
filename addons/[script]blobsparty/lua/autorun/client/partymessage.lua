--GUI base created by billy
--https://scriptfodder.com/users/view/76561198040894045/scripts

function Party_Message(strText,strTitle,strButtonText)

	local Window = vgui.Create("PartyFrame")
	Window:SetTitle(strTitle or "Message")
	Window:SetDraggable(false)
	Window:SetBackgroundBlur(true)
	Window:SetDrawOnTop(true)

	local InnerPanel = vgui.Create("Panel",Window)

	local Text = vgui.Create("DLabel",InnerPanel)
	Text:SetFont("roboto16")
	Text:SetText(strText or "Message Text")
	Text:SizeToContents()
	Text:SetContentAlignment(5)
	Text:SetTextColor(Color(0,0,0))

	local ButtonPanel = vgui.Create("DPanel",Window)
	ButtonPanel:SetTall(30)
	ButtonPanel:SetDrawBackground(false)

	local Button = vgui.Create("PartyButton",ButtonPanel)
	Button:SetText(strButtonText or "OK")
	Button:SizeToContents()
	Button:SetTall(20)
	Button:SetWide(Button:GetWide() + 20)
	Button:SetPos(5,5)
	Button.DoClick = function() Window:Close() end

	ButtonPanel:SetWide(Button:GetWide() + 10)

	local w,h = Text:GetSize()

	Window:SetSize(w + 50,h + 25 + 45 + 10)

	InnerPanel:StretchToParent(5,25,5,45)

	Text:StretchToParent(5,5,5,5)	

	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom(8)

	Window:MakePopup()
	Window:DoModal()

	Window:Center()
	Window:Configured()
	Window:ShowCloseButton(false)

	return Window

end