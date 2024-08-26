PLUGIN.name = "dthscrn"
PLUGIN.author = ""
PLUGIN.description = "умер мужик."


if (SERVER) then

    util.AddNetworkString("dthscrn")

    hook.Add("PlayerDeath", "dthscrnh1", function(ply, inflictor, attacker )
        ply.umer_i_umer = RealTime()

		local tblcitata = {
		"Если не знаешь, чего хочешь, умрешь в куче того, чего не хотел.", 
		"Потеряв все — обретаешь свободу? Свободу надо искать в себе самом.",
		"Люди действительно готовы продать все, если цена их устроит.",
		"Эй, и `Мона Лиза` потихоньку разрушается....",
		"Люди — рабы своих вещей.",
        "Ни великой войны, ни великой депрессии. Наша война — война духовная.",	
        "Он был полон энергии, видимо, вставил себе клизму из кофе.",	
        "Когда-то мы зачитывались порнографией — теперь каталогами оружия..",		
        "Слова теряют всякий смысл, когда ствол пистолета у тебя во рту.",
        "Когда нибудь - получится..",		
        "Молчишь. Превращаешься в охотника...",	
        "Нелегко уверовать в бога, которого сам создал…",		
        "Голос даже одного человека имеет значение.",	
		"Количество мест в рае ограничено, и только в ад вход всегда свободный.",
		
		}
		local txtfrmtbl = tblcitata[ math.random( #tblcitata )]

        net.Start("dthscrn")
		net.WriteString(txtfrmtbl)
        net.Send(ply)
    end)
    
    hook.Add("PlayerDeathThink", "dthscrnh2", function(ply)
        if ply.umer_i_umer && RealTime() - ply.umer_i_umer < 6 then
            return false
        end
    end)
    
    hook.Add("PlayerDeathSound", "dthscrnh2", function()
        return false
    end)
    
	
else

	surface.CreateFont("dedtxt", {
		font = "сюда свой фонт",
		size = 50,
		weight = 100,
		extended = true
	})

	net.Receive("dthscrn", function(len)
		local ja_v_rot_ebal_neti_netstrimi_lusche = net.ReadString()

		if (!IsValid(maind)) then 

			maind = vgui.Create("DFrame")
			maind:SetSize(ScrW(), ScrH())
			maind:SetPos((ScrW()-maind:GetWide())/2,(ScrH()-maind:GetTall())/2)
			maind:SetTitle("")
			maind:ShowCloseButton(false)
			maind:SetDraggable(false)

			local colorbol = false
			local clr,textc = 0,0

			timer.Simple(1, function() textcolor = false end)

			timer.Simple(5.5, function()
				textcolor = true
				timer.Simple(0.3, function() colorbol = true end)
				timer.Simple(6, function() maind:Close() end)
			end)

			maind.Paint = function(s,w,h)

				if colorbol then
					clr = math.Approach( clr, 0, 1 )
				else
					clr = math.Approach( clr, 255, 5 )
				end

				draw.RoundedBox(0, 0, 0, w, h, Color(20,20,20,clr))

			end

			local DLable = vgui.Create("DLabel", maind)
			DLable:SetSize(maind:GetWide(), maind:GetTall())
			DLable:SetPos(0, 0)
			DLable:SetText("")
			DLable.Paint = function(s,w,h)

				if textcolor then
					textc = math.Approach( textc, 0, 4 )
				else
					textc = math.Approach( textc, 255, 0.5 )
				end
					draw.SimpleText(ja_v_rot_ebal_neti_netstrimi_lusche, "dedtxt", w/2, h/2, Color( 112, 112, 112, textc ), 1, 1)
			end

		end
	end)
end