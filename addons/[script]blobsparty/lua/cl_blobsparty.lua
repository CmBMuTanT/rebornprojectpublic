
surface.CreateFont( "blobsPartyFont", {
	font = "roboto", 
	size = 20, 
	weight = 0, 
} )
surface.CreateFont( "blobsPartyFontSmall", {
	font = "roboto", 
	size = 14, 
	weight = 0, 
} )

local PartyListMaterial = Material("icon16/page_white.png")
local CreatePartyMaterial = Material("icon16/pencil.png")
local PartySettingsMaterial = Material("icon16/cog.png")
local PartyDetailsMaterial = Material("icon16/application_form.png")
local PartyMembersMaterial = Material("icon16/group.png")
local PartyCircleMaterial = Material("sgm/playercircle")

MyBlobsParty = MyBlobsParty or {}
MyBlobsParty.members = {}

net.Receive("blobsParty:OpenPartyMenu", function()
	local NoMoveTo = false
	if IsValid(blobsPartyMenu) then
		NoMoveTo = true
		blobsPartyMenu:Remove()
	end
	
	local blW, blH = 450,500
	blobsPartyMenu = vgui.Create("DFrame")
	blobsPartyMenu:SetTitle("")
	blobsPartyMenu:ShowCloseButton(false)
	blobsPartyMenu.CurrentCategory = BlobsPartyConfig.PartyList
	blobsPartyMenu:SetDraggable(false)
	blobsPartyMenu:SetSize(blW, blH)
	if NoMoveTo then
		blobsPartyMenu:Center()
	else
		blobsPartyMenu:SetPos(ScrW() + blW, (ScrH()/2) - (blH/2))
	end
	blobsPartyMenu:MakePopup()
	if not NoMoveTo then
		blobsPartyMenu:MoveTo((ScrW()/2) - (blW / 2), (ScrH()/2) - (blH / 2), 0.5, 0, 1, function() gui.EnableScreenClicker(true) end)
	end
	blobsPartyMenu.Paint = function(self,w,h)
		surface.SetDrawColor(BlobsPartyConfig.FirstColor)
		surface.DrawRect(0,0,w,h)
		draw.SimpleTextOutlined(BlobsPartyConfig.PartyMenu.." - "..blobsPartyMenu.CurrentCategory, "blobsPartyFont", 60, 25, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	
		surface.SetDrawColor(BlobsPartyConfig.SecondColor)
		surface.DrawRect(0,0,50,h)
	end
	
	blobsPartyMenu.PaintOver = function(self,w,h)
		surface.SetDrawColor(0,0,0)
		surface.DrawOutlinedRect(50,0,1,h)
	end
	
	local blobsPartyMenuAvatar = vgui.Create( "AvatarImage", blobsPartyMenu)
	blobsPartyMenuAvatar:SetPos( 0, 0 )
	blobsPartyMenuAvatar:SetSize( 50, 50 )
	blobsPartyMenuAvatar:SetPlayer( LocalPlayer(), 50 )
	
	blobsPartyContentArea = vgui.Create("DPanel", blobsPartyMenu)
	blobsPartyContentArea:SetPos(50, 50)
	blobsPartyContentArea:SetSize(blobsPartyMenu:GetWide()-50, blobsPartyMenu:GetTall()-50)
	blobsPartyContentArea.Paint = function(self,w,h)
		surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
		surface.DrawRect(0,0,w,h)
	end
	
	local blobsPartyMenuClose = vgui.Create("DButton", blobsPartyMenu)
	blobsPartyMenuClose:SetSize(25,25)
	blobsPartyMenuClose:SetPos(blobsPartyMenu:GetWide() - 25,0)
	blobsPartyMenuClose:SetText("")
	local blobsPartyCloseButtonColour = Color(255,255,255)
	
	blobsPartyMenuClose.Paint = function(self,w,h)
		if self:IsHovered() then
			blobsPartyCloseButtonColour = Color(100,100,100)
		else
			blobsPartyCloseButtonColour = Color(255,255,255)
		end
		draw.SimpleTextOutlined("X", "blobsPartyFont", w/2, h/2, blobsPartyCloseButtonColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	end
	
	blobsPartyMenuClose.DoClick = function()
		if IsValid(blobsPartyDetails) then blobsPartyDetails:Remove() end
		blobsPartyMenu:MoveTo(ScrW()+blW, (ScrH()/2) - (blH / 2), 0.5, 0, 1, function()
			gui.EnableScreenClicker(false)
			blobsPartyMenu:Remove()
		end)
	end
	
	local blobsPartyListPartiesButton = vgui.Create("DButton", blobsPartyMenu)
	blobsPartyListPartiesButton:SetSize(50,50)
	blobsPartyListPartiesButton:SetPos(0,50)
	blobsPartyListPartiesButton:SetText("")
	blobsPartyListPartiesButton.Paint = function(self,w,h)
		if blobsPartyMenu.CurrentCategory == BlobsPartyConfig.PartyList then
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,0,4,h)
		end
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(PartyListMaterial)
		surface.DrawTexturedRectRotated(w/2,h/2,16,16,0)
	end
	blobsPartyListPartiesButton.DoClick = function()
		blobsPartyMenu.CurrentCategory = BlobsPartyConfig.PartyList
		blobsPartyContentArea:Clear()
		
		net.Start("blobsParty:SendParties")
		net.SendToServer()
		
		blobsPartyMenuList = vgui.Create("DListView", blobsPartyContentArea)
		blobsPartyMenuList:SetSize(blobsPartyContentArea:GetWide(), blobsPartyContentArea:GetTall())
		blobsPartyMenuList:SetMultiSelect(false)
		blobsPartyMenuList:SetHeaderHeight(30)
		blobsPartyMenuList:SetDataHeight(30)
		blobsPartyMenuList:SetSortable(false)
		local BPOwnerColumn = blobsPartyMenuList:AddColumn(BlobsPartyConfig.Owner)
		BPOwnerColumn:SetFixedWidth(130)
		BPOwnerColumn.PaintOver = function(self,w,h)
			surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			draw.SimpleText(BlobsPartyConfig.Owner, "blobsPartyFont", 5, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		local BPNameColumn = blobsPartyMenuList:AddColumn(BlobsPartyConfig.PartyName)
		BPNameColumn.PaintOver = function(self,w,h)
			surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			draw.SimpleText(BlobsPartyConfig.PartyName, "blobsPartyFont", 5, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		function blobsPartyMenuList:Paint(w,h)
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
		end
		
		blobsPartyMenuList.OnRowRightClick = function(self, lineID, line)
			if IsValid(blobsPartyInspectMenu) then blobsPartyInspectMenu:Remove() end
			blobsPartyInspectMenu = vgui.Create("DPanel")
			blobsPartyInspectMenu:MoveToBack()
			line:GetColumnText(2)
		end
	end
	blobsPartyListPartiesButton.DoClick()
	
	local blobsPartyCreatePartyButton = vgui.Create("DButton", blobsPartyMenu)
	blobsPartyCreatePartyButton:SetSize(50,50)
	blobsPartyCreatePartyButton:SetPos(0,100)
	blobsPartyCreatePartyButton:SetText("")
	blobsPartyCreatePartyButton.Paint = function(self,w,h)
		if blobsPartyMenu.CurrentCategory == BlobsPartyConfig.CreateParty then
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,0,4,h)
		end
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(CreatePartyMaterial)
		surface.DrawTexturedRectRotated(w/2,h/2,16,16,180)
	end
	blobsPartyCreatePartyButton.DoClick = function()
		blobsPartyMenu.CurrentCategory = BlobsPartyConfig.CreateParty
		blobsPartyContentArea:Clear()
		
		net.Start("blobsParty:PartyCheck")
		net.SendToServer()
	end
	
	local blobsPartySettingsButton = vgui.Create("DButton", blobsPartyMenu)
	blobsPartySettingsButton:SetSize(50,50)
	blobsPartySettingsButton:SetPos(0,150)
	blobsPartySettingsButton:SetText("")
	blobsPartySettingsButton.Paint = function(self,w,h)
		if blobsPartyMenu.CurrentCategory == BlobsPartyConfig.PartySettings then
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,0,4,h)
		end
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(PartySettingsMaterial)
		surface.DrawTexturedRectRotated(w/2,h/2,16,16,0)
	end
	blobsPartySettingsButton.DoClick = function()
		blobsPartyMenu.CurrentCategory = BlobsPartyConfig.PartySettings
		blobsPartyContentArea:Clear()
		
		net.Start("blobsParty:ModifyParty")
			net.WriteString("status")
		net.SendToServer()
	end
	
	local blobsPartyManageButton = vgui.Create("DButton", blobsPartyMenu)
	blobsPartyManageButton:SetSize(50,50)
	blobsPartyManageButton:SetPos(0,200)
	blobsPartyManageButton:SetText("")
	blobsPartyManageButton.Paint = function(self,w,h)
		if blobsPartyMenu.CurrentCategory == BlobsPartyConfig.ManagePlayers then
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,0,4,h)
		end
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(PartyMembersMaterial)
		surface.DrawTexturedRectRotated(w/2,h/2,16,16,0)
	end
	blobsPartyManageButton.DoClick = function()
		blobsPartyMenu.CurrentCategory = BlobsPartyConfig.ManagePlayers
		blobsPartyContentArea:Clear()
		
		net.Start("blobsParty:ManagePlayers")
		net.SendToServer()
	end
end)

net.Receive("blobsParty:ManagePlayers", function()
	blobsPartyContentArea:Clear()
	local PlyStatus = net.ReadString()
	local ModifyPanel = vgui.Create("DPanel", blobsPartyContentArea)
	ModifyPanel:SetSize(blobsPartyContentArea:GetSize())
	ModifyPanel.Paint = function(self,w,h) end
	
	if PlyStatus == "owner" then
		local PartyDetails = net.ReadTable()
		local PlayerList = vgui.Create("DComboBox", ModifyPanel)
		PlayerList:SetPos(5,5)
		PlayerList:SetSize(ModifyPanel:GetWide()-10, 35)
		for k,v in pairs(PartyDetails.members) do
			if v != LocalPlayer() then
				PlayerList:AddChoice(v:Nick(), v)
			end
			if k == 2 then
				ModifyPanel.SelectedPly = v
			end
		end

		PlayerList.PaintOver = function(self,w,h)
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			if #PartyDetails.members == 1 then
				draw.SimpleText(BlobsPartyConfig.NoOtherPlys, "blobsPartyFont", 5, 7, Color(255,255,255))
			elseif IsValid(ModifyPanel.SelectedPly) then
				draw.SimpleText(ModifyPanel.SelectedPly:Name(), "blobsPartyFont", 5, 7, Color(255,255,255))
			end
		end
		
		function PlayerList:OnSelect( index, value, data )
			ModifyPanel.SelectedPly = data
		end
		
		local KickButton = vgui.Create("DButton", ModifyPanel)
		KickButton:SetSize(ModifyPanel:GetWide()-8, 35)
		KickButton:SetPos(4, 45)
		KickButton:SetText("")
		KickButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.KickPly, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		KickButton.DoClick = function(self,w,h)
			if IsValid(ModifyPanel.SelectedPly) then
				net.Start("blobsParty:ModifyParty")
					net.WriteString("kick")
					net.WriteEntity(ModifyPanel.SelectedPly)
				net.SendToServer()
			end
		end
		
		local GiveOwnershipButton = vgui.Create("DButton", ModifyPanel)
		GiveOwnershipButton:SetSize(ModifyPanel:GetWide()-8, 35)
		GiveOwnershipButton:SetPos(4, 86)
		GiveOwnershipButton:SetText("")
		GiveOwnershipButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.GiveOwner, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		GiveOwnershipButton.DoClick = function(self,w,h)
			if IsValid(ModifyPanel.SelectedPly) then
				net.Start("blobsParty:ModifyParty")
					net.WriteString("giveowner")
					net.WriteEntity(ModifyPanel.SelectedPly)
				net.SendToServer()
			end
		end
		
		ModifyPanel.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0, 126, w, 1)
			draw.SimpleText(BlobsPartyConfig.ReqToJoin, "blobsPartyFont", 5,144, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		local blobsRequestList = vgui.Create("DListView", ModifyPanel)
		blobsRequestList:SetPos(0,160)
		blobsRequestList:SetSize(ModifyPanel:GetWide(), ModifyPanel:GetTall()-205)
		blobsRequestList:SetMultiSelect(false)
		blobsRequestList:SetHeaderHeight(30)
		blobsRequestList:SetDataHeight(30)
		blobsRequestList:SetSortable(false)
		
		local BPPlyColumn = blobsRequestList:AddColumn(BlobsPartyConfig.Ply)
		BPPlyColumn.PaintOver = function(self,w,h)
			surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			draw.SimpleText(BlobsPartyConfig.Ply, "blobsPartyFont", 5, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		function blobsRequestList:Paint(w,h)
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
		end
		
		blobsRequestList:Clear()
		for k,v in pairs(PartyDetails.requests) do
			if IsValid(v) then
				blobsRequestList:AddLine(v:Nick())
				blobsRequestList:GetLine(k).Ply = v
			end
		end
		
		for k, v in pairs( blobsRequestList.Lines ) do
			v.Paint = function(self,w,h)
				if self:IsSelected() then
					surface.SetDrawColor(BlobsPartyConfig.SecondColor)
				else
					surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
				end
				surface.DrawRect(0,0,w,h)
				
				-- Garry, if you ever read this;
				-- Please make it easier for us to change the text colours and styling on dlistview lines!!!!
				if v:IsSelected() then
					for a,b in pairs(v:GetChildren()) do
						b:SetTextColor(BlobsPartyConfig.BarColor)
					end
				else
					for a,b in pairs(v:GetChildren()) do
						b:SetTextColor(Color(255,255,255))
					end
				end
			end
		end
		
		function blobsRequestList:OnRowRightClick(lineID, line)
			local menu = DermaMenu()
			blobsRequestList.SelectedPly = line.Ply
			menu:AddOption(BlobsPartyConfig.AcceptReq, function()
				net.Start("blobsParty:ModifyParty")
					net.WriteString("accept")
					net.WriteEntity(blobsRequestList.SelectedPly)
				net.SendToServer()
			end):SetIcon("icon16/accept.png")
			menu:Open()
		end
		
		function blobsRequestList:OnRowSelected(lineID, line)
			blobsRequestList.SelectedPly = line.Ply
		end
		
		local blobsAcceptRequestButton = vgui.Create("DButton", ModifyPanel)
		blobsAcceptRequestButton:SetPos(5, ModifyPanel:GetTall()-40)
		blobsAcceptRequestButton:SetSize(ModifyPanel:GetWide()-10,35)
		blobsAcceptRequestButton:SetText("")
		blobsAcceptRequestButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.AcceptReq, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		blobsAcceptRequestButton.DoClick = function()
			net.Start("blobsParty:ModifyParty")
				net.WriteString("accept")
				net.WriteEntity(blobsRequestList.SelectedPly)
			net.SendToServer()
		end
		
	elseif PlyStatus == "member" then
		ModifyPanel.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.OnlyLeaderCan, "blobsPartyFont", w/2, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	elseif PlyStatus == "none" then
		ModifyPanel.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.NotInParty, "blobsPartyFont", w/2, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end)

net.Receive("blobsParty:PartySettings", function()
	blobsPartyContentArea:Clear()
	local PlyStatus = net.ReadString()
	local SettingPanel = vgui.Create("DPanel", blobsPartyContentArea)
	SettingPanel:SetSize(blobsPartyContentArea:GetSize())
	SettingPanel.Paint = function(self,w,h) end

	if PlyStatus == "owner" then
		local OwnedPartyDetails = net.ReadTable()
		local EditPartyFormContainer = vgui.Create("DPanel", blobsPartyContentArea)
		EditPartyFormContainer:SetSize(blobsPartyContentArea:GetSize())
		EditPartyFormContainer.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.PartyName, "blobsPartyFont", 5, 10, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(BlobsPartyConfig.PartySize, "blobsPartyFont", 5, 70, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(BlobsPartyConfig.ReqToJoin.."?", "blobsPartyFont", 5, 128, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0, 184, w, 1)
			surface.DrawOutlinedRect(w/2, 184, 1, h-184)
			
			draw.SimpleText(BlobsPartyConfig.EnRing, "blobsPartyFont", 5, 200, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(BlobsPartyConfig.EnGlow, "blobsPartyFont", w/2+5, 200, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			
			if BlobsPartyConfig.FriendlyFireToggle then
				draw.SimpleText(BlobsPartyConfig.FriendlyFire, "blobsPartyFont", w-35, 128, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			end
		end
		
		local PartyNameTextEntry = vgui.Create("DTextEntry", EditPartyFormContainer)
		PartyNameTextEntry:SetPos(4, 24)
		PartyNameTextEntry:SetSize(EditPartyFormContainer:GetWide()-8,30)
		PartyNameTextEntry:SetText(OwnedPartyDetails.name)
		PartyNameTextEntry:SetFont("blobsPartyFont")

		PartyNameTextEntry.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
		end
		
		local PartySizeTextEntry = vgui.Create("DTextEntry", EditPartyFormContainer)
		PartySizeTextEntry:SetPos(4, 84)
		PartySizeTextEntry:SetSize(EditPartyFormContainer:GetWide()-8,30)
		PartySizeTextEntry:SetNumeric(true)
		PartySizeTextEntry:SetText(OwnedPartyDetails.size)
		PartySizeTextEntry:SetFont("blobsPartyFont")		
		PartySizeTextEntry.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
		end
		surface.SetFont("blobsPartyFont")
		local tx,ty = surface.GetTextSize(BlobsPartyConfig.ReqToJoin.."?")
		local RequestJoinCheckbox = vgui.Create("DCheckBox", EditPartyFormContainer)
		RequestJoinCheckbox:SetPos(tx+10, 117)
		RequestJoinCheckbox:SetSize(25,25)
		RequestJoinCheckbox:SetValue(1)
		RequestJoinCheckbox:SetChecked(tobool(OwnedPartyDetails.invite))
		RequestJoinCheckbox.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			if self:GetChecked() then
				draw.RoundedBox(4,4,4,w-8,h-8, BlobsPartyConfig.BarColor)
			end
		end
		
		local ToggleFFCheckbox = vgui.Create("DCheckBox", EditPartyFormContainer)
		ToggleFFCheckbox:SetVisible(false)
		if BlobsPartyConfig.FriendlyFireToggle then
			ToggleFFCheckbox:SetPos(EditPartyFormContainer:GetWide()-30, 117)
			ToggleFFCheckbox:SetSize(25,25)
			ToggleFFCheckbox:SetValue(1)
			ToggleFFCheckbox:SetChecked(tobool(OwnedPartyDetails.friendlyfire))
			ToggleFFCheckbox.Paint = function(self,w,h)
				surface.SetDrawColor(0,0,0)
				surface.DrawOutlinedRect(0,0,w,h)
				
				if self:GetChecked() then
					draw.RoundedBox(4,4,4,w-8,h-8, BlobsPartyConfig.BarColor)
				end
			end
			ToggleFFCheckbox:SetVisible(true)
		end
		
		local EditPartyButton = vgui.Create("DButton", EditPartyFormContainer)
		EditPartyButton:SetSize(EditPartyFormContainer:GetWide()-8, 34)
		EditPartyButton:SetPos(4, 145)
		EditPartyButton:SetText("")
		EditPartyButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.EditParty, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		EditPartyButton.DoClick = function(self,w,h)
			net.Start("blobsParty:ModifyParty")
				net.WriteString("modify")
				net.WriteString(PartyNameTextEntry:GetValue())
				net.WriteUInt(math.Clamp(tonumber(PartySizeTextEntry:GetValue()), 1, BlobsPartyConfig.MaxSize+2), 32)
				net.WriteString(tostring(RequestJoinCheckbox:GetChecked()))
				if BlobsPartyConfig.FriendlyFireToggle then
					net.WriteBool(ToggleFFCheckbox:GetChecked())
				end
			net.SendToServer()
		end	
		
		local EnableRingCheckbox = vgui.Create("DCheckBox", EditPartyFormContainer)
		EnableRingCheckbox:SetSize(25,25)
		surface.SetFont("blobsPartyFont")
		local tx,ty = surface.GetTextSize(BlobsPartyConfig.EnRing)
		EnableRingCheckbox:SetPos(tx+10, 188)
		EnableRingCheckbox:SetChecked(OwnedPartyDetails.usering)
		EnableRingCheckbox.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			if self:GetChecked() then
				draw.RoundedBox(4,4,4,w-8,h-8, BlobsPartyConfig.BarColor)
			end
		end
		
		local RingColorSelector = vgui.Create("DColorMixer", EditPartyFormContainer)
		RingColorSelector:SetPos(5, 217)
		RingColorSelector:SetSize((EditPartyFormContainer:GetWide()/2)-10, 150)
		RingColorSelector:SetPalette(false)
		RingColorSelector:SetAlphaBar(false)
		RingColorSelector:SetWangs(false)
		RingColorSelector:SetColor(OwnedPartyDetails.ringcolor) 
		
		local ColorPreviewPanel = vgui.Create("DPanel", EditPartyFormContainer)
		ColorPreviewPanel:SetPos(5, 372)
		ColorPreviewPanel:SetSize((EditPartyFormContainer:GetWide()/2)-10, 32)
		ColorPreviewPanel.Paint = function(self,w,h)
			surface.SetDrawColor(RingColorSelector:GetColor())
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		
		local SetRingColorButton = vgui.Create("DButton", EditPartyFormContainer)
		SetRingColorButton:SetPos(5, EditPartyFormContainer:GetTall()-40)
		SetRingColorButton:SetSize((EditPartyFormContainer:GetWide()/2)-10, 35)
		SetRingColorButton:SetText("")
		SetRingColorButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.SetClr, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		SetRingColorButton.DoClick = function()
			net.Start("blobsParty:ModifyParty")
				net.WriteString("ring")
				net.WriteBool(EnableRingCheckbox:GetChecked())
				local Col = RingColorSelector:GetColor()
				net.WriteColor(Color(Col.r, Col.g, Col.b))
			net.SendToServer()
		end
		surface.SetFont("blobsPartyFont")
		local tx,ty = surface.GetTextSize(BlobsPartyConfig.EnGlow)
		
		local EnableGlowCheckbox = vgui.Create("DCheckBox", EditPartyFormContainer)
		EnableGlowCheckbox:SetSize(25,25)
		EnableGlowCheckbox:SetPos(EditPartyFormContainer:GetWide()/2+tx+10, 188)
		EnableGlowCheckbox:SetChecked(OwnedPartyDetails.useglow)
		EnableGlowCheckbox.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			if self:GetChecked() then
				draw.RoundedBox(4,4,4,w-8,h-8, BlobsPartyConfig.BarColor)
			end
		end
		
		local GlowColorSelector = vgui.Create("DColorMixer", EditPartyFormContainer)
		GlowColorSelector:SetPos((EditPartyFormContainer:GetWide()/2)+5, 217)
		GlowColorSelector:SetSize((EditPartyFormContainer:GetWide()/2)-10, 150)
		GlowColorSelector:SetPalette(false)
		GlowColorSelector:SetAlphaBar(false)
		GlowColorSelector:SetWangs(false)
		GlowColorSelector:SetColor(OwnedPartyDetails.glowcolor) 
		
		local ColorPreviewPanel = vgui.Create("DPanel", EditPartyFormContainer)
		ColorPreviewPanel:SetPos((EditPartyFormContainer:GetWide()/2)+5, 372)
		ColorPreviewPanel:SetSize((EditPartyFormContainer:GetWide()/2)-10, 32)
		ColorPreviewPanel.Paint = function(self,w,h)
			surface.SetDrawColor(GlowColorSelector:GetColor())
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		
		local SetGlowColorButton = vgui.Create("DButton", EditPartyFormContainer)
		SetGlowColorButton:SetPos((EditPartyFormContainer:GetWide()/2)+5, EditPartyFormContainer:GetTall()-40)
		SetGlowColorButton:SetSize((EditPartyFormContainer:GetWide()/2)-10, 35)
		SetGlowColorButton:SetText("")
		SetGlowColorButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.SetClr, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		SetGlowColorButton.DoClick = function()
			net.Start("blobsParty:ModifyParty")
				net.WriteString("glow")
				net.WriteBool(EnableGlowCheckbox:GetChecked())
				local Col = GlowColorSelector:GetColor()
				net.WriteColor(Color(Col.r, Col.g, Col.b))
			net.SendToServer()
		end
	elseif PlyStatus == "member" then
		SettingPanel.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.OnlyLeaderCan, "blobsPartyFont", w/2, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	elseif PlyStatus == "none" then
		SettingPanel.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.NotInParty, "blobsPartyFont", w/2, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end)

net.Receive("blobsParty:SendParties", function()
	local PartyData = net.ReadTable()
	if not IsValid(blobsPartyMenu) then return end
	if not IsValid(blobsPartyMenuList) then return end
	blobsPartyMenuList:Clear()
	for k,v in pairs(PartyData) do
		if IsValid(v.owner) then
			blobsPartyMenuList:AddLine(v.owner:Name(),v.name)
		end
	end
	for k, v in pairs( blobsPartyMenuList.Lines ) do
		v.Paint = function(self,w,h)
			if self:IsSelected() then
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			end
			surface.DrawRect(0,0,w,h)
			
			-- Garry, if you ever read this;
			-- Please make it easier for us to change the text colours and styling on dlistview lines!!!!
			if v:IsSelected() then
				for a,b in pairs(v:GetChildren()) do
					b:SetTextColor(BlobsPartyConfig.BarColor)
				end
			else
				for a,b in pairs(v:GetChildren()) do
					b:SetTextColor(Color(255,255,255))
				end
			end
		end
	end
	
	blobsPartyMenuList.OnRowSelected = function(a,b,row)
		net.Start("blobsParty:GetDetails")
			net.WriteString(row:GetColumnText(2))
		net.SendToServer()
	end
end)

net.Receive("blobsParty:GetDetails", function()
	local PartyDetails = net.ReadTable()
	local InParty = net.ReadBool()
	PrintTable(PartyDetails)
	if not IsValid(PartyDetails.owner) then return end
	if IsValid(blobsPartyDetails) then blobsPartyDetails:Remove() end
	local blW, blH = 325,300
	blobsPartyDetails = vgui.Create("DFrame", blobsPartyMenu)
	blobsPartyDetails:SetTitle("")
	blobsPartyDetails:ShowCloseButton(false)
	blobsPartyDetails:SetSize(blW, blH)
	blobsPartyDetails:MakePopup()
	blobsPartyDetails.CurrentCategory = "Details"
	blobsPartyDetails:SetPos(blobsPartyMenu:GetPos())
	blobsPartyDetails:MoveToBack()
	blobsPartyDetails:SetDraggable(false)
	blobsPartyMenu:MoveToFront()
	local sx,sy = blobsPartyMenu:GetSize()
	local ssx, ssy = blobsPartyMenu:GetPos()
	blobsPartyDetails:MoveTo(ssx+sx, ssy, 1)
	blobsPartyDetails.Paint = function(self,w,h)
		surface.SetDrawColor(BlobsPartyConfig.FirstColor)
		surface.DrawRect(0,0,w,h)
		draw.SimpleTextOutlined(PartyDetails.name, "blobsPartyFont", 60, 25, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	
		surface.SetDrawColor(BlobsPartyConfig.SecondColor)
		surface.DrawRect(0,0,50,h)
		
		surface.SetDrawColor(0,0,0)
		surface.DrawOutlinedRect(0,0,w,h)
	end
	blobsPartyDetails.PaintOver = function(self,w,h)
		surface.SetDrawColor(0,0,0)
		surface.DrawOutlinedRect(50,0,1,h)
	end

	local blobsPartyDetailsClose = vgui.Create("DButton", blobsPartyDetails)
	blobsPartyDetailsClose:SetSize(25,25)
	blobsPartyDetailsClose:SetPos(blobsPartyDetails:GetWide() - 25,0)
	blobsPartyDetailsClose:SetText("")
	local blobsPartyCloseButtonColour = Color(255,255,255)
	
	blobsPartyDetailsClose.Paint = function(self,w,h)
		if self:IsHovered() then
			blobsPartyCloseButtonColour = Color(100,100,100)
		else
			blobsPartyCloseButtonColour = Color(255,255,255)
		end
		draw.SimpleTextOutlined("X", "blobsPartyFont", w/2, h/2, blobsPartyCloseButtonColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	end
	
	blobsPartyDetailsClose.DoClick = function()
		blobsPartyDetails:Remove()
	end
	
	local blobsPartyDetailsAvatar = vgui.Create( "AvatarImage", blobsPartyDetails )
	blobsPartyDetailsAvatar:SetSize( 50, 50 )
	blobsPartyDetailsAvatar:SetPlayer(PartyDetails.owner, 50 )
	
	blobsPartyDetailsArea = vgui.Create("DPanel", blobsPartyDetails)
	blobsPartyDetailsArea:SetPos(50, 50)
	blobsPartyDetailsArea:SetSize(blobsPartyDetails:GetWide()-50, blobsPartyDetails:GetTall()-50)
	blobsPartyDetailsArea.Paint = function(self,w,h)
		surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
		surface.DrawRect(0,0,w,h)
	end
	
	local blobsPartyDetailsList = vgui.Create("DButton", blobsPartyDetails)
	blobsPartyDetailsList:SetSize(50,50)
	blobsPartyDetailsList:SetPos(0,50)
	blobsPartyDetailsList:SetText("")
	blobsPartyDetailsList.Paint = function(self,w,h)
		if blobsPartyDetails.CurrentCategory == "Details" then
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,0,4,h)
		end
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(PartyDetailsMaterial)
		surface.DrawTexturedRectRotated(w/2,h/2,16,16,0)
	end
	blobsPartyDetailsList.DoClick = function()
		blobsPartyDetailsArea:Clear()
		blobsPartyDetails.CurrentCategory = "Details"
		
		local PanelDetails = vgui.Create("DPanel", blobsPartyDetailsArea)
		PanelDetails:SetSize(blobsPartyDetailsArea:GetSize())
		PanelDetails.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.PartyLeader, "blobsPartyFont", 10, 10, Color(255,255,255))
			draw.SimpleText(PartyDetails.owner:Nick(), "blobsPartyFont", 10, 35, Color(255,255,255))
			draw.SimpleText(BlobsPartyConfig.PartyMmbs, "blobsPartyFont", 10, 60, Color(255,255,255))
			draw.SimpleText(#PartyDetails.members.."/"..PartyDetails.size, "blobsPartyFont", 10, 85, Color(255,255,255))
			draw.SimpleText(BlobsPartyConfig.OpenParty, "blobsPartyFont", 10, 110, Color(255,255,255))
			draw.SimpleText(tobool(PartyDetails.invite) and BlobsPartyConfig.No or BlobsPartyConfig.Yes, "blobsPartyFont", 10, 135, Color(255,255,255))
		end
		
		if not InParty then
			local RequestJoin = vgui.Create("DButton", blobsPartyDetailsArea)
			RequestJoin:SetSize(blobsPartyDetailsArea:GetWide()-8, 34)
			RequestJoin:SetPos(4, blobsPartyDetailsArea:GetTall()-38)
			RequestJoin:SetText("")
			RequestJoin.Paint = function(self,w,h)
				if self:IsHovered() then
					surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
				else
					surface.SetDrawColor(BlobsPartyConfig.SecondColor)
				end
				surface.DrawRect(0,0,w,h)
				
				surface.SetDrawColor(BlobsPartyConfig.BarColor)
				surface.DrawRect(0,h-4,w,4)
				
				surface.SetDrawColor(0,0,0)
				surface.DrawOutlinedRect(0,0,w,h)
				
				draw.SimpleText(tobool(PartyDetails.invite) and BlobsPartyConfig.ReqToJoin or BlobsPartyConfig.Join, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			RequestJoin.DoClick = function(self,w,h)
				net.Start("blobsParty:ModifyParty")
					net.WriteString("join")
					net.WriteString(PartyDetails.name)
				net.SendToServer()
			end
		end
	end
	blobsPartyDetailsList.DoClick()
	
	local blobsPartyDetailsMembers = vgui.Create("DButton", blobsPartyDetails)
	blobsPartyDetailsMembers:SetSize(50,50)
	blobsPartyDetailsMembers:SetPos(0,100)
	blobsPartyDetailsMembers:SetText("")
	blobsPartyDetailsMembers.Paint = function(self,w,h)
		if blobsPartyDetails.CurrentCategory == "Members" then
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,0,4,h)
		end
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(PartyMembersMaterial)
		surface.DrawTexturedRectRotated(w/2,h/2,16,16,0)
	end
	blobsPartyDetailsMembers.DoClick = function()
		blobsPartyDetailsArea:Clear()
		blobsPartyDetails.CurrentCategory = "Members"
		
		blobsPartyMembersList = vgui.Create("DListView", blobsPartyDetailsArea)
		blobsPartyMembersList:SetSize(blobsPartyDetailsArea:GetWide(), blobsPartyDetailsArea:GetTall())
		blobsPartyMembersList:SetMultiSelect(false)
		blobsPartyMembersList:SetHeaderHeight(30)
		blobsPartyMembersList:SetDataHeight(30)
		blobsPartyMembersList:SetSortable(false)
		local BPOwnerColumn = blobsPartyMembersList:AddColumn(BlobsPartyConfig.Mmbs)
		BPOwnerColumn.PaintOver = function(self,w,h)
			surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			draw.SimpleText(BlobsPartyConfig.Mmbs, "blobsPartyFont", 5, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		function blobsPartyMembersList:Paint(w,h)
			surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			surface.DrawRect(0,0,w,h)
		end
		
		function blobsPartyMembersList:OnRowRightClick(lineID, line)
			local menu = DermaMenu()
			menu:AddOption(BlobsPartyConfig.CopyName, function() SetClipboardText(line.ply:Nick()) end):SetIcon("icon16/user.png")
			menu:AddOption(BlobsPartyConfig.CopySteamID, function() SetClipboardText(line.ply:SteamID()) end):SetIcon("icon16/user_gray.png")
			menu:AddOption(BlobsPartyConfig.ViewSteamProfile, function() line.ply:ShowProfile() end):SetIcon("icon16/layout.png")
			menu:Open()
		end
		
		function blobsPartyMembersList:OnRowSelected(lineID, line)
			blobsPartyMembersList:OnRowRightClick(lineID, line)
		end
		
		for k,v in pairs(PartyDetails.members) do
			local line = blobsPartyMembersList:AddLine(v:Nick())
			line.ply = v
		end
		
		for k, v in pairs( blobsPartyMembersList.Lines ) do
			v.Paint = function(self,w,h)
				if self:IsSelected() then
					surface.SetDrawColor(BlobsPartyConfig.SecondColor)
				else
					surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
				end
				surface.DrawRect(0,0,w,h)
				
				-- Garry, if you ever read this;
				-- Please make it easier for us to change the text colours and styling on dlistview lines!!!!
				if v:IsSelected() then
					for a,b in pairs(v:GetChildren()) do
						b:SetTextColor(BlobsPartyConfig.BarColor)
					end
				else
					for a,b in pairs(v:GetChildren()) do
						b:SetTextColor(Color(255,255,255))
					end
				end
			end
		end
	end	
end)

net.Receive("blobsParty:PartyCheck", function()
	local ReturnData = net.ReadString()
	
	if ReturnData == "owner" then
		blobsPartyContentArea:Clear()
		
		local CoverPanel = vgui.Create("DPanel", blobsPartyContentArea)
		CoverPanel:SetSize(blobsPartyContentArea:GetSize())
		CoverPanel.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.AlreadyOwn, "blobsPartyFont", w/2, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		local DisbandPartyButton = vgui.Create("DButton", blobsPartyContentArea)
		DisbandPartyButton:SetSize(blobsPartyContentArea:GetWide()-8, 34)
		DisbandPartyButton:SetPos(4, 40)
		DisbandPartyButton:SetText("")
		DisbandPartyButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.Disband, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		DisbandPartyButton.DoClick = function()
			net.Start("blobsParty:ModifyParty")
				net.WriteString("disband")
			net.SendToServer()
		end
		
	elseif ReturnData == "member" then
		blobsPartyContentArea:Clear()
		
		local CoverPanel = vgui.Create("DPanel", blobsPartyContentArea)
		CoverPanel:SetSize(blobsPartyContentArea:GetSize())
		CoverPanel.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.AlreadyIn, "blobsPartyFont", w/2, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		local LeavePartyButton = vgui.Create("DButton", blobsPartyContentArea)
		LeavePartyButton:SetSize(blobsPartyContentArea:GetWide()-8, 34)
		LeavePartyButton:SetPos(4, 40)
		LeavePartyButton:SetText("")
		LeavePartyButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.Leave, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		LeavePartyButton.DoClick = function()
			net.Start("blobsParty:ModifyParty")
				net.WriteString("leave")
			net.SendToServer()
		end
		
	elseif ReturnData == "no party" then
		blobsPartyContentArea:Clear()
		
		local CreatePartyFormContainer = vgui.Create("DPanel", blobsPartyContentArea)
		CreatePartyFormContainer:SetSize(blobsPartyContentArea:GetSize())
		CreatePartyFormContainer.Paint = function(self,w,h)
			draw.SimpleText(BlobsPartyConfig.PartyName, "blobsPartyFont", 5, 10, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(BlobsPartyConfig.PartySize, "blobsPartyFont", 5, 70, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(BlobsPartyConfig.ReqToJoin, "blobsPartyFont", 5, 128, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(BlobsPartyConfig.FriendlyFire, "blobsPartyFont", w-35,128, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		
		end
		
		local PartyNameTextEntry = vgui.Create("DTextEntry", CreatePartyFormContainer)
		PartyNameTextEntry:SetPos(4, 24)
		PartyNameTextEntry:SetSize(CreatePartyFormContainer:GetWide()-8,30)
		PartyNameTextEntry:SetText(BlobsPartyConfig.PartyName.."...")
		PartyNameTextEntry:SetFont("blobsPartyFont")
		PartyNameTextEntry.OnGetFocus = function()
			if PartyNameTextEntry:GetValue() == BlobsPartyConfig.PartyName.."..." then
				PartyNameTextEntry:SetText("")
			end
		end
		PartyNameTextEntry.OnLoseFocus = function()
			if PartyNameTextEntry:GetValue() == "" then
				PartyNameTextEntry:SetText(BlobsPartyConfig.PartyName.."...")
			end
		end
		PartyNameTextEntry.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
		end
		
		local PartySizeTextEntry = vgui.Create("DTextEntry", CreatePartyFormContainer)
		PartySizeTextEntry:SetPos(4, 84)
		PartySizeTextEntry:SetSize(CreatePartyFormContainer:GetWide()-8,30)
		PartySizeTextEntry:SetNumeric(true)
		PartySizeTextEntry:SetText("5")
		PartySizeTextEntry:SetFont("blobsPartyFont")		
		PartySizeTextEntry.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
		end
		
		local RequestJoinCheckbox = vgui.Create("DCheckBox", CreatePartyFormContainer)
		
		surface.SetFont("blobsPartyFont")
		local tx,ty = surface.GetTextSize(BlobsPartyConfig.ReqToJoin)
		RequestJoinCheckbox:SetPos(tx+10, 117)
		RequestJoinCheckbox:SetSize(25,25)
		RequestJoinCheckbox:SetValue(1)
		RequestJoinCheckbox.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			if self:GetChecked() then
				draw.RoundedBox(4,4,4,w-8,h-8, BlobsPartyConfig.BarColor)
			end
		end
		
		local ToggleFFCheckbox = vgui.Create("DCheckBox", CreatePartyFormContainer)
		ToggleFFCheckbox:SetVisible(false)
		if BlobsPartyConfig.FriendlyFireToggle then
			ToggleFFCheckbox:SetPos(CreatePartyFormContainer:GetWide()-30, 117)
			ToggleFFCheckbox:SetSize(25,25)
			ToggleFFCheckbox:SetValue(0)
			ToggleFFCheckbox.Paint = function(self,w,h)
				surface.SetDrawColor(0,0,0)
				surface.DrawOutlinedRect(0,0,w,h)
				
				if self:GetChecked() then
					draw.RoundedBox(4,4,4,w-8,h-8, BlobsPartyConfig.BarColor)
				end
			end
			ToggleFFCheckbox:SetVisible(true)
		end
		
		local CreatePartyButton = vgui.Create("DButton", CreatePartyFormContainer)
		CreatePartyButton:SetSize(CreatePartyFormContainer:GetWide()-8, 34)
		CreatePartyButton:SetPos(4, 145)
		CreatePartyButton:SetText("")
		CreatePartyButton.Paint = function(self,w,h)
			if self:IsHovered() then
				surface.SetDrawColor(BlobsPartyConfig.ThirdColor)
			else
				surface.SetDrawColor(BlobsPartyConfig.SecondColor)
			end
			surface.DrawRect(0,0,w,h)
			
			surface.SetDrawColor(BlobsPartyConfig.BarColor)
			surface.DrawRect(0,h-4,w,4)
			
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
			
			draw.SimpleText(BlobsPartyConfig.CreateParty, "blobsPartyFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		CreatePartyButton.DoClick = function(self,w,h)
			net.Start("blobsParty:CreateParty")
				net.WriteString(PartyNameTextEntry:GetValue())
				net.WriteUInt(math.Clamp(tonumber(PartySizeTextEntry:GetValue()), 1, BlobsPartyConfig.MaxSize+2), 32)
				net.WriteString(tostring(RequestJoinCheckbox:GetChecked()))
				if BlobsPartyConfig.FriendlyFireToggle then
					net.WriteBool(tobool(ToggleFFCheckbox:GetChecked()))
				end
			net.SendToServer()
		end
	end
end)

net.Receive("blobsParty:ErrorPopup", function()
	if IsValid(blobsPartyCreationError) then blobsPartyCreationError:Remove() end
	local CreationErrors = net.ReadTable()
	
	local blW, blH = 450,100
	blobsPartyCreationError = vgui.Create("DFrame")
	blobsPartyCreationError:SetTitle("")
	blobsPartyCreationError:ShowCloseButton(false)
	blobsPartyCreationError:SetSize(blW, blH)
	blobsPartyCreationError:Center()
	blobsPartyCreationError:SetTall(#CreationErrors*24+25)
	
	blobsPartyCreationError:MakePopup()
	blobsPartyCreationError.Paint = function(self,w,h)
		surface.SetDrawColor(BlobsPartyConfig.FirstColor)
		surface.DrawRect(0,0,w,h)
		
		surface.SetDrawColor(0,0,0)
		surface.DrawOutlinedRect(0,0,w,h)
		
		for k,v in pairs(CreationErrors) do
			draw.SimpleText(v, "blobsPartyFont", w/2, k*24, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
		
	local blobsPartyCreationErrorClose = vgui.Create("DButton", blobsPartyCreationError)
	blobsPartyCreationErrorClose:SetSize(25,25)
	blobsPartyCreationErrorClose:SetPos(blobsPartyCreationError:GetWide() - 25,0)
	blobsPartyCreationErrorClose:SetText("")
	local blobsPartyCloseButtonColour = Color(255,255,255)
	
	blobsPartyCreationErrorClose.Paint = function(self,w,h)
		if self:IsHovered() then
			blobsPartyCloseButtonColour = Color(100,100,100)
		else
			blobsPartyCloseButtonColour = Color(255,255,255)
		end
		draw.SimpleTextOutlined("X", "blobsPartyFont", w/2, h/2, blobsPartyCloseButtonColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	end
	
	blobsPartyCreationErrorClose.DoClick = function()
		blobsPartyCreationError:Remove()
	end
end)

hook.Add( "PostPlayerDraw", "blobsParty:DrawRing", function(ply)
	if MyBlobsParty.members and table.HasValue(MyBlobsParty.members, ply) and MyBlobsParty.usering then
		local partymemberpos = ply:GetPos()
		cam.Start3D2D(partymemberpos + Vector(0,0,1), Angle( 0, 0, 0 ), 0.25) 
			surface.SetMaterial(PartyCircleMaterial)
			surface.SetDrawColor(MyBlobsParty.ringcolor)
			surface.DrawTexturedRect(-192 * 0.5, -192 * 0.5, 192, 192)
		cam.End3D2D()
	end
end)

hook.Add("PreDrawHalos", "blobsParty:DrawHalo", function()
	if MyBlobsParty.members and table.HasValue(MyBlobsParty.members, ply) and MyBlobsParty.useglow then
		halo.Add(MyBlobsParty.members, MyBlobsParty.glowcolor, 4,4,4)
	end
end)

local function blobsPartyHUD()
	if IsValid(blobsPartyGUI) or MyBlobsParty == {} then blobsPartyGUI:Remove() end
	blobsPartyGUI = vgui.Create("DFrame")
	blobsPartyGUI:SetPos(BlobsPartyConfig.DefaultTopUISpacing,5)
	blobsPartyGUI:ShowCloseButton(false)
	blobsPartyGUI:SetDraggable(true)
	blobsPartyGUI:SetTitle("")
	blobsPartyGUI:SetSize(ScrW(),ScrH())
	blobsPartyGUI.Paint = function(self,w,h)
		surface.SetDrawColor(BlobsPartyConfig.FirstColor)
		surface.DrawRect(0,0,w,20)
		surface.SetDrawColor(BlobsPartyConfig.BarColor)
		surface.DrawOutlinedRect(0,0,w,20)
		
		draw.SimpleText(BlobsPartyConfig.PartyMmbs, "DermaDefault",5, 10, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	blobsPartyGUI:SetMouseInputEnabled(true)
	
	blobsPartyOwner = vgui.Create("DPanel", blobsPartyGUI)
	blobsPartyOwner:SetSize(250, 50)
	blobsPartyOwner:SetText("")
	blobsPartyOwner:SetPos(0, 25)
	blobsPartyOwner.Paint = function(self,w,h)
		surface.SetDrawColor(BlobsPartyConfig.FirstColor)
		surface.DrawRect(0,0,w,h)
		
		surface.SetDrawColor(0,0,0)
		surface.DrawOutlinedRect(0,0,w,h)
		
		if not IsValid(MyBlobsParty.owner) then
			self:Remove()
		end
	end
	blobsPartyOwner.HPLerp = MyBlobsParty.owner:Health()
	
	local PMAvatar = vgui.Create("AvatarImage", blobsPartyOwner)
	PMAvatar:SetSize(50,50)
	PMAvatar:SetPlayer(MyBlobsParty.owner, 50)
	PMAvatar.PaintOver = function(self,w,h)
		surface.SetDrawColor(BlobsPartyConfig.BarColor)
		surface.DrawRect(0,h-4,50,4)
	end
	
	local PMDetails = vgui.Create("DPanel", blobsPartyOwner)
	PMDetails:SetSize(200,50)
	PMDetails:SetText("")
	PMDetails:SetPos(50,0)
	PMDetails.Paint = function(self,w,h)
		if IsValid(MyBlobsParty.owner) then
			blobsPartyOwner.HPLerp = Lerp(10 * FrameTime(),blobsPartyOwner.HPLerp, MyBlobsParty.owner:Health())
			draw.SimpleText(MyBlobsParty.owner:Nick(), "blobsPartyFont", 5, 6, Color(255,255,255))
			
			draw.SimpleText(BlobsPartyConfig.HP..": "..MyBlobsParty.owner:Health().."/"..MyBlobsParty.owner:GetMaxHealth(), "blobsPartyFontSmall", 2, 29, Color(255,255,255))
			
			surface.SetDrawColor(255,0,0)
			surface.DrawRect(0, h-4, 200 * (blobsPartyOwner.HPLerp/100), 4)
		end
	end
	
	local blobsPMembers = {}
	local pCount = 1
	for k,v in ipairs(MyBlobsParty.members) do
		if v != MyBlobsParty.owner then
			blobsPMembers[k] = vgui.Create("DPanel", blobsPartyGUI)
			blobsPMembers[k]:SetSize(250, 50)
			blobsPMembers[k]:SetPos(0, (pCount*55)+25)
			blobsPMembers[k].Paint = function(self,w,h)
				surface.SetDrawColor(BlobsPartyConfig.FirstColor)
				surface.DrawRect(0,0,w,h)
				
				surface.SetDrawColor(0,0,0)
				surface.DrawOutlinedRect(0,0,w,h)
				
				if not IsValid(v) then
					self:Remove()
				end
			end
			blobsPMembers[k].HPLerp = v:Health()
			
			local PMAvatar = vgui.Create("AvatarImage", blobsPMembers[k])
			PMAvatar:SetSize(50,50)
			PMAvatar:SetPlayer(v, 50)
			
			local PMDetails = vgui.Create("DPanel", blobsPMembers[k])
			PMDetails:SetSize(200,50)
			PMDetails:SetPos(50,0)
			PMDetails.Paint = function(self,w,h)
				if IsValid(v) then
					blobsPMembers[k].HPLerp = Lerp(10 * FrameTime(),blobsPMembers[k].HPLerp, v:Health())
					draw.SimpleText(v:Nick(), "blobsPartyFont", 5, 6, Color(255,255,255))
					
					draw.SimpleText(BlobsPartyConfig.HP..": "..v:Health().."/"..v:GetMaxHealth(), "blobsPartyFontSmall", 2, 29, Color(255,255,255))
					
					surface.SetDrawColor(255,0,0)
					surface.DrawRect(0, h-4, 200 * (blobsPMembers[k].HPLerp/100), 4)
				end
			end
			
			pCount = pCount + 1
		end
	end
	
	blobsPartyGUI:SetSize(250, ScrH())
end

net.Receive("blobsParty:PartyDisband", function()
	if IsValid(blobsPartyGUI) then
		MyBlobsParty = {}
		blobsPartyGUI:Remove()
	end
end)

net.Receive("blobsParty:MyParty", function()
	MyBlobsParty = net.ReadTable()
	blobsPartyHUD()
end)

net.Receive("blobsParty:PartyChat", function()
	local Sender = net.ReadEntity()
	local Message = net.ReadString()
	chat.AddText(BlobsPartyConfig.PartyChatPrefixColor, Sender, " "..BlobsPartyConfig.PartyChatPrefix, BlobsPartyConfig.PartyChatColor, ": "..Message)
end)