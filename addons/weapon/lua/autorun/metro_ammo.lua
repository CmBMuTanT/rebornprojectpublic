
function AddMetroAmmoType(name, nicename)

	game.AddAmmoType({name = name,
	dmgtype = DMG_BULLET})
	
	if CLIENT then
		language.Add(name, nicename)
	end
	
end

AddMetroAmmoType("metro_avtomat", "5.45x39 мм ПП")

AddMetroAmmoType("metro_arrow", "Стрелы")

AddMetroAmmoType("metro_pistol", ".44 Магнум")

AddMetroAmmoType("metro_sniper", "7.62x54 мм")

AddMetroAmmoType("metro_shotgun", "Картечь")

AddMetroAmmoType("metro_fuel", "Топливо")

AddMetroAmmoType("metro_shariki", "Шарики")

AddMetroAmmoType("metro_granate", "Заряд Медведя")

AddMetroAmmoType("metro_gat", "Патрон Гатлинг")