BlobsPartyConfig = BlobsPartyConfig or {}

-- 1.0.7
BlobsPartyConfig.DefaultTopUISpacing = 5 -- The distance between the top of the screen and the start of the Party members UI (Use this if you have a HUD that is being overlapped by the party members display)

-- 1.0.6 and below
BlobsPartyConfig.PartyCommands = { "/party" } -- The command(s) that opens the party UI
BlobsPartyConfig.PartyChatCommands = {"/p"} -- The commands to use party chat (which is then followed by the message. example: /pc Hey everyone!)
BlobsPartyConfig.MinNameSize = 2 -- Minimum name length for party name
BlobsPartyConfig.MaxNameSize = 10 -- Maximum name length for party name
BlobsPartyConfig.MinSize = 2 -- Minimum size for party
BlobsPartyConfig.MaxSize = 12 -- Maximum size for party

BlobsPartyConfig.FriendlyFireToggle = true -- If this is set to true, then party owners have the option to enable/disable friendly fire within their party

--[[ HUD Styling ]]--
BlobsPartyConfig.FirstColor = Color(41,48,54) -- This is the darkest color on the UI
BlobsPartyConfig.SecondColor = Color(54,61,69) -- Slightly lighter than the previous color
BlobsPartyConfig.ThirdColor = Color(73,83,94) -- The colour of the UI's main background
BlobsPartyConfig.BarColor = Color(47,163,161) -- This is the light blue color
BlobsPartyConfig.PartyChatColor = Color(255,255,255) -- The text color that party chat appears in
BlobsPartyConfig.PartyChatPrefixColor = Color(0,255,255) -- The color that the party chat prefix is -- (PARTY) default yellow

--[[ Language / Localization ]]--
-- When a language config setting contains {p}, this will be replaced by the name of the player that is relevant to that message!
BlobsPartyConfig.FriendlyFire = "Выкл. Урон?"
BlobsPartyConfig.PartyList = "Список групп"
BlobsPartyConfig.PartyMenu = "Система групп"
BlobsPartyConfig.PartyName = "Название"
BlobsPartyConfig.PartySize = "Кол-во участников"
BlobsPartyConfig.Owner = "Лидер"
BlobsPartyConfig.CreateParty = "Создать группу"
BlobsPartyConfig.EditParty = "Настройки группы"
BlobsPartyConfig.PartySettings = "Настройки"
BlobsPartyConfig.ManagePlayers = "Настройки участников"
BlobsPartyConfig.NoOtherPlys = "Выберите игрока..."
BlobsPartyConfig.KickPly = "Исключить"
BlobsPartyConfig.GiveOwner = "Передать лидерство"
BlobsPartyConfig.ReqToJoin = "Вступление"
BlobsPartyConfig.Join = "Вступить"
BlobsPartyConfig.Ply = "Игрок"
BlobsPartyConfig.AcceptReq = "Принять приглашение"
BlobsPartyConfig.OnlyLeaderCan = "Только лидер может!"
BlobsPartyConfig.NotInParty = "Не в команде!"
BlobsPartyConfig.EnRing = "Включить кольцо?"
BlobsPartyConfig.EnGlow = "Включить обводку?"
BlobsPartyConfig.SetClr = "Поставить цвет"
BlobsPartyConfig.PartyLeader = "Лидер:"
BlobsPartyConfig.PartyMmbs = "Участники:"
BlobsPartyConfig.Mmbs = "Участники"
BlobsPartyConfig.OpenParty = "Открыто приглашение"
BlobsPartyConfig.Yes = "Да"
BlobsPartyConfig.No = "Нет"
BlobsPartyConfig.CopyName = "Скопировать Имя"
BlobsPartyConfig.CopySteamID = "Скопировать STEAMID"
BlobsPartyConfig.ViewSteamProfile = "Открыть профиль Steam"
BlobsPartyConfig.AlreadyOwn = "Удалить группу?"
BlobsPartyConfig.AlreadyIn = "Уже сделано!"
BlobsPartyConfig.Disband = "Подтвердить"
BlobsPartyConfig.Leave = "Выйти"
BlobsPartyConfig.HP = "HP"
BlobsPartyConfig.PartyChatPrefix = "(Группа)"
BlobsPartyConfig.NameTooShort = "Размер маловат (минимум 3 символа)"
BlobsPartyConfig.NameTooLong = "Размер большеват (максимум 28 символов)"
BlobsPartyConfig.SizeTooSmall = "Размер группы мал (минимум 2 игрока)"
BlobsPartyConfig.SizeTooBig = "Размер группы болшой (максимум 12 игроков)"
BlobsPartyConfig.PartyNameExists = "Название группы уже занято!"
BlobsPartyConfig.Full = "Команда полная"
BlobsPartyConfig.ReqSent = "Запрос о вступлении отправлен"
BlobsPartyConfig.AlreadyRequested = "Уже приглашён!"
BlobsPartyConfig.OwnerLeaveDisband = "Лидер отказался!"
BlobsPartyConfig.PartyDisbanded = "Группа удалена!"
BlobsPartyConfig.PlayerLeave = "{p} вышел из группы!"
BlobsPartyConfig.PlayerJoin = "{p} вступил в группу!"
BlobsPartyConfig.PlayerKicked = "{p} исключен!"
BlobsPartyConfig.PlayerReqToJoin = "{p} хочет вступить группу!"
BlobsPartyConfig.NewOwner = "{p} новый лидер!"