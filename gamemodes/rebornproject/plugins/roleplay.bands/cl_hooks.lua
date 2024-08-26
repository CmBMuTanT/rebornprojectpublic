local bands = { --taka tablica, żeby nie zapierdalać po tabelach itemku
	["hanza"] = {Color(102, 51, 51),"Повязка «Проспект Мира»"},
	["kl"] = {Color(192, 57, 43),"Повязка «Лубянка»"},
	["banditi"] = {Color(39, 174, 96),"Повязка «Китай-Город»"},
	["polis"] = {Color(41, 128, 185),"Повязка «Арбатская»"},
	["sparta"] = {Color(221, 221, 221),"Жетон «SПАРТА»"},
	["vdnh"] = {Color(241, 196, 15),"Подвеска «Золотой патрон»"},
	["reich"] = {Color(0,0,0),"Повязка «Пушкинская»"}
}

function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
	local band = client:GetNW2String("band",false) --string z typem opaski, czyli można rzec, że kolorem
	if band then --jako, że po zdjęciu banda NWString jest nilem to można zajebać takiego checka
		local panel = tooltip:AddRowAfter("name", "band")
		panel:SetBackgroundColor(bands[band][1]) 
		panel:SetText(bands[band][2])
		panel:SizeToContents()
    end
end	
