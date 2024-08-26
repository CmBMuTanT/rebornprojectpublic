local AdminsR = { -- ranks allowed to view admin menu
    ["founder"] = true,
    ["superadmin"] = true,
    ["admin"] = true
}

local ReportCooldown = 30 -- Seconds of cooldown between reports, Keep it fairly high to stop potential spam
/*---------------------------------------------------------------------------
End of config
---------------------------------------------------------------------------*/
vReports = vReports or {}
util.AddNetworkString("vReportMenu")

util.AddNetworkString("vAReportMenu")

util.AddNetworkString("vAUpdate")

local function doReport(nick, steamid, data)
	table.insert(vReports,{nick = nick, steamid = steamid, data = data,time = os.date( "%X", os.time() ),claimed = false})
end

local function notifyAdmins()
	for k,v in pairs(player.GetAll()) do
		if AdminsR[v:GetUserGroup()] then
			v:SendLua([[chat.AddText(Color(255,0,0),"Подали жалобу, пожалуйста проверьте !ra")]])
		end
	end
end

hook.Add("PlayerSay","Handle vReport",function(ply, txt)
	if txt:lower():match("^@") and not AdminsR[ply:GetUserGroup()] then
		ply:ChatPrint("Please use !report <issue>.")
		return "" 
	end
	
	local txtTbl = string.Explode( " ", txt )
	
	if txtTbl[1] and txtTbl[1] == "!report" then
		if txtTbl[2] then
			if (ply.NextReportTime or 0) > CurTime() then return ply:ChatPrint("Не так быстро! Подождите ещё ".. math.floor(ply.NextReportTime) .."с. перед следующим репортом!") end
			ply.NextReportTime = CurTime() + 50

			local issue = ""
			for k, v in pairs(txtTbl) do
				if v == "!report" then continue end
				issue = issue .. " " .. v
			end
			doReport(ply:Nick(), ply:SteamID(), issue)
			ply:ChatPrint("Report sent in! Please wait for an admin to respond.")
			notifyAdmins()
		else
			ply:ChatPrint("Usage: !report <issue>")
		end
		return ""
	end
	
	if txtTbl[1] and txtTbl[1] == "!ra" and AdminsR[ply:GetUserGroup()] then
		net.Start("vAReportMenu")
		net.WriteTable(vReports)
		net.Send(ply)
		return ""
	end
end)

hook.Add("PlayerDisconnected","Handle vReport leaves",function(ply)
	for k,v in pairs(vReports) do
		if v["claimed"] == ply then
			vReports[k]["claimed"] = false
		end
	end
end)

net.Receive("vAReportMenu",function(_,ply)
	if not AdminsR[ply:GetUserGroup()] then return end
	local s = net.ReadString()
	if s == "claim" then
		local i = net.ReadInt(32)
		vReports[i]["claimed"] = ply
		for k,v in pairs(player.GetAll()) do
			if AdminsR[v:GetUserGroup()] then
				net.Start("vAUpdate")
				net.WriteTable(vReports)
				net.Send(v)
			end
		end
	end
	if s == "delete" then
		local i = net.ReadInt(32)
		vReports[i] = nil
		for k,v in pairs(player.GetAll()) do
			if AdminsR[v:GetUserGroup()] then
				net.Start("vAUpdate")
				net.WriteTable(vReports)
				net.Send(v)
			end
		end
	end
	if s == "finish" then
		local i = net.ReadInt(32)
		vReports[i] = nil
		for k,v in pairs(player.GetAll()) do
			if AdminsR[v:GetUserGroup()] then
				net.Start("vAUpdate")
				net.WriteTable(vReports)
				net.Send(v)
			end
		end
	end
end)