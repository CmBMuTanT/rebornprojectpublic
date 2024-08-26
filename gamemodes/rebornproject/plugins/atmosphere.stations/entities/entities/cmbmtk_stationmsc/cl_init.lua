include("shared.lua")

surface.CreateFont( "TF2R_SongListFont", {
	font = "Arial",
	extended = false,
	size = 20,
	weight = 1500,
} )

surface.CreateFont( "TF2R_MainFont", {
	font = "Arial",
	extended = false,
	size = 48,
	weight = 1500,
} )

surface.CreateFont( "TF2R_MainFontAlt", {
	font = "Arial",
	extended = false,
	size = 34,
	weight = 1500,
} )

surface.CreateFont( "TF2R_MainFontSmall", {
	font = "Arial",
	extended = false,
	size = 25,
	weight = 1500,
} )

surface.CreateFont( "TF2R_MainFontSmallAlt", {
	font = "Arial",
	extended = false,
	size = 15,
	weight = 1500,
} )

local TF2R_SongTable = {}
 
function ENT:Draw()
	self:DrawModel()
end

function TF2R_OpenSongMenu()

	surface.PlaySound("ui/buttonrollover.wav")

	local RadioPanel = vgui.Create("DFrame")
	RadioPanel:SetSize(500,400)
	RadioPanel:Center()
	RadioPanel:MakePopup()
	RadioPanel:SetTitle("")
	RadioPanel.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0, 0, 0))
		draw.RoundedBox(0,2,2,w-4,h-4,Color(139, 69, 19))

		draw.DrawText("Музыкальная Станция","TF2R_MainFontSmall",5,5,Color(255,255,255),TEXT_ALIGN_LEFT)
		draw.DrawText("Загружено "..#TF2R_SongTable .." композиций. Выбери один из треков, чтобы проиграть его","TF2R_MainFontSmallAlt",7.5,25,Color(255,255,255),TEXT_ALIGN_LEFT)
	end
	
	local TF2R_SongListPanel = vgui.Create( "DFrame", RadioPanel ) 
	TF2R_SongListPanel:ShowCloseButton(false)
	TF2R_SongListPanel:SetDraggable(false)           
	TF2R_SongListPanel:SetPos( 5, 20 )	
	TF2R_SongListPanel:SetTitle("")			
	TF2R_SongListPanel:SetSize( 505, 380 )
	TF2R_SongListPanel.Paint = function(s,w,h)

	end

	local TF2R_SongList = vgui.Create( "DScrollPanel", TF2R_SongListPanel )
	TF2R_SongList:Dock( FILL )

	local TF2R_SongListBtn = TF2R_SongList:Add( "DButton" )
	TF2R_SongListBtn:Dock( TOP )
	TF2R_SongListBtn:SetText("")
	TF2R_SongListBtn:SetSize(0,30)
	TF2R_SongListBtn:DockMargin( 0, 0, 0, 5 )
	TF2R_SongListBtn.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0, 0, 0))
		draw.RoundedBox(0,2,2,w-4,h-4,Color(160, 82, 45))

		draw.DrawText("Выключить","TF2R_MainFontSmall",w/2,2,Color(255,255,255),TEXT_ALIGN_CENTER)

	end
	TF2R_SongListBtn.DoClick = function()
		net.Start("TF2R_SelectedSong")
			net.WriteFloat(0)
		net.SendToServer()
	end

	for k, v in pairs(TF2R_SongTable) do
		local TF2R_SongListBtn = TF2R_SongList:Add( "DButton" )
		TF2R_SongListBtn:Dock( TOP )
		TF2R_SongListBtn:SetText("")
		TF2R_SongListBtn:SetSize(0,30)
		TF2R_SongListBtn:DockMargin( 0, 0, 0, 5 )
		TF2R_SongListBtn.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0, 0, 0))
			draw.RoundedBox(0,2,2,w-4,h-4,Color(160, 82, 45))

			draw.DrawText(string.upper(string.sub(v,4,string.len(v)-4)),"TF2R_MainFontSmall",w/2,2,Color(255,255,255),TEXT_ALIGN_CENTER)
		end
		TF2R_SongListBtn.DoClick = function()
			net.Start("TF2R_SelectedSong")
				net.WriteFloat(k)
			net.SendToServer()
		end
	end

	local scrollbar = TF2R_SongList:GetVBar()
	function scrollbar:Paint( w, h )end
	function scrollbar.btnUp:Paint( w, h )end
	function scrollbar.btnDown:Paint( w, h )end
	function scrollbar.btnGrip:Paint( w, h )end

end

net.Receive("TF2R_OpenSongMenu",function()
	TF2R_SongTable = net.ReadTable()
	TF2R_OpenSongMenu()
end)