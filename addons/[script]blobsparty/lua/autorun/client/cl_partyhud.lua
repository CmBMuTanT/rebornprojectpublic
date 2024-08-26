--GUI base created by billy
--https://scriptfodder.com/users/view/76561198040894045/scripts


local Party = {}
local disconnectedicon = "icon16/disconnect.png"
local leadericon = "icon16/award_star_gold_1.png"
local wantedicon = "icon16/exclamation.png"
CreateClientConVar("party.hudhorizontalpos", 0, true)
CreateClientConVar("party.hudverticalpos", party.hudverticalpos, true)
party.hudverticalpos = GetConVar( "party.hudverticalpos" ):GetInt()
party.hudhorizontalpos = GetConVar( "party.hudhorizontalpos" ):GetInt()

surface.CreateFont("roboto16",{
	size = 16,
	font = "Roboto",
})


hook.Add( "HUDPaint", "drawpartyhud", function()
	if GetConVar( "party_showhud" ):GetInt() != 1 then
		if parties != nil and parties[LocalPlayer():GetParty()] != nil and parties[LocalPlayer():GetParty()].members != nil then
			draw.DrawText(party.language["Party Name"] ..": " ..parties[LocalPlayer():GetParty()].name, "roboto16", party.hudhorizontalpos, party.hudverticalpos, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			for v,k in pairs (parties[LocalPlayer():GetParty()].members) do
				local position = v * 55 - 30 + v * 5 + party.hudverticalpos
				local member = player.GetBySteamID64(k)
				draw.RoundedBox(5,party.hudhorizontalpos,position,150,55, party.backgroundcolor ) 
				draw.RoundedBox(5,3+ party.hudhorizontalpos,position+3,150-6,55-6,Color(0,0,0,200))
				if player.GetBySteamID64(k) !=  false then
				local health =  math.Clamp(100*(1/(member:GetMaxHealth() / member:Health())),0,100)
				local armor = math.Clamp(  member:Armor(), 0, 100 )
				draw.RoundedBoxEx( 0, 5+ party.hudhorizontalpos, position + 45 , 2.1* health/1.5, 5, Color( 200, 25, 25, 255 ), true, true, true, true )
				draw.RoundedBoxEx( 0, 5+ party.hudhorizontalpos, position + 48 , 2.1* armor/1.5, 3, Color( 25, 25, 200, 255 ), true, true, true, true )
				draw.DrawText(string.Left(member:Nick(), 18), "roboto16", 5+ party.hudhorizontalpos, position+ 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				else 
				draw.DrawText(party.language["offline"] , "roboto16", 5+ party.hudhorizontalpos, position+ 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				end
				if player.GetBySteamID64(k) !=  false then
					if member:Alive() then
					draw.DrawText(member:Health().."/"..member:GetMaxHealth(), "roboto16", 5+ party.hudhorizontalpos, position+ 25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					else
					draw.DrawText( party.language["Dead"] , "roboto16", 5+ party.hudhorizontalpos, position+ 25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					end
					if (DarkRP) then
						if member:getDarkRPVar("job") != nil then
							if string.len(member:getDarkRPVar("job")) >= 15 then
								draw.DrawText( string.Left(member:getDarkRPVar("job"), 13 ).."..", "roboto16", 145+ party.hudhorizontalpos, position+ 25, team.GetColor( member:Team( ) ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
							else
								draw.DrawText( string.Left(member:getDarkRPVar("job"), 16 ), "roboto16", 145+ party.hudhorizontalpos, position+ 25, team.GetColor( member:Team( ) ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
							end
						end
						if member:isWanted() then
							surface.SetMaterial( Material( wantedicon ) )
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.DrawTexturedRect( 155+ party.hudhorizontalpos, position + 34, 16, 16 )
						else
							surface.SetMaterial( Material( wantedicon ) )
							surface.SetDrawColor( 255, 255, 255, party.fadediconsfadeamount )
							surface.DrawTexturedRect( 155+ party.hudhorizontalpos, position+ 34, 16, 16 )				
						end
					end
				end
				if player.GetBySteamID64(k) != false then
					surface.SetMaterial( Material( disconnectedicon ) )
					surface.SetDrawColor( 255, 255, 255, party.fadediconsfadeamount )
					surface.DrawTexturedRect( 155+ party.hudhorizontalpos, position + 16, 16, 16 )
				else
					surface.SetMaterial( Material( disconnectedicon ) )
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.DrawTexturedRect( 155+ party.hudhorizontalpos, position+ 16, 16, 16 )				
				end
				
				if k == LocalPlayer():GetParty() then
					surface.SetMaterial( Material( leadericon ) )
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.DrawTexturedRect( 155+ party.hudhorizontalpos, position + 0, 16, 16 )
				else
					surface.SetMaterial( Material( leadericon ) )
					surface.SetDrawColor( 255, 255, 255, party.fadediconsfadeamount )
					surface.DrawTexturedRect( 155+ party.hudhorizontalpos, position+ 0, 16, 16 )				
				end	
			end
		end
		
	end
	
end)

local function PartyOpenCon()
if ( IsValid( Party_Panel ) ) then Party_Panel:Remove() end
	if parties[LocalPlayer():GetParty()] then
		Party_Panel = vgui.Create("DFrame", g_ContextMenu)
		Party_Panel:SetPos(party.hudhorizontalpos, party.hudverticalpos)
		Party_Panel:SetSize( 175, #parties[LocalPlayer():GetParty()].members * 60 + 30)
		Party_Panel:ShowCloseButton(false)
		Party_Panel:SetTitle("")
		--↔↕
		--Party_Paneldp = vgui.Create( "DPanel", g_ContextMenu )
		Party_Panel:SetMouseInputEnabled(true)
		function Party_Panel.Paint()
			if parties[LocalPlayer():GetParty()] then
				draw.RoundedBox(5,0,0, 175, #parties[LocalPlayer():GetParty()].members * 60 + 30, Color( 25, 25, 25, 50 ) ) 
				draw.DrawText("↕", "roboto16", 165,0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.DrawText("↔", "roboto16", 165,0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				local hudx,hudy = Party_Panel:GetPos()
				party.hudhorizontalpos , party.hudverticalpos = math.Clamp(hudx , 0,ScrW() - 175) , math.Clamp(hudy , 0, ScrH() - (#parties[LocalPlayer():GetParty()].members * 60 + 30))
			end
		end
		if parties[LocalPlayer():SteamID64()] then
			for v,k in pairs (parties[LocalPlayer():GetParty()].members) do
				local position = (v * 60 + 2 )
				Party_PanelButton = vgui.Create( "PartyButton", Party_Panel)
				Party_PanelButton:SetText(party.language["Kick"])
				Party_PanelButton:SetPos(97, position)
				Party_PanelButton:SetSize(50, 20)
				function Party_PanelButton:DoClick() -- Defines what should happen when the label is clicked
					self:Remove()
					LocalPlayer():ConCommand("kickfromparty \""..k)
				end
			end
		end
	end
end
hook.Add( "OnContextMenuOpen", "PartyOpenCon", PartyOpenCon )

local function PartyCloseCon()
	GetConVar( "party.hudhorizontalpos" ):SetInt( party.hudhorizontalpos)
	GetConVar( "party.hudverticalpos" ):SetInt(party.hudverticalpos)
end
hook.Add( "OnContextMenuClose", "PartyCloseCon", PartyCloseCon )