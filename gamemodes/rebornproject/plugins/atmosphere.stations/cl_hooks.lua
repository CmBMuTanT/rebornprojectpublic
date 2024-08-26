local PLUGIN = PLUGIN

netstream.Hook("ixPlayCassete", function(ent)
    if ent then
        local panel = vgui.Create("ixCassete")
        panel.ent = ent
    end
end)

timer.Create("ixMusicPlay", 0.1, 0, function()
	for i, ent in ipairs(ents.FindByClass("ix_item")) do
		local music = ent:GetNetVar("CurMusic")
		if not music then continue end

		--print(music)

		if IsValid(ent._MusicStream) then
			local stream = ent._MusicStream

			--print("Playing")
			--print("SetPos, SetVolume, SetTime...")

			local time = tonumber(ent:GetNWInt("ixMusicRewind", 0))
			if time ~= ent._LastSetTime then
				stream:SetTime(time)
				if not IsValid(stream) then return end
				ent._LastSetTime = time
			end

			local vol = ent:GetNWInt("ixMusicVolume", 100)
			if vol ~= ent._LastSetVolume then
				stream:SetVolume(vol)
				ent._LastSetVolume = vol
			end

			stream:SetPos(ent:GetPos())
		else
			--print("Start")
			sound.PlayFile("sound/".. music, "3d", function(stream)
				--print("Stared")
				if not IsValid(stream) then return end
				--print("Valid Started")

				if not IsValid(ent) then
					return stream:Stop()
				end

				--print("Valid ent")

				stream:Play()
				if not IsValid(stream) then return end

				--print("SetPos, SetVolume, SetTime...")

				ent._MusicStream = stream

				local vol = ent:GetNWInt("ixMusicVolume", 100)
				stream:SetVolume(vol)
				ent._LastSetVolume = vol

				if not IsValid(stream) then return end

				stream:SetPos(ent:GetPos())

				local time = tonumber(ent:GetNWInt("ixMusicRewind", 0))
				stream:SetTime(time)
				if not IsValid(stream) then return end
				ent._LastSetTime = time

				local h_name = "ixMusic/".. tostring(ent) .."/".. tostring(stream)
				hook.Add("Think", h_name, function()
					if not IsValid(stream) then return hook.Remove("Think", h_name) end
					if not IsValid(ent) or not ent:GetNetVar("CurMusic") then
						hook.Remove("Think", h_name)
						stream:Stop()
					end
				end)
			end)
		end
	end
end)

net.Receive("ixMusicVolume", function()
	local ent = net.ReadEntity()
	if not IsValid(ent._MusicStream) then return end

	local function save(vol)
		net.Start("ixMusicVolume")
			net.WriteEntity(ent)
			net.WriteUInt(vol, 7)
		net.SendToServer()
	end

	local menu = vgui.Create("DFrame")
	menu:SetSize(256, 64)
	menu:Center()
	menu:MakePopup()
	menu:SetTitle("Громкость музыки")
	menu.Think = function(me)
		if not (IsValid(ent) and IsValid(ent._MusicStream)) then
			me:Remove()
		end
	end

	local vol = ent:GetNWInt("ixMusicVolume", 100)

	local slider = menu:Add("DPanel")
	slider:Dock(FILL)
	slider.PaintOver = function(me, w, h)
		surface.SetDrawColor(40, 149, 220)
		surface.DrawRect(0, 0, w / 100 * vol, h)
	end
	slider.OnMousePressed = function(me, mcode)
		if mcode ~= MOUSE_LEFT then return end

		me.Draging = true
	end
	slider.Think = function(me)
		--if vol ~= ent:GetNWInt("ixMusicVolume", 100) then
		--	vol = ent:GetNWInt("ixMusicVolume", 100)
		--end

		if not me.Draging then return end
	    if not input.IsMouseDown(MOUSE_LEFT) then
	    	me.Draging = nil
	    	save(math.floor(vol))
	    	return
	    end

	    local mouseX = me:CursorPos() / me:GetWide() * 100
	    vol = math.Clamp(mouseX, 0, 100)
	end
end)

function formatTime(time)
  local minutes = math.floor(math.mod(time,3600)/60)
  local seconds = math.floor(math.mod(time,60))
  return string.format("%02d:%02d", minutes, seconds)
end

net.Receive("ixMusicRewind", function()
	local ent = net.ReadEntity()
	if not IsValid(ent._MusicStream) then return end

	local function save(vol)
		net.Start("ixMusicRewind")
			net.WriteEntity(ent)
			net.WriteUInt(vol, 32)
		net.SendToServer()
	end

	local menu = vgui.Create("DFrame")
	menu:SetSize(256, 64)
	menu:Center()
	menu:MakePopup()
	menu:SetTitle("Перемотка")
	menu.Think = function(me)
		if not (IsValid(ent) and IsValid(ent._MusicStream)) then
			me:Remove()
		end
	end

	local len = ent._MusicStream:GetLength()
	local curPos = ent._MusicStream:GetTime()

	local slider = menu:Add("DPanel")
	slider:Dock(FILL)
	slider.PaintOver = function(me, w, h)
		surface.SetDrawColor(40, 149, 220)
		surface.DrawRect(0, 0, w * (curPos / len), h)
	end
	slider.OnMousePressed = function(me, mcode)
		if mcode ~= MOUSE_LEFT then return end

		me.Draging = true
	end
	slider.Think = function(me)
		--local len2 = ent._MusicStream:GetLength()
		--if len ~= len2 then
		--	len = len2
		--end

		if not me.Draging then
			curPos = ent._MusicStream:GetTime()
			return menu:SetTitle("Перемотка ".. formatTime(ent._MusicStream:GetTime()))
		end
	    if input.IsMouseDown(MOUSE_LEFT) then
	    	curPos = ent._MusicStream:GetTime()
	    else
	    	me.Draging = nil
	    	save(math.floor(curPos))
	    	return
	    end

	    local mouseX = me:CursorPos() / me:GetWide()
	    curPos = math.Clamp(mouseX * len, 0, len)
	    --chat.AddText(formatTime(curPos))
	end
end)