--GUI base created by billy
--https://scriptfodder.com/users/view/76561198040894045/scripts

AddCSLuaFile()
parties = {}	
	CreateClientConVar("color_phalo_r", 0, true)
	CreateClientConVar("color_phalo_g", 255, true)
	CreateClientConVar("color_phalo_b", 0, true)
	CreateClientConVar("color_phalo_a", 255, true)
	if party.defaultlowend == true then 
		CreateClientConVar("party_lowend", 1, true)
	else 
		CreateClientConVar("party_lowend", 0, true)
	end
	CreateClientConVar("party_showhud", 0, true)
	
	
	local hcol = Color(	GetConVar( "color_phalo_r" ):GetInt(hr), GetConVar( "color_phalo_g" ):GetInt(hg), GetConVar( "color_phalo_b" ):GetInt(hb), GetConVar( "color_phalo_a" ):GetInt(ha)) or Color(0,255,0,255)	
	local hr, hg, hb, ha = tonumber(hcol.r) or 0, tonumber(hcol.g) or 0, tonumber(hcol.b) or 0, tonumber(hcol.a) or 255
	
	function HaloColorUpdate()
	local hr, hg, hb, ha = tostring(tonumber(hcol.r) or 0), tostring(tonumber(hcol.g) or 0), tostring(tonumber(hcol.b) or 0), tostring(tonumber(hcol.a) or 255)
		GetConVar( "color_phalo_r" ):SetInt(hr)  
		GetConVar( "color_phalo_g" ):SetInt(hg)
		GetConVar( "color_phalo_b" ):SetInt(hb)
		GetConVar( "color_phalo_a" ):SetInt(ha)
	end

local PartyFrame

		hook.Add( "Think", "hopperkeylistener", function()
			if party.partymenubutton then
				if  input.IsKeyDown( party.partymenubutton ) and (PartyFrame == nil || !PartyFrame:IsVisible())  then
					PartyMenu()
				end
			end
		end )

			
			net.Receive("party", function(len, CLIENT)
				parties = net.ReadTable()
			end)
			

			net.Receive( "partiesmenu", function( len, pl )
				PartyMenu()
			end)
			
			
			net.Receive( "joinrequest", function( len, pl )
				local requestedid = net.ReadString()  
				requestMenu(requestedid)
			end)

			net.Receive( "partyinvite", function( len, pl )
				local invitedby = net.ReadString()  
				partyinvite(invitedby)
			end)
		
		
function partyinvite(invitedby)
	local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( -500, ScrH()/4 ) 
	Frame:SetSize( 200, 400 ) 
	Frame:SetTitle( party.language["Invited to join a party"] ) 
	Frame:SetVisible( true )
	Frame:SetDraggable( true ) 
	Frame:ShowCloseButton( false )
	--Frame:MakePopup() 
	Frame:SetDeleteOnClose(true)
	Frame:SetVerticalScrollbarEnabled(false)
	Frame:LerpPositions(20,false)
	Frame:SetPos( 0, ScrH()/4 ) 

	function Frame:Paint( w, h )
		draw.RoundedBox( 5, 0, 0, w, h, party.backgroundcolor )
		draw.RoundedBox(5,2,2,w-4,h-4,Color(0,0,0,100))
		draw.RoundedBox(5,4,4,w-8,h-8,Color(0,0,0,100))
		draw.RoundedBox(5,6,6,w-12,h-12,Color(0,0,0,100))
		draw.RoundedBox(5,8,8,w-16,h-16,Color(0,0,0,100))
		Frame:InvalidateLayout(true)
		Frame:SizeToChildren( true, true )
	end
	local DButtonclose = vgui.Create( "DButton" )
	DButtonclose:SetParent( Frame )
	DButtonclose:SetPos( Frame:GetSize(), 5) 
	DButtonclose:SetText( "X" )
	DButtonclose:SetSize( 20, 20 )
	DButtonclose:SetTextColor(Color( 255,255,255) )
	--DButtonclose:Dock(RIGHT)
	DButtonclose.DoClick = function()
		LocalPlayer():ConCommand("answerinvite "..invitedby .. " false")
		Frame:Close()
	end
	function DButtonclose:Paint(w,h)
		if !DButtonclose:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttoncolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
		if DButtonclose:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttonhovercolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
	end
	
	local panel2 = vgui.Create("DPanel",Frame)
		panel2:Dock(TOP)
		panel2:SetSize(Frame:GetSize(), 50 )
		panel2:SetPos()
		
		function panel2:Paint(w,h)
			panel2:InvalidateLayout(true)
		panel2:SizeToChildren( true, true )
		end
		
	local DLabel2 = vgui.Create( "DLabel", panel2 )
	DLabel2:Dock(TOP)
		if player.GetBySteamID64(invitedby) != false then
			DLabel2:SetText( player.GetBySteamID64(invitedby):Nick())
		else 
			DLabel2:SetText("A Team")
		end
	local DLabel3 = vgui.Create( "DLabel", panel2 )
	DLabel3:Dock(TOP)
	DLabel3:SetText( party.language["Has invited you to their party."])
	 
	local DLabel3 = vgui.Create( "DLabel", panel2 )
	DLabel3:Dock(TOP)
	DLabel3:SetText( party.language["Accept?"])
	
	local panel3 = vgui.Create("DPanel",panel2)
		panel3:Dock(TOP)
		panel3:SetSize(panel2:GetSize(), 20 )
		panel3:SetPos()
		
	function panel3:Paint(w,h)
		panel3:InvalidateLayout(true)
		panel3:SizeToChildren( true, true )
	end
	
	
	 local DButtonyes = vgui.Create( "DButton" )
	DButtonyes:SetParent( panel3 )
	DButtonyes:Dock(LEFT)
	DButtonyes:SetText( party.language["YES"] )
	DButtonyes:SetSize( panel3:GetSize()/2, 20 )
	DButtonyes:SetTextColor(Color( 255,255,255) )
	DButtonyes.DoClick = function()
	LocalPlayer():ConCommand("answerinvite "..invitedby .. " true")
	Frame:Close()
	end
	function DButtonyes:Paint(w,h)
			if !DButtonyes:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttoncolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
		if DButtonyes:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttonhovercolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
	end
	
	
	local DButtonno = vgui.Create( "DButton" )
	DButtonno:SetParent( panel3 )
	DButtonno:Dock(RIGHT)
	DButtonno:SetText( party.language["NO"] )
	DButtonno:SetSize( panel3:GetSize()/2, 20 )
	DButtonno:SetTextColor(Color( 255,255,255) )
	DButtonno.DoClick = function()
		Frame:Close()
		LocalPlayer():ConCommand("answerinvite "..invitedby .. " false")
	end
		function DButtonno:Paint(w,h)
			if !DButtonno:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttoncolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
		if DButtonno:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttonhovercolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
	end	
end
		
		
		
		
		
		
		

function requestMenu(requestedid)
	local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( -500, ScrH()/4 ) 
	Frame:SetSize( 150, 400 ) 
	Frame:SetTitle(  party.language["Request To Join Your Party"] ) 
	Frame:SetVisible( true )
	Frame:SetDraggable( true ) 
	Frame:ShowCloseButton( false )
	--Frame:MakePopup() 
	Frame:SetDeleteOnClose(true)
	Frame:SetVerticalScrollbarEnabled(false)
	Frame:LerpPositions(20,false)
	Frame:SetPos( 0, ScrH()/4 ) 

	function Frame:Paint( w, h )
		draw.RoundedBox( 5, 0, 0, w, h, party.backgroundcolor )
		draw.RoundedBox(5,2,2,w-4,h-4,Color(0,0,0,100))
		draw.RoundedBox(5,4,4,w-8,h-8,Color(0,0,0,100))
		draw.RoundedBox(5,6,6,w-12,h-12,Color(0,0,0,100))
		draw.RoundedBox(5,8,8,w-16,h-16,Color(0,0,0,100))
		Frame:InvalidateLayout(true)
		Frame:SizeToChildren( true, true )
	end
	local DButtonclose = vgui.Create( "DButton" )
	DButtonclose:SetParent( Frame )
	DButtonclose:SetPos( Frame:GetSize(), 5) 
	DButtonclose:SetText( "X" )
	DButtonclose:SetSize( 20, 20 )
	DButtonclose:SetTextColor(Color( 255,255,255) )
	--DButtonclose:Dock(RIGHT)
	DButtonclose.DoClick = function()
	 Frame:Close()
	end
	function DButtonclose:Paint(w,h)
		if !DButtonclose:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttoncolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
		if DButtonclose:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttonhovercolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
	end
	
	local panel2 = vgui.Create("DPanel",Frame)
		panel2:Dock(TOP)
		panel2:SetSize(Frame:GetSize(), 50 )
		panel2:SetPos()
		
		function panel2:Paint(w,h)
			panel2:InvalidateLayout(true)
		panel2:SizeToChildren( true, true )
		end
		
	local DLabel2 = vgui.Create( "DLabel", panel2 )
	DLabel2:Dock(TOP)
	DLabel2:SetText( player.GetBySteamID64(requestedid):Nick())
			
	local DLabel3 = vgui.Create( "DLabel", panel2 )
	DLabel3:Dock(TOP)
	DLabel3:SetText( party.language["Would like to join your party"])
	 
	local DLabel3 = vgui.Create( "DLabel", panel2 )
	DLabel3:Dock(TOP)
	DLabel3:SetText( party.language["Accept?"])
	
	local panel3 = vgui.Create("DPanel",panel2)
		panel3:Dock(TOP)
		panel3:SetSize(panel2:GetSize(), 20 )
		panel3:SetPos()
		
	function panel3:Paint(w,h)
		panel3:InvalidateLayout(true)
		panel3:SizeToChildren( true, true )
	end
	
	
	 local DButtonyes = vgui.Create( "DButton" )
	DButtonyes:SetParent( panel3 )
	DButtonyes:Dock(LEFT)
	DButtonyes:SetText( party.language["YES"] )
	DButtonyes:SetSize( panel3:GetSize()/2, 20 )
	DButtonyes:SetTextColor(Color( 255,255,255) )
	DButtonyes.DoClick = function()
	LocalPlayer():ConCommand("answerjoinrequest "..requestedid .. " true")
	 Frame:Close()
	end
	function DButtonyes:Paint(w,h)
			if !DButtonyes:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttoncolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
		if DButtonyes:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttonhovercolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
	end
	 
	local DButtonno = vgui.Create( "DButton" )
	DButtonno:SetParent( panel3 )
	DButtonno:Dock(RIGHT)
	DButtonno:SetText( party.language["NO"] )
	DButtonno:SetSize( panel3:GetSize()/2, 20 )
	DButtonno:SetTextColor(Color( 255,255,255) )
	DButtonno.DoClick = function()
	 Frame:Close()
	LocalPlayer():ConCommand("answerjoinrequest "..requestedid .. " false")
	 
	end
		function DButtonno:Paint(w,h)
			if !DButtonno:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttoncolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
		if DButtonno:IsHovered() then
			draw.RoundedBox(0,0,0,w,h, party.buttonhovercolor)
			draw.RoundedBox(0,1,1,w-2,h-2,Color(0,0,0,100))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,100))
			draw.RoundedBox(0,3,3,w-6,h-6,Color(0,0,0,100))
			draw.RoundedBox(0,4,4,w-8,h-8,Color(0,0,0,100))
		end
	end	 
end


	 party.framesizex = 500
	 party.framesizey = 300
	 party.rightsize = 250
	 
	 
function PartyMenu()
	local Partytab
	local Partymembs
	PartyFrame = vgui.Create("PartyFrame")
	PartyFrame:SetPos( -500 , ScrH()/4 ) 
	PartyFrame:SetSize( party.framesizex, party.framesizey ) 
	PartyFrame:Configured()
	PartyFrame:SetTitle( party.language["Party Menu"] ) 
	PartyFrame:SetVisible( true )
	PartyFrame:SetDraggable( true )
	PartyFrame:ShowCloseButton(true)
	PartyFrame:MakePopup() 
	PartyFrame:SetDeleteOnClose(true)
	PartyFrame:SetVerticalScrollbarEnabled(false)
	PartyFrame:LerpPositions(20,false)
	PartyFrame:Center()
	
	Partytab = vgui.Create("DPanel", PartyFrame)
	Partytab:SetSize( 250 )
	Partytab:Dock(RIGHT)
	local DLabel = vgui.Create( "PartyLabel", Partytab )
		DLabel:SetColor(Color( 0, 40 , 0 ))
		DLabel:SetText( party.language["Welcome to the party menu!"] )
		DLabel:SizeToContents()
		DLabel:Center()
		DLabel:AlignTop()
	local DLabel = vgui.Create( "PartyLabel", Partytab )
		DLabel:SetColor(Color( 0, 40 , 0 ))
		DLabel:SetText( party.language["An easy way for you to"] )
		DLabel:SizeToContents()
		DLabel:Center()
		DLabel:AlignTop(30)
	local DLabel = vgui.Create( "PartyLabel", Partytab )
		DLabel:SetColor(Color( 0, 40 , 0 ))
		DLabel:SetText( party.language["team up with your friends!"] )
		DLabel:SizeToContents()
		DLabel:Center()
		DLabel:AlignTop(45)	
		


	
	
local Partylist = vgui.Create("PartyCategories", PartyFrame)
	local x, y = PartyFrame:GetSize()
	Partylist:SetSize( 250 )
	Partylist:SetPos( 0, 24 )
	Partylist:Dock(LEFT)
	Partylist:DockMargin(-1,0,0,0)
	Partylist:NewItem(party.language["Start Party"] , Color(75,200,75),function()
		PartyFrame:SetSize( party.framesizex, party.framesizey ) 
		PartyFrame:ShowCloseButton(false)
		PartyFrame:Configured()
		PartyFrame:ShowCloseButton(true)
		if Partytab then
			Partytab:Remove()
		end
		Partytab = vgui.Create("DPanel", PartyFrame)
		Partytab:SetSize( party.rightsize )
		Partytab:Dock(LEFT)
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["WARNING!"] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(30)
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["By starting a new party"] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(45)	
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["you will be removed from"] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(60)			
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["your current party."] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(75)	
			
		local Dtextname
		
		local DButtonStart = vgui.Create( "PartyButton")
		DButtonStart:SetParent( Partytab )
		DButtonStart:SetText( party.language["Start A New Party"] ) 
		DButtonStart:SetSize( Partytab:GetSize()+2, 50 )
		DButtonStart:SetPos( 0, 0 ) 
		DButtonStart:SetTextColor(Color( 255,255,255) )
		DButtonStart:Dock(BOTTOM)
		DButtonStart:DockMargin(-1,0,0,-1)
		DButtonStart.DoClick = function()
			LocalPlayer():ConCommand("StartParty \"" .. string.Left( Dtextname:GetValue(), 20))
			PartyFrame:Close()
		end
		
		Dtextname = vgui.Create( "PartyTextBox")
		Dtextname:SetParent( Partytab )
		Dtextname:SetSize( Partytab:GetSize()+2, 25 )
		Dtextname:SetPos( 0, 0 ) 
		Dtextname:SetTextColor(Color( 0,0,0) )
		Dtextname:Dock(BOTTOM)
		Dtextname:DockMargin(-1,0,0,-1)
	
			local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["Party Name"] )
			DLabel:SizeToContents()
			DLabel:Dock(BOTTOM)
			DLabel:Center()
			
	end, true)
	
	Partylist:NewItem(party.language["Join Party"] , Color(75,75,200),function()
		if Partytab then
			Partytab:Remove()
		end
		PartyFrame:SetSize( party.framesizex, party.framesizey ) 
		PartyFrame:ShowCloseButton(false)
		PartyFrame:Configured()
		PartyFrame:ShowCloseButton(true)
		Partytab = vgui.Create("PartyCategories", PartyFrame)
		Partytab:SetSize( party.rightsize )
		Partytab:Dock(LEFT)

		for v,k in pairs (parties) do
			if !table.HasValue(parties[v].members, LocalPlayer():SteamID64()) then
				Partytab:NewItem(parties[v].name , Color(75,200,75), function()
					PartyFrame:SetSize(party.framesizex + 150 , party.framesizey )
					PartyFrame:ShowCloseButton(false)
					PartyFrame:Configured()
					PartyFrame:ShowCloseButton(true)
					if Partymembs then
						Partymembs:Remove()
					end
					Partymembs = vgui.Create("DPanel", PartyFrame) 
					Partymembs:SetSize(150, party.framesizey - 20)
					Partymembs:Dock(RIGHT)
					
					local DButtonjoin = vgui.Create( "PartyButton", Partymembs )
					DButtonjoin:SetPos( party.framesizex - 20, 0 ) 
					DButtonjoin:SetText( party.language["Members"]  )
					DButtonjoin:SetSize( 20, 20 )
					DButtonjoin:SetTextColor(Color( 255,255,255) )
					DButtonjoin:Dock(TOP)
					DButtonjoin:SetTextColor(Color(0,0,0))
					DButtonjoin.DoClick = function()
					end
				
					DButtonjoin.Paint = function()
						surface.DrawRect(0,0,DButtonjoin:GetWide(),DButtonjoin:GetTall())
						surface.SetDrawColor(Color(26,26,26))
						surface.DrawOutlinedRect(0,0,DButtonjoin:GetWide(),DButtonjoin:GetTall())
					end
				
					
					local Partymembslist = vgui.Create("PartyCategories", Partymembs) 
						Partymembslist:SetSize(150, party.framesizey - 45)
						Partymembslist:Dock(TOP)
						if parties[v] then
							if parties[v].members then
								for v,k in pairs(parties[v].members) do
									if player.GetBySteamID64(k) != false then
										Partymembslist:NewItem(player.GetBySteamID64(k):Nick(), Color(255,255,255,0), function()
										end, false)
									end
								end	
							end
						end
					local DButtonjoin = vgui.Create( "PartyButton", Partymembs )
					DButtonjoin:SetPos( party.framesizex - 20, 0 ) 
					DButtonjoin:SetText( party.language["Request Join"] )
					if table.HasValue(parties[v].members, LocalPlayer():SteamID64()) then
						DButtonjoin:SetDisabled(true)
					end
					if party.AutoGroupedJobs[v] then
						DButtonjoin:SetDisabled(true)
					end
					DButtonjoin:SetSize( 20, 20 )
					DButtonjoin:SetTextColor(Color( 255,255,255) )
					DButtonjoin:Dock(BOTTOM)
					DButtonjoin:DockMargin(-1,0,-1,-1)
					DButtonjoin.DoClick = function()
						LocalPlayer():ConCommand("requestjoin \""..v)
						PartyFrame:Close()
					end
				end, true)
			end
		end
	end, true)
	
	Partylist:NewItem(party.language["Leave Party"] , Color(200,75,75),function()
		PartyFrame:SetSize( party.framesizex, party.framesizey ) 
		PartyFrame:ShowCloseButton(false)
		PartyFrame:Configured()
		PartyFrame:ShowCloseButton(true)
		if Partytab then
			Partytab:Remove()
		end
		Partytab = vgui.Create("DPanel", PartyFrame)
		Partytab:SetSize( party.rightsize )
		Partytab:Dock(LEFT)
		
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["WARNING!"] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(30)
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["By leaving your party"] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(45)	
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["you will no longer be protected"] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(60)			
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["from damage from"] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(75)	
		local DLabel = vgui.Create( "PartyLabel", Partytab )
			DLabel:SetColor(Color( 0, 40 , 0 ))
			DLabel:SetText( party.language["your former party members."] )
			DLabel:SizeToContents()
			DLabel:Center()
			DLabel:AlignTop(90)	
			
		local DButtonStart = vgui.Create( "PartyButton")
		DButtonStart:SetParent( Partytab )
		DButtonStart:SetText( party.language["Leave Current Party" ]) 
		DButtonStart:SetSize( Partytab:GetSize()+2, 50 )
		DButtonStart:SetPos( 0, 0 ) 
		DButtonStart:SetTextColor(Color( 255,255,255) )
		DButtonStart:Dock(BOTTOM)
		DButtonStart:DockMargin(-1,0,0,-1)
		DButtonStart.DoClick = function()
			LocalPlayer():ConCommand("LeaveParty")
			PartyFrame:Close()
		end
	end, true)
	for v, k in pairs(parties) do
		if table.HasValue(parties[v].members, LocalPlayer():SteamID64()) then
			if v == LocalPlayer():SteamID64() then
				Partylist:NewItem(party.language["Manage Party"] , Color(200,100,0),function()
					if Partytab then
						Partytab:Remove()
					end
					PartyFrame:SetSize( party.framesizex, party.framesizey ) 
					PartyFrame:ShowCloseButton(false)
					PartyFrame:Configured()
					PartyFrame:ShowCloseButton(true)
					Partytab = vgui.Create("PartyCategories", PartyFrame)
					Partytab:SetSize( party.rightsize )
					Partytab:Dock(LEFT)
					
					Partytab:NewItem(party.language["Kick From Party"], Color(75,200,75), function()
						PartyFrame:SetSize(party.framesizex + 150 , party.framesizey)
						PartyFrame:ShowCloseButton(false)
						PartyFrame:Configured()
						PartyFrame:ShowCloseButton(true)
						if Partymembs then
							Partymembs:Remove()
						end
						Partymembs = vgui.Create("DPanel", PartyFrame) 
						Partymembs:SetSize(150, party.framesizey - 20 )
						Partymembs:Dock(RIGHT)
						
						local DButton = vgui.Create( "PartyButton", Partymembs )
						DButton:SetPos( party.framesizex - 20, 0 ) 
						DButton:SetText( party.language["Members"]  )
						DButton:SetSize( 20, 20 )
						DButton:SetTextColor(Color( 255,255,255) )
						DButton:Dock(TOP)
						DButton:SetTextColor(Color(0,0,0))
						DButton.DoClick = function()
						end
					
						DButton.Paint = function()
							surface.DrawRect(0,0,DButton:GetWide(),DButton:GetTall())
							surface.SetDrawColor(Color(26,26,26))
							surface.DrawOutlinedRect(0,0,DButton:GetWide(),DButton:GetTall())
						end
						local Partymembslist = vgui.Create("PartyCategories", Partymembs) 
						
						Partymembslist:SetSize(150, party.framesizey - 45)
						Partymembslist:Dock(TOP)
						
						local DButtonkick
						if LocalPlayer():GetParty() != nil then
							for v,k in pairs(parties[LocalPlayer():GetParty()].members) do
								if k != LocalPlayer():SteamID64() then
									if player.GetBySteamID64(k) !=  false then
										Partymembslist:NewItem(player.GetBySteamID64(k):Nick(), Color(255,100,100,255), function()
											if DButtonkick then
												DButtonkick:Remove()
											end
											DButtonkick = vgui.Create( "PartyButton", Partymembs )
												DButtonkick:SetPos( party.framesizex - 20, 0 ) 
												DButtonkick:SetText( party.language["Kick From Party"]  )
												DButtonkick:SetSize( 20, 20 )
												DButtonkick:SetTextColor(Color( 255,255,255) )
												DButtonkick:Dock(BOTTOM)
												DButtonkick:DockMargin(-1,0,-1,-1)
												DButtonkick.DoClick = function()
													Partymembs:Remove()
													LocalPlayer():ConCommand("kickfromparty \""..k)
													PartyFrame:SetSize( party.framesizex, party.framesizey )
													PartyFrame:ShowCloseButton(false)
													PartyFrame:Configured()
													PartyFrame:ShowCloseButton(true)
												end
										end, true)
									else
										Partymembslist:NewItem(party.language["offline"], Color(255,255,255,255), function()
											if DButtonkick then
												DButtonkick:Remove()
											end
											DButtonkick = vgui.Create( "PartyButton", Partymembs )
												DButtonkick:SetPos( party.framesizex - 20, 0 ) 
												DButtonkick:SetText( party.language["Kick From Party"]  )
												DButtonkick:SetSize( 20, 20 )
												DButtonkick:SetTextColor(Color( 255,255,255) )
												DButtonkick:Dock(BOTTOM)
												DButtonkick:DockMargin(-1,0,-1,-1)
												DButtonkick.DoClick = function()
													Partymembs:Remove()
													LocalPlayer():ConCommand("kickfromparty \""..k)
													PartyFrame:SetSize( party.framesizex, party.framesizey )
													PartyFrame:ShowCloseButton(false)
													PartyFrame:Configured()
													PartyFrame:ShowCloseButton(true)
												end
										end, true)									
									end
								end
							end
						end
					end,true)
					
					
					Partytab:NewItem(party.language["Invite To Party"], Color(75,200,75), function()
						PartyFrame:SetSize(party.framesizex + 150 , party.framesizey)
						PartyFrame:ShowCloseButton(false)
						PartyFrame:Configured()
						PartyFrame:ShowCloseButton(true)
						if Partymembs then
							Partymembs:Remove()
						end
						Partymembs = vgui.Create("DPanel", PartyFrame) 
						Partymembs:SetSize(150, party.framesizey - 20)
						Partymembs:Dock(RIGHT)
						
						local DButton = vgui.Create( "PartyButton", Partymembs )
						DButton:SetPos( party.framesizex - 20, 0 ) 
						DButton:SetText( party.language["Players"]  )
						DButton:SetSize( 20, 20 )
						DButton:SetTextColor(Color( 255,255,255) )
						DButton:Dock(TOP)
						DButton:SetTextColor(Color(0,0,0))
						DButton.DoClick = function()
						end
					
						DButton.Paint = function()
							surface.DrawRect(0,0,DButton:GetWide(),DButton:GetTall())
							surface.SetDrawColor(Color(26,26,26))
							surface.DrawOutlinedRect(0,0,DButton:GetWide(),DButton:GetTall())
						end
						local Partymembslist = vgui.Create("PartyCategories", Partymembs) 
						
						Partymembslist:SetSize(150, party.framesizey - 45)
						Partymembslist:Dock(TOP)
						
						local DButtoninvite
						for v,k in pairs(player.GetAll()) do
							if k != LocalPlayer() and !table.HasValue(parties[LocalPlayer():SteamID64()].members, k:SteamID64())then
								Partymembslist:NewItem(k:Nick(), Color(75,200,75,255), function()
									if DButtoninvite then
										DButtoninvite:Remove()
									end
									DButtoninvite = vgui.Create( "PartyButton", Partymembs )
										DButtoninvite:SetPos( party.framesizex - 20, 0 ) 
										DButtoninvite:SetText( party.language["Invite To Party"]  )
										DButtoninvite:SetSize( 20, 20 )
										DButtoninvite:SetTextColor(Color( 255,255,255) )
										DButtoninvite:Dock(BOTTOM)
										DButtoninvite:DockMargin(-1,0,-1,-1)
										DButtoninvite.DoClick = function()
											LocalPlayer():ConCommand("partyinvite \""..k:SteamID64())
										end
								end, true)								
							end
						end
					end,true)
				end, true)
			end
		end
	end
	Partylist:NewItem(party.language["Settings"] , Color(200,75,200),function()
		PartyFrame:SetSize( party.framesizex, party.framesizey ) 
		PartyFrame:ShowCloseButton(false)
		PartyFrame:Configured()
		PartyFrame:ShowCloseButton(true)
		if Partytab then
			Partytab:Remove()
		end
		Partytab = vgui.Create("DPanel", PartyFrame)
		Partytab:SetSize( party.rightsize )
		Partytab:Dock(LEFT)
		
		
		local DLabel = vgui.Create( "PartyLabel", Partytab )
		DLabel:SetColor(Color( 0, 40 , 0 ))
		DLabel:SetText( party.language["Color of party halo"] )
		DLabel:SizeToContents()
		DLabel:Center()
		DLabel:AlignTop(5)
		
		local Partycol = vgui.Create("DPanel", Partytab)
		Partycol:SetPos( 5, 180 )
		Partycol:SetSize( 190, 20 )
		Partycol:SetPaintBackgroundEnabled( true )
		Partycol:SetBackgroundColor( hcol )
		
		local color_picker = vgui.Create( "DRGBPicker", Partytab )
		color_picker:SetPos( 5, 20 )
		color_picker:SetSize( 30, 155 )
		
	local color_cube = vgui.Create( "DColorCube", Partytab )
		color_cube:SetPos( 40, 20 )
		color_cube:SetSize( 155, 155 )
		color_cube:SetColor( hcol )
		
	function color_picker:OnChange( col )

	local h = ColorToHSV( col )
	local _, s, v = ColorToHSV( color_cube:GetRGB() )

	col = HSVToColor( h, s, v )
	color_cube:SetColor( col )
	HaloColorUpdate()
	Partycol:SetBackgroundColor( col )
	end

	function color_cube:OnUserChanged( col )
	hcol = col
	HaloColorUpdate()
	Partycol:SetBackgroundColor( col )
	end
		
	local DermaCheckbox = vgui.Create( "DCheckBox", Partytab )
	DermaCheckbox:SetPos( 5, 205 )
	DermaCheckbox:SetValue( GetConVar( "party_lowend" ):GetInt() )	
	function DermaCheckbox:OnChange(value)
		if value then
		GetConVar( "party_lowend" ):SetInt(1)
		else 
		GetConVar( "party_lowend" ):SetInt(0)
		end
	end
		local DLabel2 = vgui.Create( "PartyLabel", Partytab )
		DLabel2:SetColor(Color( 0, 40 , 0 ))
		DLabel2:SetText( party.language["Lowend Halo"] )
		DLabel2:SizeToContents()
		DLabel2:AlignTop(205)
		DLabel2:AlignLeft(25)
		
	local DermaCheckbox2 = vgui.Create( "DCheckBox", Partytab )
		DermaCheckbox2:SetPos( 5, 225 )
		DermaCheckbox2:SetValue( GetConVar( "party_showhud" ):GetInt() )	
		function DermaCheckbox2:OnChange(value)
			if value then
				GetConVar( "party_showhud" ):SetInt(1)
			else 
				GetConVar( "party_showhud" ):SetInt(0)
			end
		end
		local DLabel3 = vgui.Create( "PartyLabel", Partytab )
		DLabel3:SetColor(Color( 0, 40 , 0 ))
		DLabel3:SetText( party.language["Disable Hud?"] )
		DLabel3:SizeToContents()
		DLabel3:AlignTop(225)
		DLabel3:AlignLeft(25)
		
		
		
		
	end, true)
	
	if LocalPlayer():IsAdmin() then
		Partylist:NewItem(party.language["Admin"] , Color(200,0,0),function()
			PartyFrame:SetSize( party.framesizex, party.framesizey ) 
			PartyFrame:ShowCloseButton(false)
			PartyFrame:Configured()
			PartyFrame:ShowCloseButton(true)
			if Partytab then
				Partytab:Remove()
			end
			Partytab = vgui.Create("PartyCategories", PartyFrame)
			Partytab:SetSize( party.rightsize )
			Partytab:Dock(LEFT)
			
			
			Partytab:NewItem(party.language["Kick From Party"], Color(255,0,0), function()
				PartyFrame:SetSize(party.framesizex + 150 , party.framesizey)
				PartyFrame:ShowCloseButton(false)
				PartyFrame:Configured()
				PartyFrame:ShowCloseButton(true)
				if Partymembs then
					Partymembs:Remove()
				end
				Partymembs = vgui.Create("DPanel", PartyFrame) 
				Partymembs:SetSize(150, party.framesizey - 40)
				Partymembs:Dock(RIGHT)
				
				local DButton = vgui.Create( "PartyButton", Partymembs )
				DButton:SetPos( party.framesizex - 20, 0 ) 
				DButton:SetText( party.language["Members"]  )
				DButton:SetSize( 20, 20 )
				DButton:SetTextColor(Color( 255,255,255) )
				DButton:Dock(TOP)
				DButton:SetTextColor(Color(0,0,0))
				DButton.DoClick = function()
				end
			
				DButton.Paint = function()
					surface.DrawRect(0,0,DButton:GetWide(),DButton:GetTall())
					surface.SetDrawColor(Color(26,26,26))
					surface.DrawOutlinedRect(0,0,DButton:GetWide(),DButton:GetTall())
				end
				local Partymembslist = vgui.Create("PartyCategories", Partymembs) 
				
				Partymembslist:SetSize(150, party.framesizey - 45)
				Partymembslist:Dock(TOP)
				
				local DButtonkick
				for v,k in pairs(player.GetAll()) do
					for t,z in pairs(parties) do
						if table.HasValue(parties[t].members, k:SteamID64()) then
							Partymembslist:NewItem(k:Nick(), Color(255,0,0,255), function()
								if DButtonkick then
									DButtonkick:Remove()
								end
								DButtonkick = vgui.Create( "PartyButton", Partymembs )
								DButtonkick:SetPos( party.framesizex - 20, 0 ) 
								DButtonkick:SetText( party.language["Kick From Party"]  )
								DButtonkick:SetSize( 20, 20 )
								DButtonkick:SetTextColor(Color( 255,255,255) )
								DButtonkick:Dock(BOTTOM)
								DButtonkick:DockMargin(-1,0,-1,-1)
								DButtonkick.DoClick = function()
									Partymembs:Remove()
									LocalPlayer():ConCommand("kickfromparty \""..k:SteamID64())
									PartyFrame:SetSize( party.framesizex, party.framesizey )
									PartyFrame:ShowCloseButton(false)
									PartyFrame:Configured()
									PartyFrame:ShowCloseButton(true)
								end
							end, true)
						end
					end
				end
			end,true)
			
			Partytab:NewItem(party.language["Disban Party"], Color(255,0,0), function()
				PartyFrame:SetSize(party.framesizex + 150 , party.framesizey)
				PartyFrame:ShowCloseButton(false)
				PartyFrame:Configured()
				PartyFrame:ShowCloseButton(true)
				if Partymembs then
					Partymembs:Remove()
				end
				Partymembs = vgui.Create("DPanel", PartyFrame) 
				Partymembs:SetSize(150, party.framesizey - 20)
				Partymembs:Dock(RIGHT)
				
				local DButton = vgui.Create( "PartyButton", Partymembs )
				DButton:SetPos( party.framesizex - 20, 0 ) 
				DButton:SetText( party.language["Parties"]  )
				DButton:SetSize( 20, 20 )
				DButton:SetTextColor(Color( 255,255,255) )
				DButton:Dock(TOP)
				DButton:SetTextColor(Color(0,0,0))
				DButton.DoClick = function()
				end
			
				DButton.Paint = function()
					surface.DrawRect(0,0,DButton:GetWide(),DButton:GetTall())
					surface.SetDrawColor(Color(26,26,26))
					surface.DrawOutlinedRect(0,0,DButton:GetWide(),DButton:GetTall())
				end
				local Partymembslist = vgui.Create("PartyCategories", Partymembs) 
				
				Partymembslist:SetSize(150, party.framesizey - 45)
				Partymembslist:Dock(TOP)
				
				local DButtondsban
				for v,k in pairs(parties) do
					Partymembslist:NewItem(parties[v].name, Color(255,0,0,255), function()
						if DButtondsban then
							DButtondsban:Remove()
						end
						DButtondsban = vgui.Create( "PartyButton", Partymembs )
							DButtondsban:SetPos( party.framesizex - 20, 0 ) 
							DButtondsban:SetText( party.language["Disban Party"] )
							DButtondsban:SetSize( 20, 20 )
							DButtondsban:SetTextColor(Color( 255,255,255) )
							DButtondsban:Dock(BOTTOM)
							DButtondsban:DockMargin(-1,0,-1,-1)
							DButtondsban.DoClick = function()
								Partymembs:Remove()
								LocalPlayer():ConCommand("disbanparty \""..v)
								PartyFrame:SetSize( party.framesizex, party.framesizey )
								PartyFrame:ShowCloseButton(false)
								PartyFrame:Configured()
								PartyFrame:ShowCloseButton(true)
							end
					end, true)
				end
			end,true)
		end, true)
	end
end