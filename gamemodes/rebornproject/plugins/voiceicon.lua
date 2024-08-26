PLUGIN.name = "Draw voice icon"
PLUGIN.author = ""
PLUGIN.description = ""

ix.lang.AddTable("russian", {
	optShowVoiceIcons = "Иконка активного голосового чата",
    optdShowVoiceIcons = "Включает отображение иконки в нижней части экрана при активном голосовом чате",
})

CreateConVar('talkicon_showtextchat', 0, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE, 'Show icon on using text chat.')

local voice_mat = {
	[1] = Material("icons/hud_voice2.png"), -- крик
	[2] = Material("icons/hud_voice1.png"), -- разговор
	[3] = Material("icons/hud_voice3.png") -- шепот
	} 

if (SERVER) then

	RunConsoleCommand('mp_show_voice_icons', '0')
	RunConsoleCommand('talkicon_showtextchat', '0')

	resource.AddFile('materials/talkicon/voice.png')
	resource.AddFile('materials/talkicon/text.png')

	util.AddNetworkString('TalkIconChat')
		
	net.Receive('TalkIconChat', function(_, ply)
		local bool = net.ReadBool()
		ply:SetNW2Bool('ti_istyping', (bool ~= nil) and bool or false)
	end)

elseif (CLIENT) then

	ix.option.Add("showVoiceIcons", ix.type.bool, true, {
		category = "general"
	})

	local showtextchat = GetConVar('talkicon_showtextchat')
	local text_mat = Material('talkicon/text.png')

	hook.Add('PostPlayerDraw', 'TalkIcon', function(ply)
		if ply == LocalPlayer() and GetViewEntity() == LocalPlayer()
			and (GetConVar('thirdperson') and GetConVar('thirdperson'):GetInt() != 0) then return end
		if not ply:Alive() then return end
		if not ply:IsSpeaking() and not (showtextchat:GetBool() and ply:GetNW2Bool('ti_istyping')) then return end

		local pos = ply:GetPos() + Vector(0, 0, ply:GetModelRadius() + 15)

		local attachment = ply:GetAttachment(ply:LookupAttachment('eyes'))
		if attachment then
			pos = ply:GetAttachment(ply:LookupAttachment('eyes')).Pos + Vector(0, 0, 10)
		end

		if (ply:GetNetVar("voiceicon") == 1) then
			render.SetMaterial(ply:IsSpeaking() and voice_mat[3])
		elseif (ply:GetNetVar("voiceicon") == 2) then
			render.SetMaterial(ply:IsSpeaking() and voice_mat[2])
		elseif (ply:GetNetVar("voiceicon") == 3) then
			render.SetMaterial(ply:IsSpeaking() and voice_mat[1])
		else
			render.SetMaterial(ply:IsSpeaking() and text_mat)
		end

		local computed_color = render.ComputeLighting(ply:GetPos(), Vector(0, 0, 1))
		local max = math.max(computed_color.x, computed_color.y, computed_color.z)
		color_var = math.Clamp(max * 255 * 1.11, 0, 255)

		render.DrawSprite(pos, 6, 6, Color(255, 161, 73, 255))
	end)

	hook.Add("InitPostEntity", "RemoveChatBubble", function()
		hook.Remove("StartChat", "StartChatIndicator")
		hook.Remove("FinishChat", "EndChatIndicator")

		hook.Remove("PostPlayerDraw", "DarkRP_ChatIndicator")
		hook.Remove("CreateClientsideRagdoll", "DarkRP_ChatIndicator")
		hook.Remove("player_disconnect", "DarkRP_ChatIndicator")
	end)

	derma.DefineControl( "VoiceNotify", "", {}, "DPanel" )
	hook.Remove( "InitPostEntity", "CreateVoiceVGUI" )

	local Icon = Material("icons/hud_voice1.png")

	local function drawVoiceHUD()
		surface.SetDrawColor( ix.config.Get("color") )

		if (LocalPlayer():GetLocalVar("voicedistance") == 1) then
			surface.SetMaterial( voice_mat[3] )
		elseif (LocalPlayer():GetLocalVar("voicedistance") == 2) then
			surface.SetMaterial( voice_mat[2] )
		elseif (LocalPlayer():GetLocalVar("voicedistance") == 3) then
			surface.SetMaterial( voice_mat[1] )
		else
			surface.SetMaterial( text_mat )
		end
		surface.DrawTexturedRect( ScrW() / 2 - 30, ScrH() /  1.1, 50, 50 )
	end

	function PLUGIN:PlayerStartVoice(client)
		if client ~= LocalPlayer() then return end
		if (ix.option.Get("showVoiceIcons", true)) then
			hook.Add("HUDPaint", "VoiceHUD", drawVoiceHUD)
		end
	end

	function PLUGIN:PlayerEndVoice(client)
		if client ~= LocalPlayer() then return end
		hook.Remove("HUDPaint", "VoiceHUD")
	end


end