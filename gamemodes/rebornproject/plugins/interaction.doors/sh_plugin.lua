
local PLUGIN = PLUGIN

PLUGIN.name = "Doors Interactions"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"


if SERVER then
    ix.util.Include("sv_plugin.lua")
end


--[[
УННВ ft. Gydra - Мёртвое сердце | Dnb Remix Prod.TripSauce

Совсем не бьётся что ли, какое там,
Стучится, как больное, мёртвое оно,
Но слухи ходят, что живое.
Чёрствое, местами с гноем,
Плесенью покрыта, даже кровь в нём запеклась,
И стало твёрдое, как глыба.

В нём обида затаилась, ведь не может просочиться
Сквозь тернистые пучины липко-крепкой паутины.
Метается туда-сюда, найти себе места не может,
Вряд ли поможет, что вылезает из кожи оно.

Жило бы тихо с любовью, но от таких же сердец и дыры тут,
Что не залатать и не заклеить уже,
Как в тире мишень, Боясь пустить, убеждают тебя,
Обманут же снова и предадут, убегая.

Возьмут последнее, суки, с собой.
И вдруг заискрило прощение где-то в глубокой тиши,
Тихо, спокойно дыши, прости их, не мучайся,
Ведь не поздно пока ещё, бьёшься в этой груди, к свету иди.

Хочет покоя только то, что не живое,
Один в поле воин, если своё сердце понял.

———————————No cmbmutant.xyz?———————————
⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
—————————————————————————————————————
]]

ix.config.Add("StealthySpeed", 10, "Как быстро открывается дверь, когда игрок пытается открыть ее незаметно.", nil, {
	data = { min = 1, max = 100 },
	category = PLUGIN.name
})

ix.config.Add("RespawnDoors", 10, "Как быстро зареспавнится дверь в секундах после ее штурма.", nil, {
	data = { min = 10, max = 300 },
	category = PLUGIN.name
})

ix.config.Add("StrengthNeeded", 50, "Сколько силы нужно для штурма двери", nil, {
	data = { min = 0, max = 100 },
	category = PLUGIN.name
})
