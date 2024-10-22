
local PLUGIN = PLUGIN
local function b(d)
    local e={}
    e.start=d:EyePos()
    e.endpos=e.start+d:GetForward()*20 
    e.filter=d 
    if (!util.TraceLine(e).Hit) then 
        return"@faceWall"
    end 
end 
local function c(d)
    local e={}
    e.start=d:LocalToWorld(d:OBBCenter())
    e.endpos=e.start-d:GetForward()*20 
    e.filter=d 
    if (!util.TraceLine(e).Hit) then 
        return"@faceWallBack"
    end 
end 

hook.Add("SetupActs",PLUGIN.uniqueID.."SetupActs",function()
    ix.act.Register("Sit",{"citizen_male","citizen_female"},{start={"idle_to_sit_ground","idle_to_sit_chair"},sequence={"sit_ground","sit_chair"},finish={{"sit_ground_to_idle",duration=2.1},""},untimed=true,idle=true})
    ix.act.Register("SitWall",{"citizen_male","citizen_female"},{sequence={{"plazaidle4",check=c},{"injured1",check=c,offset=function(d)return d:GetForward()*14 end}},untimed=true,idle=true})
    ix.act.Register("Sit","vortigaunt",{sequence="chess_wait",untimed=true,idle=true})
    ix.act.Register("Stand","citizen_male",{sequence={"lineidle01","lineidle02","lineidle03","lineidle04"},untimed=true,idle=true})
    ix.act.Register("Stand","citizen_female",{sequence={"lineidle01","lineidle02","lineidle03"},untimed=true,idle=true})
    ix.act.Register("Stand","metrocop",{sequence="plazathreat2",untimed=true,idle=true})
    ix.act.Register("Cheer","citizen_male",{sequence={{"cheer1",duration=1.6},"cheer2","wave_smg1"}})
    ix.act.Register("Cheer","citizen_female",{sequence={"cheer1","wave_smg1"}})
    ix.act.Register("Lean",{"citizen_male","citizen_female"},{start={"idle_to_lean_back","",""},sequence={{"lean_back",check=c},{"plazaidle1",check=c},{"plazaidle2",check=c}},untimed=true,idle=true})
    ix.act.Register("Lean",{"metrocop"},{sequence={{"idle_baton",check=c},"busyidle2"},untimed=true,idle=true})
    ix.act.Register("Injured","citizen_male",{sequence={"d1_town05_wounded_idle_1","d1_town05_wounded_idle_2","d1_town05_winston_down"},untimed=true,idle=true})
    ix.act.Register("Injured","citizen_female",{sequence="d1_town05_wounded_idle_1",untimed=true,idle=true})
    ix.act.Register("ArrestWall","citizen_male",{sequence={{"apcarrestidle",check=b,offset=function(d)return-d:GetForward()*23 end},"spreadwallidle"},untimed=true})
    ix.act.Register("Arrest","citizen_male",{sequence="arrestidle",untimed=true})
    ix.act.Register("Threat","metrocop",{sequence="plazathreat1",})
    ix.act.Register("Deny","metrocop",{sequence="harassfront2",})
    ix.act.Register("Motion","metrocop",{sequence={"motionleft","motionright","luggage"}})
    ix.act.Register("Wave",{"citizen_male","citizen_female"},{sequence={{"wave",duration=2.75},{"wave_close",duration=1.75}}})
    ix.act.Register("Pant",{"citizen_male","citizen_female"},{start={"d2_coast03_postbattle_idle02_entry","d2_coast03_postbattle_idle01_entry"},sequence={"d2_coast03_postbattle_idle02",{"d2_coast03_postbattle_idle01",check=b}},untimed=true})
    ix.act.Register("Window","citizen_male",{sequence="d1_t03_tenements_look_out_window_idle",untimed=true})
    ix.act.Register("Window","citizen_female",{sequence="d1_t03_lookoutwindow",untimed=true})



    -------------------------------------------------------------------------
    ix.act.RegisterWithName("(Сесть) Сесть на корточки","sit1","stalker_animations",{start={"idle_0_to_sit_0",duration=1.667},sequence={"item_0_idle_3"},finish={"sit_0_lazy_idle_0",duration=3.667},untimed=true,})
    ix.act.RegisterWithName("(Сесть) Сесть положив руку на ногу","sit2","stalker_animations",{start={"stalker_1_down",duration=3.3},sequence={"stalker_1_2"},finish={"stalker_1_up",duration=3.3},untimed=true,})
    ix.act.RegisterWithName("(Сесть) Сесть скрестив ноги","sit3","stalker_animations",{start={"stalker_2_down",duration=2.3},sequence={"stalker_2_1"},finish={"stalker_2_up",duration=3.3},untimed=true,})
    ix.act.RegisterWithName("(Сесть) Сесть скрестив ноги 2","sit4","stalker_animations",{start={"stalker_3_down_",duration=3.967},sequence={"stalker_3_2"},finish={"stalker_3_up_",duration=3.3},untimed=true,})
    ix.act.RegisterWithName("(Сесть) Сесть облокотившись на руку","sit5","stalker_animations",{start={"idle_0_to_sit_1",duration=2.5},sequence={"sit_1_idle_1"},finish={"sit_1_lazy_idle_0",duration=4.333},untimed=true,})
    ix.act.RegisterWithName("(Сесть) Сесть положив руки на ноги","sit6","stalker_animations",{start={"idle_0_to_sit_2",duration=2.333},sequence={"sit_2_idle_1"},finish={"sit_2_lazy_idle_0",duration=6.333},untimed=true,})
    ix.act.RegisterWithName("(Лечь) Прилечь на землю","sit7","stalker_animations",{sequence="item_1_idle_0",untimed=true})
    ix.act.RegisterWithName("(Лечь) Сон","son","stalker_animations",{sequence="sleep_idle_0",untimed=true})
    ix.act.RegisterWithName("(Облокотиться) Облокотиться на стол 1","bar1","stalker_animations",{start={"bar_0_idle_in",duration=1.667},sequence={"bar_0_idle_0"},finish={"bar_0_idle_out",duration=1.667},untimed=true,})
    ix.act.RegisterWithName("(Облокотиться) Облокотиться на стол 2","bar2","stalker_animations",{start={"bar_1_idle_in",duration=1.667},sequence={"bar_1_idle_0"},finish={"bar_1_idle_out",duration=1.667},untimed=true,})
    ix.act.RegisterWithName("(Облокотиться) Облокотиться на стол 3","bar3","stalker_animations",{start={"animpoint_stay_table_in_1",duration=2},sequence={"animpoint_stay_table_visual"},finish={"animpoint_stay_table_out_1",duration=1.5},untimed=true,})
    ix.act.RegisterWithName("(Облокотиться) Облокотиться на стол 4","bar4","stalker_animations",{start={"lead_1_idle_to_bar_1",duration=1.667},sequence={"lead_1_bar_idle_0"},finish={"lear_1_bar_to_idle_1",duration=2.667},untimed=true,idle=true})
    ix.act.RegisterWithName("(Облокотиться) Облокотиться на стол отдыхать 1","bar5","stalker_animations",{start={"bar_2_idle_in",duration=1.667},sequence={"bar_2_idle_0"},finish={"bar_2_idle_out",duration=1.667},untimed=true,})
    ix.act.RegisterWithName("(Облокотиться) Облокотиться на стол отдыхать 2","bar6","stalker_animations",{start={"bar_3_idle_in",duration=1.667},sequence={"bar_3_idle_0"},finish={"bar_3_idle_out",duration=1.667},untimed=true,})
    ix.act.RegisterWithName("(Облокотиться) Облокотится к стене","stena1","stalker_animations",{start="animpoint_stay_wall_in_1",sequence={{"animpoint_stay_wall_idle_rnd_1",check=c,offset=function(d)return-d:GetForward()*5 end}},finish="animpoint_stay_wall_out_1",untimed=true})
    ix.act.RegisterWithName("(Облокотиться) Облокотится к стене 2","stena2","stalker_animations",{sequence={{"animpoint_stay_wall_idle_rnd_4",check=c,offset=function(d)return-d:GetForward()*5 end}},untimed=true})
    ix.act.RegisterWithName("(Пьяный) Упереться в стену рукой","alkash1","stalker_animations",{sequence="drink_idle_11",untimed=true})
    ix.act.RegisterWithName("(Пьяный) Упереться в стену рукой 2","alkash2","stalker_animations",{sequence="drink_idle_5_0",untimed=true})
    ix.act.RegisterWithName("(Пьяный) Сесть на землю","alkash3","stalker_animations",{sequence="drink_idle_9",untimed=true})
    ix.act.RegisterWithName("(Пьяный) Сесть на землю 2","alkash4","stalker_animations",{sequence="sleep_idle_2",untimed=true})
    ix.act.RegisterWithName("(Разное) Смех","smeh","stalker_animations",{sequence="smeh",untimed=false})
    ix.act.RegisterWithName("(Разное) Сделать что-то на полу","dinamit","stalker_animations",{sequence="dinamit_0",untimed=false})
    ix.act.RegisterWithName("(Разное) Нет / Не знаю","net","stalker_animations",{sequence="net_0_0",untimed=false})
    ix.act.RegisterWithName("(Разное) Отдать честь","chest1","stalker_animations",{start={"chest_0_idle_0",duration=0.5},sequence={"chest_0_idle_2"},finish={"chest_0_idle_3",duration=1.167},untimed=false,})
    ix.act.RegisterWithName("(Разное) Команда Ровняйсь!","chest2","stalker_animations",{start={"chest_0_idle_0",duration=0.5},sequence={"chest_0_idle_1"},finish={"chest_0_idle_3",duration=1.167},untimed=true,})
    ix.act.RegisterWithName("(Разное) Стоя курить сигарету","smok1","stalker_animations",{start={"stoya_kurit_in2",duration=6.6},sequence={"stoya_kurit_4"},finish={"stoya_kurit_out1",duration=0.5},untimed=true,})
    ix.act.RegisterWithName("(Разное) Сидя курить сигарету","smok2","stalker_animations",{start={"kurit_1",duration=5.767},sequence={"kurit_sidya_0"},finish={"kurit_2",duration=4.533},untimed=true,})
    ix.act.RegisterWithName("(Приветствие) Помахать рукой 1","hello","stalker_animations",{sequence="norm_torso_0_hello_0",untimed=false})
    ix.act.RegisterWithName("(Приветствие) Помахать рукой 2","hello2","stalker_animations",{sequence="norm_torso_1_hello_0",untimed=false})
    ix.act.RegisterWithName("(Приветствие) Помахать рукой с оружием","hello3gun","stalker_animations",{sequence="hello_10_idle_0",untimed=false})
    ix.act.RegisterWithName("(Помощь) Махать рукой сидя","helpsidya","stalker_animations",{start={"idle_to_wounded_0",duration=2},sequence={"wounded_ruka_0"},finish={"wounded_to_idle_0",duration=2},untimed=true,})
    ix.act.RegisterWithName("(Сдаться) Поднять руки вверх","sdatsa1","stalker_animations",{sequence="hand_up_0",untimed=true})
    ix.act.RegisterWithName("(Сдаться) Упасть на колени, руки за голову","sdatsa2","stalker_animations",{start={"prisoner_0_sit_down_0",duration=2.6},sequence={"prisoner_0_sit_idle_0"},finish={"prisoner_0_stand_up_0",duration=4.2},untimed=true,})
    ix.act.RegisterWithName("(Стойка) Руки на Пояс","poyas","stalker_animations",{sequence="soldier_idle_0_idle_3",untimed=true,idle=true})
    ix.act.RegisterWithName("(Стойка) Руки в карманы","rukikarman","stalker_animations",{sequence="bandit_norm_torso_0_idle_0",untimed=true})
    ix.act.RegisterWithName("(Стойка) Руки за спиной 1","ohrana1","stalker_animations",{start={"ohrana_0",duration=1.333},sequence={"ohrana_1"},finish={"ohrana_2",duration=0.667},untimed=true,})
    ix.act.RegisterWithName("(Стойка) Руки за спиной 2","ohrana2","stalker_animations",{start={"soldier_ohrana_0",duration=1.333},sequence={"soldier_ohrana_1"},finish={"soldier_ohrana_1",duration=1.333},untimed=true,})
    ix.act.RegisterWithName("(Стойка) Скрестить руки","krestruki","stalker_animations",{sequence="stend",untimed=true})
    ix.act.RegisterWithName("(Стойка) Военная стойка с оружием","ohrana3","stalker_animations",{start={"wick_gesture_army_norm_torso_9_unstrap_0_original",duration=1.667},sequence={"soldier_idle_9_idle_0"},finish={"wick_gesture_army_norm_torso_9_strap_0_base_layer", duration=1.667},untimed=true,})
    ix.act.RegisterWithName("(Стойка) Стойка часового с оружием","ohrana4","stalker_animations",{start={"chasovoy_0",duration=10.667},sequence={"chasovoy_2"},finish={"chasovoy_1",duration=5},untimed=true,})
    ix.act.RegisterWithName("(Стойка) Разговор","boltaet","stalker_animations",{sequence="stoya_boltaet_0",untimed=true})
    ix.act.RegisterWithName("(Стойка) Потянуться/Разминка","razminka","stalker_animations",{sequence="old_komandir_3",untimed=false})
    ix.act.RegisterWithName("(Стойка) Говорить по рации","racia1","stalker_animations",{start={"raciya_1_draw_0",duration=2.667},sequence={"raciya_1_talk_0"},finish={"raciya_1_hide_0",duration=2.667},untimed=true,})
    ix.act.RegisterWithName("(Стойка) Говорить по рации с оружием","racia2","stalker_animations",{start={"raciya_3_draw_0",duration=2.333},sequence={"raciya_3_talk_0"},finish={"raciya_3_hide_0",duration=2.333},untimed=true,})
    ix.act.RegisterWithName("(Спорт) Приседать","prisyad","stalker_animations",{sequence="prisyad",untimed=true})
    ix.act.RegisterWithName("(Спорт) Отжиматься","otzhim1","stalker_animations",{start={"otzhim_in",duration=1.2},sequence={"otzhim"},finish={"otzhim_out",duration=1.7},untimed=true,})
    ix.act.RegisterWithName("(Спорт) Отжиматься на кулаках","otzhim2","stalker_animations",{start={"otzimani_2_in",duration=2.067},sequence={"otzimani_2_idle"},finish={"otzimani_2_out",duration=2.067},untimed=true,})
    ix.act.RegisterWithName("(Боевые) Прямой удар кулаком","punch","stalker_animations",{sequence={"free_facer_0",duration=1.667},untimed=false})
    ix.act.RegisterWithName("(Боевые) Удар прикладом","punch3","stalker_animations",{sequence={"norm_facer_2_0",duration=1.333},untimed=false})
    ix.act.RegisterWithName("(Боевые) Угроза (Пистолет)","uhodi1","stalker_animations",{sequence="uhodi_1_0",untimed=false})
    ix.act.RegisterWithName("(Боевые) Угроза (Автомат)","uhodi2","stalker_animations",{sequence="uhodi_2_0",untimed=false})
    ix.act.RegisterWithName("(Боевые) Знак СТОП с пистолетом в руках","alert4","stalker_animations",{sequence="uhodi_1_1",untimed=false})
    ix.act.RegisterWithName("(Боевые) Осматриваться с оружием по сторонам 1","alert","stalker_animations",{sequence="norm_alert_idle_0",untimed=true})
    ix.act.RegisterWithName("(Боевые) Осматриваться с оружием по сторонам 2","alert2","stalker_animations",{sequence="norm_alert_idle_3",untimed=true})
    ix.act.RegisterWithName("(Боевые) Отдать команду группе","alert3","stalker_animations",{sequence="norm_alert_command_0",untimed=false})
    ix.act.RegisterWithName("(Боевые) Гоп-Стоп с пистолетом","grabej1","stalker_animations",{sequence="gop_stop_1_0",untimed=true})
    ix.act.RegisterWithName("(Боевые) Гоп-Стоп с автоматом","grabej2","stalker_animations",{sequence="old_gop_stop_2_0",untimed=true})
    ix.act.RegisterWithName("(Изучение) Осматриваться/Прислушиваться","smotrim1","stalker_animations",{sequence="prisluh_0_1",untimed=true})
    ix.act.RegisterWithName("(Изучение) Осматриваться/Прислушиваться с пистолетом","smotrim2","stalker_animations",{start={"prisluh_1_in",duration=1.333},sequence={"prisluh_1_1"},finish={"prisluh_1_out",duration=1.333},untimed=true,})
    ix.act.RegisterWithName("(Изучение) Осматриваться/Прислушиваться с пистолетом","smotrim3","stalker_animations",{start={"prisluh_2_in",duration=1.333},sequence={"prisluh_2_1"},finish={"prisluh_2_out",duration=1.333},untimed=true,})
    ix.act.RegisterWithName("(Изучение) Детектор стоя","detector2","stalker_animations",{sequence={"metering_anomalys_0_idle_1",duration=6.70},untimed=true})
    ix.act.RegisterWithName("(Изучение) Осмотреть землю стоя 1","poisk1","stalker_animations",{sequence="poisk_0_idle_0",untimed=true})
    ix.act.RegisterWithName("(Изучение) Осмотреть землю стоя 2","poisk2","stalker_animations",{sequence="poisk_1_idle_1",untimed=true})
    ix.act.RegisterWithName("(Изучение) Осмотреть землю сидя 1","poisk3","stalker_animations",{sequence="poisk_0_idle_1",untimed=true})
    ix.act.RegisterWithName("(Изучение) Осмотреть землю сидя 2","poisk4","stalker_animations",{sequence="poisk_2_idle_1",untimed=true})
    ix.act.RegisterWithName("(Изучение) Осмотреть землю стоя с оружием","poisk5","stalker_animations",{sequence="poisk_2_idle_1",untimed=true})
    ix.act.RegisterWithName("(Изучение) Осмотреть землю сидя с оружием 1","poisk6","stalker_animations",{sequence="poisk_3_idle_0",untimed=false})
    ix.act.RegisterWithName("(Изучение) Осмотреть землю сидя с оружием 2","poisk7","stalker_animations",{sequence="poisk_3_idle_2",untimed=false})
    ix.act.RegisterWithName("(Изучение) Осмотреть ","poisk8","stalker_animations",{sequence="poisk_9_idle_2",untimed=false})
    ix.act.RegisterWithName("(Изучение) Проводить замеры (сидя) 1","detector3","stalker_animations",{sequence="metering_anomalys_1_idle_0",untimed=true})
    ix.act.RegisterWithName("(Изучение) Проводить замеры (сидя) 2","detector4","stalker_animations",{sequence="metering_anomalys_1_idle_1",untimed=true})
    ix.act.RegisterWithName("(Изучение) Проводить замеры (сидя) 3","detector5","stalker_animations",{sequence="metering_anomalys_1_idle_3",untimed=true})
    ix.act.RegisterWithName("(Изучение) Проводить замеры (сидя) 4","detector5","stalker_animations",{sequence="metering_anomalys_1_idle_4",untimed=true})
    ix.act.RegisterWithName("(Фанатики) Молиться 1","trans1","stalker_animations",{start={"idle_0_to_trans_0",duration=15.333},sequence={"trans_0_idle_0"},finish={"trans_0_to_idle_0",duration=10.167},untimed=true,})
    ix.act.RegisterWithName("(Веселое) Танцы","dancee1","stalker_animations",{sequence="dance_1",untimed=true})
    ix.act.RegisterWithName("(Веселое) Танцы","dancee2","stalker_animations",{sequence="dance_2",untimed=true})
    ix.act.RegisterWithName("(Веселое) Танцы","dancee3","stalker_animations",{sequence="dance_5",untimed=true})
    ix.act.RegisterWithName("(Веселое) Танцы","dancee4","stalker_animations",{sequence="dance_4",untimed=true})
    ix.act.RegisterWithName("(Фанатики) Молиться 2","trans2","stalker_animations",{start={"idle_0_to_trans_1",duration=12.6},sequence={"trans_1_idle_0"},finish={"trans_1_to_idle_0",duration=16},untimed=true,idle=true})
    ix.act.RegisterWithName("(Стойка) Команд.стойка 1","standone","stalker_animations",{sequence="menu_stand_1",untimed=true})    
    ix.act.RegisterWithName("(Стойка) Команд.стойка 2","standtwo","stalker_animations",{sequence="menu_stand_2",untimed=true})   
    ix.act.RegisterWithName("(Стойка) Команд.стойка 3","standthree","stalker_animations",{sequence="menu_stand_3",untimed=true})   
    ix.act.RegisterWithName("(Стойка) Команд.стойка 4","standthoo","stalker_animations",{sequence="menu_stand_4",untimed=true}) 
    ix.act.RegisterWithName("(Стойка) Испуг","isppug","stalker_animations",{sequence="ispug_1",untimed=true})    
    ix.act.RegisterWithName("(Стойка) Осмотр 1","isppug1","stalker_animations",{sequence="komandir_0",untimed=true})   
    ix.act.RegisterWithName("(Стойка) Осмотр 2","isppug2","stalker_animations",{sequence="komandir_1",untimed=true})   
    ix.act.RegisterWithName("(Стойка) Осмотр 3","isppug3","stalker_animations",{sequence="komandir_2",untimed=true})           
    ix.act.RegisterWithName("(Фанатики) ПСИХОЗ 01","trans01","stalker_animations",{start={"idle_0_to_psy_1_idle_0",duration=15.333},sequence={"psy_0_idle_1"},finish={"psy_0_idle_0_to_idle_0",duration=10.167},untimed=true,})
    ix.act.RegisterWithName("(Фанатики) ПСИХОЗ 02","trans02","stalker_animations",{start={"idle_0_to_psy_1_idle_0",duration=15.333},sequence={"psy_0_idle_2"},finish={"psy_0_idle_0_to_idle_0",duration=10.167},untimed=true,})
    ix.act.RegisterWithName("(Фанатики) ПСИХОЗ 03","trans03","stalker_animations",{start={"idle_0_to_psy_1_idle_0",duration=15.333},sequence={"psy_0_idle_3"},finish={"psy_0_idle_0_to_idle_0",duration=10.167},untimed=true,})
    ix.act.RegisterWithName("(Стойка) Тревога","treboga","stalker_animations",{sequence="spit_4",untimed=true})  
    ix.act.RegisterWithName("(Стойка) Нейтралка","stoikaslakreta","stalker_animations",{sequence="stalker_1",untimed=true})  
    ix.act.RegisterWithName("(Стойка) Нейтралка","stoikaslakreta2","stalker_animations",{sequence="stalker_3",untimed=true})  
    ix.act.RegisterWithName("(Действие) Крещение","bogsnami","stalker_animations",{sequence="trinyty_7",untimed=false})  
    ix.act.RegisterWithName("(Действие) Угроза","gorloknife","stalker_animations",{sequence="glandy",untimed=false})  
    ix.act.RegisterWithName("(Действие) Угроза 2","gorloknifetw","stalker_animations",{sequence="see_by_me",untimed=false})  
    ix.act.RegisterWithName("(Действие) Палец у виска","visok","stalker_animations",{sequence="shizo",untimed=false})  
end)