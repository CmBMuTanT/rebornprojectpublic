
--
-- Copyright (C) 2019 Taxin2012
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--



--	Writed by Taxin2012
--	https://steamcommunity.com/id/Taxin2012/


PLUGIN.AttachData[ "am_slug" ] = {
	Name = "Внутренний стабилизатор для «ГСО»",
	exRender = true,
	Desc = "Фактическая замена некоторых БЗ «Дуплета», «Сайги», «Убойника» и прочего. Новые детали обеспечат повышенную точность при прицеливании, пониженный разброс. Однако, в силу замены частей - понижается убойность оружия, и его фактический естественный урон падает на 10-20%.",
	Price = 2000,
	Model = "models/kek1ch/cleaning_kit_p.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.5,
	iconCam = {
	pos = Vector(15.15, 0.04, 733.91),
	ang = Angle(88.82, 180.25, 0),
	fov = 0.99
	},
	Slot = 1
}

PLUGIN.AttachData[ "autofire" ] = {
	Name = "Набор улучшенной затворно-газоотводной системы для «Подонка»",
	exRender = true,
	Desc = "Механически скорострельность зависит от типа автоматики (газоотводная, с коротким/длинным ходом ствола или затвора) , количества энергии, достающейся автоматике при выстреле, массы движущихся частей автоматики, пружин, замедлителей и прочего. Благодаря этим деталям - «Подонок» превращается в фактический «Пистолет-пулемёт»",
	Price = 2000,
	Model = "models/kek1ch/cleaning_kit_p.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.5,
	iconCam = {
	pos = Vector(15.15, 0.04, 733.91),
	ang = Angle(88.82, 180.25, 0),
	fov = 0.99
	},
	Slot = 9
}

PLUGIN.AttachData[ "mag_big" ] = {
	Name = "Магазинная система увеличенной ёмкости для «РПК74»",
	exRender = true,
	Desc = "Данный магазин в подсумке специфичен своей интеграционной способностью исключительно под автомат «РПК74», и до сих пор никому непонятно зачем было выпускать магазин с отдельной крепёжной частью исключительно под один автомат, исключая многовариативность использования и его интеграцией на другие вариации платформы семейства «АК». Сама магазинная часть выглядит внушительно, и закрепив её на оружии - вы превратите «РПК74» в слабую версию «ДП»",
	Price = 2000,
	Model = "models/kek1ch/armor_repair_pro.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.8,
	iconCam = {
	pos = Vector(200.04, 5.12, 7.23),
	ang = Angle(0.6, -178.5, 0),
	fov = 7.43
	},
	Slot = 2
}

PLUGIN.AttachData[ "mag_ext" ] = {
	Name = "Магазинная система увеличенной ёмкости для «АК-74М»",
	exRender = true,
	Desc = "Специально разработанная система увеличенной емкости магазина для автомата «АК-74М», позволяет превратить вам ваш «АК» в «РПК»! Сам магазин не адаптируется под другие виды автоматов семейства «АК» в силу специальной резьбы. Опять-же, никому не понятно - зачем было делать разделения магазинов по-семейству «АК» на разные категории.. Сами магазины качественны, а в подсумке помимо самих магазинов имеется набор для «БЫСТРОЙ ЗАРЯДКИ ПАТРОНОВ»",
	Price = 2000,
	Model = "models/kek1ch/armor_repair_pro.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.6,
	iconCam = {
	pos = Vector(200.04, 5.12, 7.23),
	ang = Angle(0.6, -178.5, 0),
	fov = 7.43
	},
	Slot = 2
}
 
PLUGIN.AttachData[ "mag_podonok" ] = {
	Name = "Система увеличенного магазина для «Подонка»",
	exRender = true,
	Desc = "Магазинная система позволяющая вам превратить ваш «Подонок» в некое подобие автоматической винтовки, сама магазинная система работает беспрекословно, никаких нареканий нет. В сталкерском сообществе прозвана «ПАКЕТОМ».",
	Price = 2000,
	Model = "models/kek1ch/armor_repair_pro.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.3,
	iconCam = {
	pos = Vector(200.04, 5.12, 7.23),
	ang = Angle(0.6, -178.5, 0),
	fov = 7.43
	},
	Slot = 2
}

PLUGIN.AttachData[ "mag_preved" ] = {
	Name = "Система увеличенного магазина для «Преведа»",
	exRender = true,
	Desc = "Данная магазинная система позволит вам укрепить количество патрон в магазине на противотанковой винтовке «Превед» до 10-ти единиц на один магазин. Из минусов данной системы - её вес. Экипировав этот магазин на тяжелую снайперскую винтовку - в первое время будет тяжело приспособиться к скорости передвижения с ней, связано это с её особенностью в-виде веса..",
	Price = 2000,
	Model = "models/kek1ch/armor_repair_pro.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.8,
	iconCam = {
	pos = Vector(200.04, 5.12, 7.23),
	ang = Angle(0.6, -178.5, 0),
	fov = 7.43
	},
	Slot = 2
}

PLUGIN.AttachData[ "mag_stnd" ] = {
	Name = "Магазинная система увеличенной ёмкости для «АКСУ»",
	exRender = true,
	Desc = "Специально разработанная система увеличенной емкости магазина для автомата «АКСУ», позволяет превратить вам ваш «АКСУ» в «АК-74М»! Сам магазин не адаптируется под другие виды автоматов семейства «АК» в силу специальной резьбы. Опять-же, никому не понятно - зачем было делать разделения магазинов по-семейству «АК» на разные категории.. Сами магазины качественны, а в подсумке помимо самих магазинов имеется набор для «БЫСТРОЙ ЗАРЯДКИ ПАТРОНОВ»",
	Price = 2000,
	Model = "models/kek1ch/armor_repair_pro.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.4,
	iconCam = {
	pos = Vector(200.04, 5.12, 7.23),
	ang = Angle(0.6, -178.5, 0),
	fov = 7.43
	},
	Slot = 2
}

PLUGIN.AttachData[ "mag_valve" ] = {
	Name = "Набор увеличенных магазинов для снайперской винтовки «Вентиль»",
	exRender = true,
	Desc = "С этим набором - вы сможете гарантировать себе больший срок ведения боя с вашим оружием! Имеет небольшое неприятное свойство - большой вес, посему общая рентабельность боевых возможностей на спектре скорости и реакции заметно снижается.",
	Price = 2000,
	Model = "models/kek1ch/armor_repair_pro.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.7,
	iconCam = {
	pos = Vector(200.04, 5.12, 7.23),
	ang = Angle(0.6, -178.5, 0),
	fov = 7.43
	},
	Slot = 2
}

PLUGIN.AttachData[ "metro_2_db_ex_barrel" ] = {
	Name = "Увеличенные стволы для «Дуплета»",
	exRender = true,
	Desc = "Значительно повышает точность огня на средних и дальних дистанциях, но повышает вес оружия и делает его более громоздким, что негативно сказывается на ведении огня на ближней дистанции.",
	Price = 2000,
	Model = "models/weapons/cultist/duplet/att/w_barrel_long.mdl",
	Width = 1,
	Height = 2,
	Weight = 0.5,
	iconCam = {
	pos = Vector(37.34, 0.41, 438.82),
	ang = Angle(83.86, 181.23, 0),
	fov = 0.51
	},
	Slot = 2
}

PLUGIN.AttachData[ "metro_ex_mag" ] = {
	Name = "Барабанный магазин для «Сайги»",
	exRender = true,
	Desc = "Увеличивает емкость магазина, но сильно влияет на стабильность и точность. В отдельных случаях дает ускорение или замедление процесса перезарядки. Никак не влияет на носимый боезапас.",
	Price = 2000,
	Model = "models/weapons/cultist/saiga/att/w_drum.mdl",
	Width = 1,
	Height = 1,
	Weight = 0.9,
	iconCam = {
	pos = Vector(728.02, -8, 93.89),
	ang = Angle(7.66, 179.37, 0),
	fov = 0.73
	},
	Slot = 2
}

 


PLUGIN.AttachData[ "metro_scope_1" ] = {
	Name = "Коллиматорный прицел",
	exRender = true,
	Desc = "Этот прицел довоенного производства значительно облегчает прицеливание на ближних и средних дистанциях, почти не ограничивая поле зрения.",
	Price = 2000,
	Model = "models/attachments/scopes/kollim/kollim.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.6,
	iconCam = {
	pos = Vector(-1.31, -199.84, 7.55),
	ang = Angle(2.28, 89.85, 0),
	fov = 1.08
	},
	Slot = 3
}


PLUGIN.AttachData[ "metro_scope_2" ] = {
	Name = "Оптический прицел",
	exRender = true,
	Desc = "Довоенный оптический прицел облегчает прицеливание на средних дистанциях, но ограничивает поле зрения, что снижает его ценность в тесных тоннелях. Плюсы - Увеличивает прицеливание на средних и дальних дистанциях, и несущественные минусы - Ограничивает поле зрения по бокам.",
	Price = 2000,
	Model = "models/attachments/scopes/default_optika/default_optika.mdl",
	Width = 1,
	Height = 2,
	Weight = 0.8,
	iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(-0.21, 270, 0),
	fov = 1.18
	},
	Slot = 3
}

PLUGIN.AttachData[ "metro_scope_3" ] = {
	Name = "ИК-Прицел",
	exRender = true,
	Desc = "Добытый с обширных армейских складов довоенный прицел ночного видения позволяет уверенно поражать цели в условиях недостаточной освещённости.",
	Price = 2000,
	Model = "models/attachments/scopes/envg_scope/envg_scope.mdl",
	Width = 2,
	Height = 1,
	iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(0.04, 269.39, 0),
	fov = 1.81
	},
	Slot = 3
}


PLUGIN.AttachData[ "metro_scope_valve" ] = {
	Name = "Специализированный прицел для «Вентиля»",
	exRender = true,
	Desc = "Этот снайперский оптический прицел позволяет с лёгкостью разглядеть и поразить цель на дальней дистанции, но сильно ограничивает поле зрения.",
	Price = 2000,
	Model = "models/attachments/scopes/ventil_scope/ventil_scope.mdl",
	Width = 3,
	Height = 1,
	Weight = 0.4,
	iconCam = {
	pos = Vector(-28.24, 733.45, 8.47),
	ang = Angle(0.67, 272.18, 0),
	fov = 1.11
	},
	Slot = 3
}
 


PLUGIN.AttachData[ "r6s_flashhider" ] = {
	Name = "Пламегаситель для «Вентиля»",
	exRender = true,
	Desc = "Снижает отдачу, повышая тем самым точность стрельбы, и гасит ослепляющее стрелка пламя выстрела, что особенно важно в вечной темноте туннелей.",
	Price = 2000,
	Model = "models/kek1ch/cleaning_kit_p.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.4,
	iconCam = {
	pos = Vector(15.15, 0.04, 733.91),
	ang = Angle(88.82, 180.25, 0),
	fov = 0.99
	},
	Slot = 1
}

PLUGIN.AttachData[ "r6s_grip" ] = {
	Name = "Расширенная ложа под «Ашот»",
	exRender = true,
	Desc = "В этом небольшом контейнере лежит ложа которая снижает отдачу, разброс и повышает удобство оружия в ношении. Видна гравировка `K-M`-`АНДРЕЙ КУЗНЕЦ`. Сама ложа удобно лежит в руке, и фактически пистолет превращается в небольшой карманный дробовик, что безусловно не может не сказываться на повышении его убойности.",
	Price = 2000,
	Model = "models/kek1ch/grooming.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.2,
	iconCam = {
	pos = Vector(6.72, -0.02, 199.89),
	ang = Angle(88.07, 179.84, 0),
	fov = 5.45
	},
	Slot = 4
}

PLUGIN.AttachData[ "r6s_grip_bastard" ] = {
	Name = "Приклад под «Ублюдок»",
	exRender = true,
	Desc = "В этом контейнере.. Лежит рукоять, сделанная из стальной полосы с фанерными щёчками которые лучше всего подходят для боя на ближней дистанции, своим закреплением способствуя понижению отдачи и разброса.",
	Price = 2000,
	Model = "models/kek1ch/grooming.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.4,
	iconCam = {
	pos = Vector(6.72, -0.02, 199.89),
	ang = Angle(88.07, 179.84, 0),
	fov = 5.45
	},
	Slot = 5
}

PLUGIN.AttachData[ "r6s_grip_lowlife" ] = {
	Name = "Рукоять под «Подонок»",
	exRender = true,
	Desc = "Лёгкая пистолетная рукоятка, позволяющая снизить вес оружия и его отдачу. По-большей мере используется СБ-ПП станций в офицерском составе, оно и не удивительно - ведь с такими обвесами пистолет превращается в фактический полу-автомат..",
	Price = 2000,
	Model = "models/kek1ch/grooming.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.2,
	iconCam = {
	pos = Vector(6.72, -0.02, 199.89),
	ang = Angle(88.07, 179.84, 0),
	fov = 5.45
	},
	Slot = 6
}

PLUGIN.AttachData[ "r6s_h_barrel" ] = {
	Name = "Ложа под «Револьвер»",
	exRender = true,
	Desc = "Лёгкая фанерная ложа, помогающая удерживать мушку и прицельную точность пистолета в заданной траектории, дополнительно способствует удобству при ношении.",
	Price = 2000,
	Model = "models/kek1ch/grooming.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.3,
	iconCam = {
	pos = Vector(6.72, -0.02, 199.89),
	ang = Angle(88.07, 179.84, 0),
	fov = 5.45
	},
	Slot = 4
}

PLUGIN.AttachData[ "r6s_h_barrel" ] = {
	Name = "Тяжелый оружейный ствол",
	exRender = true,
	Desc = "Этот тяжёлый ствол с продольными проточками значительно повышает наносимый выстрелами урон, фактически видоизменяет оружие добавляя видимости серьезности в лице длинного ствола.",
	Price = 2000,
	Model = "models/attachments/suppressors/vsv_suppressor/vsv_supressor_3.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.6,
	iconCam = {
	pos = Vector(732.75, 10.9, -42.49),
	ang = Angle(-3.32, 180.84, 0),
	fov = 0.86
	},
	Slot = 1
}
 

PLUGIN.AttachData[ "r6s_radiator" ] = {
	Name = "Радиатор для «Ублюдка»",
	exRender = true,
	Desc = "В этой небольшой, казалось бы упаковке - лежит весь инсрументарий который при установке устранит один из главных недостатков Ублюдка - склонность к перегреву, отводя тепло от ствола при помощи нескольких продольных рёбер охлаждения.",
	Price = 2000,
	Model = "models/kek1ch/itm_selfrol.mdl",
	Width = 1,
	Height = 2,
	Weight = 0.4,
	iconCam = {
	pos = Vector(7.83, -0.01, 734.03),
	ang = Angle(89.41, 179.52, 0),
	fov = 0.84
	},
	Slot = 5
}

PLUGIN.AttachData[ "r6s_solid_grip" ] = {
	Name = "Приклад под «Ашот»",
	exRender = true,
	Desc = "Лёгкий металлический приклад, помогающий удерживать оружие и его прицельную составляющую.",
	Price = 2000,
	Model = "models/kek1ch/grooming.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.3,
	iconCam = {
	pos = Vector(6.72, -0.02, 199.89),
	ang = Angle(88.07, 179.84, 0),
	fov = 5.45
	},
	Slot = 4
}

PLUGIN.AttachData[ "r6s_solid_grip_lowlife" ] = {
	Name = "Ручная ложа под «Подонок»",
	exRender = true,
	Desc = "Деревянный приклад с вырезом обеспечивает удобное положение руки, дополнительно снижает отдачу и разброс пуль.. В народе кличется ",
	Price = 2000,
	Model = "models/kek1ch/grooming.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.4,
	iconCam = {
	pos = Vector(6.72, -0.02, 199.89),
	ang = Angle(88.07, 179.84, 0),
	fov = 5.45
	},
	Slot = 5
}

PLUGIN.AttachData[ "r6s_suppr" ] = {
	Name = "«Глушитель»",
	exRender = true,
	Desc = "Глушитель - гасит пламя и значительно снижает шум выстрела, несколько повышает кучность. Снижает скорость пуль, из-за чего убойная сила на расстоянии падает.",
	Price = 2000,
	Model = "models/attachments/suppressors/default_suppressor/default_suppressor.mdl",
	Width = 2,
	Height = 1,
	Weight = 0.9,
	iconCam = {
	pos = Vector(-6.84, -668.42, 303.41),
	ang = Angle(24.42, 89.41, 0),
	fov = 0.79
	},
	Slot = 1
}


 
