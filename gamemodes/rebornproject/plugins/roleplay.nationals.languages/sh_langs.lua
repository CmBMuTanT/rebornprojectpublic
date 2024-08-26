--[[ пример создания нового языка
do
    local language = ix.languages:New()
    language.name = "Мутантовский"
    language.uniqueID = "mtk" /mtk {text} /ymtk {YELLING TEXT} /wmtk {whisper text....}
    language.icon = "сюда картинку флага.png"
    language.randomwords = {"северслат", "кодить", "бухать", "нулл дай денег", "я щас модели сетну", "я не хочу кодить", "я отдыхаю"}

    language:Register()
end
]]


--[[ пример создания нового языка
do
    local language = ix.languages:New()
    language.name = "Мутантовский"
    language.uniqueID = "mtk" /mtk {text} /ymtk {YELLING TEXT} /wmtk {whisper text....}
    language.icon = "сюда картинку флага.png"
    language.randomwords = {"северслат", "кодить", "бухать", "нулл дай денег", "я щас модели сетну", "я не хочу кодить", "я отдыхаю"}

    language:Register()
end
]]


do
    local language = ix.languages:New()
    language.name = "Татарский"
    language.uniqueID = "tat"
    language.icon = "flags16/mr.png"
    language.randomwords = {"а тинпонь!?!", "Урус!", "карчык пидорны кисегез!", "Атарас кубыран!", "Друбау! Друбау нах! Пиздаблюй тудамахан!", "Ашарашеныхтудабей! Акус!", "яухан родопи?", "то-же пидееранеил?", "АА! ААА? ТАфыа! Тафыа, хуй!", "Не сина! апынь!", "Ничео рарвичи!", "Кардан бургин!", "поу фари тора!", "Каргыз улыба!", "Адиор! Сук!", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Украинский"
    language.uniqueID = "ua"
    language.icon = "flags16/ua.png"
    language.randomwords = {"Сука випити б!", "літак!", "Самогон героїн відеопленко", "Шуша Наст Шуша!", "он арнтцуа Пиздаблюй", "Ашарашен!", "яухан родопи?", "то-же пидееранеил?", "АА! ААА? ТАфыа! Тафыа, хуй!", "Ссы в компот, апв ывпфрып !", "Ничео рарвичи!", "Кардани бургин!", "по типу фари тора!", "Каргыз улыба!", "Адиор! Горилка!", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Башкирский"
    language.uniqueID = "bas"
    language.icon = "flags16/rw.png"
    language.randomwords = {"Тулы потрясение!", "Һеҙ нимә менән носков", "Ахдр хистәр, пидор", "Иҡтисад инде трещит ганза!", "Василек тыш арта", "Тәртип һеҙ?", "Нимә менән сысҡан", "Ни өсөн кисә", "Язые", "Фурино апв ывпфрып !", "Ничео рарвичи!", "Кардани бургин!", "по типу фари тора!", "КаРЫНЬ ул!", "Адио баньк", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Чувашский"
    language.uniqueID = "chu"
    language.icon = "flags16/rw.png"
    language.randomwords = {"Афарина!", "Фирана!", "Шубаньки санура", "Фулынь...", "он арнтутан!", "Афулинен!!", "яухан родопи?", "то-же пикрил?", "Язые", "Фурино апв ывпфрып !", "Ничео рарвичи!", "Кардани бургин!", "по типу фари тора!", "Каргыз улыба!", "Адио баньк", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Чеченский"
    language.uniqueID = "che"
    language.icon = "flags16/rw.png"
    language.randomwords = {"Хьо Бено-м вац", "Ай баля вася!", "Шубаньки санура", "Фул буд?.", "он арнтутан!", "Афулинен!!", "яухан родопи?", "то-же пикр?", "Язые", "Фурино апв ывпфрып !", "Ничео рарвичи!", "Кардани бургин!", "по типу фари тора!", "Каргыз улыба!", "Адио баньк", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Армянский"
    language.uniqueID = "arm"
    language.icon = "flags16/am.png"
    language.randomwords = {"Գլանափաթեթ, գլանափաթեթ bitch! ", "Գուցե դուք ունեք մի տղամարդ otvis?", "ւք ունեք մ", "Այծեր.", "յծե", "Ինչ փայլել", "ept դու քած", "ԳՐԱՍԵՂԱՆԻ?", "ԲՈԼՈՐ", "Фурино апв ывпфрып !", "Ավտոմատ", "Кардани бургин!", "Каран алах!", "Кз улыба!", "Аньк!", "Б դու ур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Беларусский"
    language.uniqueID = "bel"
    language.icon = "flags16/by.png"
    language.randomwords = {" радзіму!", "Бірулька ў скрынцы?", "Смачная ежа!", "Не разумею што з табой?!!!", "Вылазка ўдалай?!", "Дзе паперы, фань!", "Мінск жывы?", "Презд сабака", "трусь! А? [непонятное бормотание]", "Татьтан! !", "Ничрвичи!", "Кардани бургин!", "Эх... [Непонятное бормотание]", "Кба!", "Адио баньк", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Казахский"
    language.uniqueID = "kz"
    language.icon = "flags16/kz.png"
    language.randomwords = {"Ақ аспан", "Егжей-тегжейлі, солай емес пе?", "Құдай-ау, әлемді сақта!", "Неге олай жасадың?", "Ал сен ақымақсың", "міне қаншық", "неліктен іліп қоюға болмайды", "ахует жаратылыс", "суда ұшатын ақ шошқа", "Татьтан! !", "Ничрвичи!", "Кардани бургин!", "Уууухх!", "Кба!", "Адио баньк", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Азербайджанский"
    language.uniqueID = "azer"
    language.icon = "flags16/az.png"
    language.randomwords = {"Ağ donuz", "Niyə belədir?", "Düymələri olmayan uzaq", "Qan masa", "Anam gözəl", "Sizə nə, döyüşçülər", "uh necə boğuldu", "mal ətində qorxaqlar? özünüz haqqında nə düşünürsünüz?", "nə ablantizm! Michael Jackson byvat, Michael Jackson-bəlkə Dmitri Nağıyev?", "Nə bağışla?", "Ölüm Bakire"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Немецкий"
    language.uniqueID = "ger"
    language.icon = "flags16/at.png"
    language.randomwords = {"Weiße Division", "Das wäre jetzt im Reich", "Was denkst du, haben die Roten da drin?", "Wie behandeln uns diese Menschen?", "Seit dreißig Jahren..", "Scheiße und was zu tun ist", "Wow, das höre ich zum ersten Mal", "Das Geräusch fliegt", "wie ein Hund aus der Nase?"	}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Кабардинский"
    language.uniqueID = "cab"
    language.icon = "flags16/az.png"
    language.randomwords = {"Афа ала!", "Фирана!", "Шубаньки санура", "Фулынь...", "он арнтутан!", "Афулыв ввн!!", "яухан родва авопи?", "то-же пикрил?", "Язвы вае", "Фурино авы увы!", "Ничео мави!", "Кардани бургин!", "по типу фари твыора!", "Карз улыбарка", "Ади edsьк", "Бала! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Осетинский"
    language.uniqueID = "ose"
    language.icon = "flags16/az.png"
    language.randomwords =  {"Хьо Бено-м вац", "Ай бал сися!", "Шубаньки санура", "Фул буд?.", "он арнтутан!", "Афун!!", "яу рана?", "то-же пил?", "Язые", "Фурино апв ывпфрып !", "Ничео рарвичи!", "Кардани бургин!", "по типу фари тора!", "Каргыз улыба!", "Адио баньк", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Бурятский"
    language.uniqueID = "bur"
    language.icon = "flags16/az.png"
    language.randomwords =  {"Хьо Беал см вац", "Ай urlanся!", "Шуал сньки ал са", "Фул буд?.", "он ал сн!", "Афун!!", "яу рана?", "тофы ывал?", "Язые", "Фурифа впфрып !", "Ничео раф !", "Карданифы ин!", "по ари тора!", "Каргы!", "Адио баньр", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Тувинский"
    language.uniqueID = "tuv"
    language.icon = "flags16/ru.png"
    language.randomwords =  {"Хьо Беал см вац", "Ай urlanся!", "Шуал сньки ал са", "Фул буд?.", "он ал сн!", "Афун!!", "яу рана?", "тофы ывал?", "Язые", "Фурифа впфрып !", "Ничео раф !", "Кард ин!", "по ари тора!", "Каргы!", "Адио баньр", "Баладан афур! "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Ивритский"
    language.uniqueID = "evr"
    language.icon = "flags16/il.png"
    language.randomwords =  {"שלום כאח חיים", "שלום כאח חי", "ל שנים", " חיים ", "לום כאח ", " של שנים", "שלום כ", "ח חיים ח חיים !!!", "צעיר לנצח", "לום כאח חיים של שני@", "חיים של חיים של  !", "חיים של חיים של "}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Грузинский"
    language.uniqueID = "gru"
    language.icon = "flags16/ge.png"
    language.randomwords =  {"Альтаруба бульдаран!", "Фрсет каман!", "Ухитаба аналарям!?", "Урууу! урунаба!?", "Вас кунова!", "Вано! Вано рано!", "Вац генор вац генорамо!", "[странное бормотание]", "Ванося! Ууу, вася!", "Кирино, варино смино!!!!"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Цыганский"
    language.uniqueID = "cig"
    language.icon = "icons16/flag_red.png"
    language.randomwords =  {"Мишто явъЯн!", " бахталэс!", "романо ракирэбэ!!", " тэ явЭн бахталЭ!", "тэ явЭс бахталО!", "дубр!!", "Фарши самано!", "Ай! Ай! Бугулай!", "Ой ой будулной!", "Уй хань!", "Трубан Сабано! Аййй!"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Казакский"
    language.uniqueID = "kaz"
    language.icon = "icons16/flag_red.png"
    language.randomwords =  {"Мишто явъЯн!", "Какшма!", "рбэ Усум!!!", " тэ явЭн Э!", "уву эрэс!О!", "дубрило урубир!!", "Фасамано!", "Айулай!", "Кукинамо! Какшма!!", "Суриноформин Ахталыбо улинь", "[непонятное быстрое бормотание]", "[странный быстрый язык, который вам - трудно понять]", "[странные вздохи и ойканья]"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Узбекский"
    language.uniqueID = "uzb"
    language.icon = "flags16/rw.png"
    language.randomwords =  {"Мишто явъЯн!", "Какшма!", "рбэ Усум!!!", " тэ явЭн Э!", "уву эрэс!О!", "дубрило урубир!!", "Фасамано!", "Айулай!", "Кукинамо! Какшма!!", "Суриноформин Ахталыбо улинь", "[непонятное быстрое бормотание]", "[странный быстрый язык, который вам - трудно понять]", "[странные вздохи и ойканья]"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Узбекский"
    language.uniqueID = "uzb"
    language.icon = "flags16/rw.png"
    language.randomwords =  {"Yoriq eshitildi", "Hansa baland", "Bu nima, janoblar", "balki biz bu hokimiyatni ag'daramiz?", "Lenin bo'lardi!", "va esda tutingki, ilgari bunday ", "pechene bor edi..", "bu xavfli tunnellar!", "O'zbekiston Rossiya bilan urushda g'alaba qozonishi mumkin edi!", "bizning xalqimiz bu jonzotlardan kuchliroqdir", "Bu tank bo'lar edi!", "Men umuman jazoirlikman, lekin otam o'zbek edi..", "Va pendoslar tirikmi?"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Таджикский"
    language.uniqueID = "tdj"
    language.icon = "flags16/rw.png"
    language.randomwords =  {"Э, инҷиқиҳои!", "Порву агар поймаю!", "Кишвари мо ҳанӯз жива, ман бовар дорам..", "Ки ту ба ман щас гуфт А? ", "масъалаҳои а? слышишь ман?", "Чӣ қадар бед разнесла љанг.. Эх, глупцы ин вояки! Худи небось тушенку жрут!", "Ва каламушҳо имрӯз чизе ҳамин тавр, дуруст аст?", "Бародар, як ҷуфти пуль?", "Ҳалокати бародарон, вақти он ҷамъ мешудем..", "Гӯш, шумо дӯстони дар Пушкинской?"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Греческий"
    language.uniqueID = "gre"
    language.icon = "flags16/gr.png"
    language.randomwords =  {"Οι μηχανές αποσυντέθηκαν στον πόλεμο.. Καλό απόσπασμα!", "Ποιος θα είσαι; Από πού, αδερφέ;", "Περίμενε, είναι αλήθεια; Πλάσμα..", "Σκύλα, πώς να σκοτώσει αυτή τη ", "βιομάζα;", "Άκουσες τι υπάρχει στην Κόκκινη! Γραμμή;!",  "Ναι, μου αρέσουν τα μανταρίνια, ή μάλλον, το έκανα..", "Γράφω το βιβλίο μου, θέλεις να γίνεις", "ο ήρωάς του;."}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Польский"
    language.uniqueID = "pl"
    language.icon = "flags16/gr.png"
    language.randomwords =  {"Twoja matka jest kurtyzaną!", "Oddałbym wszystkie grzyby w kilka minut przed telewizorem..", "Cholera, moja noga boli od tygodnia..", "Pieprzeni Rosjanie, pieprzeni!", "Po co to wszystko? Straciłem sens..", "Kurwa! Kurwa!",  "Jak tam w Warszawie?..", "Bardzo tęsknię za rodziną.. Ale teraz jestem w Hanzie, Rondo to moja nowa rodzina i Dom..", "Oto stworzenia, które się rozmnażają.. Nawet nie przejść!"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Польский"
    language.uniqueID = "pol"
    language.icon = "flags16/gr.png"
    language.randomwords =  {"Twoja matka jest kurtyzaną!", "Oddałbym wszystkie grzyby w kilka minut przed telewizorem..", "Cholera, moja noga boli od tygodnia..", "Pieprzeni Rosjanie, pieprzeni!", "Po co to wszystko? Straciłem sens..", "Kurwa! Kurwa!",  "Jak tam w Warszawie?..", "Bardzo tęsknię za rodziną.. Ale teraz jestem w Hanzie, Rondo to moja nowa rodzina i Dom..", "Oto stworzenia, które się rozmnażają.. Nawet nie przejść!"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Литовский"
    language.uniqueID = "lit"
    language.icon = "flags16/lt.png"
    language.randomwords =  {"Labas, kaip sekasi?", "Velnias, Hanza visiškai ofonarela!", "Kojos jau beveik nuimtos..", "Neilgai mums visiems liko", "Ar yra Dievas? Gal tai prasimanymas?", "Kaip yra Lietuvoje, ar ji gyva?",  "Norėčiau eiti kur nors, kur gerai ", "maitinasi ir apsirengia.", "Maskva yra paskutinis gyvas miestas planetoje."}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Китайский"
    language.uniqueID = "chi"
    language.icon = "flags16/cn.png"
    language.randomwords =  {"你好，我的兄弟！", "我发誓北京还活着!", "我很高兴我活了下来，无论在哪里", "你好吗，兄弟？ 我爱鸽子！", "汽车直升机鼠标灯！", "直升机鼠",  "誓北京还活", "北京还北京还北京还!", "兄弟？ 我爱鸽:????"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Финский"
    language.uniqueID = "fin"
    language.icon = "flags16/fi.png"
    language.randomwords =  {"Oli välttämätöntä rikkoa Neuvostoliitto,ja nyt se osoittautuu!", "Narttu!! Narttu!!!", "Kone kone traktori!", "Kaikkialla, missä he ovat, kuulen", "Miksi minä? Miksei perheeni?", "[непонятное бормотание]",  "[неизвестные вам слова, к тому-же быстро читаемые]"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Болгарский"
    language.uniqueID = "bul"
    language.icon = "flags16/bg.png"
    language.randomwords =  {"Помощ, там!", "Защо така? ЧЕ!", "Какво се случи тогава", "Какво става с теб, приятелю", "Навсякъде съм! Те? ", "[непонятное бормотание]",  "[неизвестные вам слова, к тому-же быстро читаемые]", "Същества и кръв!"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Кыргызский"
    language.uniqueID = "krgz"
    language.icon = "flags16/tj.png"
    language.randomwords =  {"Тозок, орустар!", "Эмне үчүн мен?", "СИЗДЕ ЭМНЕ БАР", "мага жардам бериңиз", "канчык, менин колум", "[непонятное бормотание]",  "аны күйгүзүү!", "менин чекем эмне?"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Латышский"
    language.uniqueID = "lat"
    language.icon = "flags16/lt.png"
    language.randomwords =  {"vārdi ir sajaukti.", "virsnieki, kur jūs esat", "skārds, ko?", "palīdziet!", "Manas acis.. sāp", "[непонятное бормотание]",  "Baltija.. Viņa ir iznīcināta, es zinu", "менин!"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Эстонский"
    language.uniqueID = "est"
    language.icon = "flags16/ee.png"
    language.randomwords =  {"Balkani toit", "Aita mind, lits", "Mida? Ah!", "Sõnu pole.", "Olen hukule määratud.", "[непонятное бормотание]",  "Tõlk murdus või õigemini tema kael..", "või õigemini!!!", "voni men!"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Сербский"
    language.uniqueID = "ser"
    language.icon = "flags16/sk.png"
    language.randomwords =  {"РУСИЈА И СРБИЈА СУ БРАЋА!", "Тако мирише.", "Prijem, ko je u kontaktu?", "Èujete li me?", "Шта се дешава око", "Upomoæ, braæo!",  "Србија је спремна да умре за великог брата!", "Србија ће увек бити на страни!", "Тешко ми је овде.."}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Венгерский"
    language.uniqueID = "hun"
    language.icon = "flags16/hu.png"
    language.randomwords =  {"A halál közel van", "Nem hallak", "Autó lámpa", "Sok teremtmény van", "Szinte nincs pénz", "teremtmény!!!",  "[Непонятное бормотание]", "Valamiféle cirkusz", "A furcsaságok országa.."}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Чешский"
    language.uniqueID = "che"
    language.icon = "flags16/cz.png"
    language.randomwords =  {"tvor!", "co mi kurva dokazuješ?", "proč tak nahlas?", "NEVÍM, CO ŘÍCT.", "kdo jsi?", "Co to je?",  "[Непонятное бормотание]", "Nejistý jsem", "Proč tak! Suko!"}

    language:Register()
end

do
    local language = ix.languages:New()
    language.name = "Якутский"
    language.uniqueID = "yak"
    language.icon = "flags16/ru.png"
    language.randomwords =  {"Хьо Беал см вац", "Ай urlanся!", "Шуал сньки ал са", "Фул буд?.", "он ал сн!", "Афун!!", "яу рана?", "тофы ывал?", "Язые", "Фурифа впфрып !", "Ничео раф !", "Кард ин!", "по ари тора!", "Каргы!", "Адио баньр", "Баладан афур! "}

    language:Register()
end