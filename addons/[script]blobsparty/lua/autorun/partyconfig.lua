	if party == nil then party = {} end					-- Don't Touch (allows for reloading config without restarting)

	
	party.buttoncolor = Color(100,100,100,200)			-- Invite/join request button color 
	party.buttonhovercolor = Color(255,0,0,200)			-- Invite/join request button color when hovered
	party.backgroundcolor = Color( 50, 50, 50, 255 )	-- Invite/join request background color  
	party.partymenubutton = KEY_F1						-- Key to assign the party menu to (nil  to disable)																
	party.fadediconsfadeamount = 50 					-- Recommend under 50 (reduce to make unused icons fadded out more then they are)
	party.halos = true         							-- Shows a halo around fellow party members
	party.hudverticalpos = 175							-- Up/down position of the hud (175 is a good spot for most agendas) (only first join setting, Does not change for all players when changed as players can set their own hud position)
	party.partychatcolr = Color(255,0,0,255) 			-- The color of [Party] in party chat									
	party.partychatmsgcolr = Color(0,255,255,255)		-- Color of the party message text										
	party.partychatnamecolr = Color(0,255,0,255)		-- Color of player name who sent party message							
	party.chatcommand = "!party"						-- Chat command to open party menu
	party.maxplayers = 16 								-- Maximum number of players per party, if you dont want to use this set really high
	party.joinrequestcooldown = 60 						-- Time between requests to join your party per players								
	party.invitecooldown	= 30						-- Time between invites from the party leader per player invited					
	party.partychatcommand = "/p"						-- Chat command used to chat with your party		
	party.defaultlowend		= true						-- If you would like to use circles at players feet instead of halos set to true (clients can choose this option but this will be the default value)	
	party.kickondisconnect = true						-- Kick a player from their party if they disconnect? 
	party.DarkrpGamemode = true							-- Is your gamemode derived from darkrp?
	party.ForceJobParty	= false							-- If this is set to false and the party.AutoGroupedJobs has teams then the players will recieve invites to those parties when they join the team instead of being placed in that party
	party.PartyDamage = false							-- Should party members be able to damage eachother
  
    timer.Simple(0, function() --DO NOT TOUCH! This gives darkrp time to load before trying to add teams
		party.BlacklistJobs = {TEAM_HOBO32, TEAM_UGLYDUCK} -- Jobs that can NOT join parties
	end)

  
  
  
	-- PARTY GROUPS!  --I KNOW ... i took forever to add this, sorry
	party.AutoGroupedJobs = {}-- DONT TOUCH!
	timer.Simple(0, function()	--DO NOT TOUCH! This gives darkrp time to load before trying to add teams
		--party.AutoGroupedJobs[1] = {TEAM_HOBO, TEAM_MAYOR}							-- Teams that will be given their own party seperated by groups
		--party.AutoGroupedJobs[2] = {TEAM_POLICE, TEAM_CHIEF}							-- Party name will automatically become the first team in each list
		--party.AutoGroupedJobs[3] = {nil}												-- ADD AS MANY GROUPS AS YOU WANT!
		--party.AutoGroupedJobs[4] = {nil}												-- 
	end)
	
 
	
-- Language Stuff default is english
	party.language = {
	
	--Do not edit this side					-- Edit this side!
	-- Party Chat
	["[Party]"]								= "[Группа] ",		--Chat Tag	
	--Menu
	["Invited to join a party"] 			= "Пригласить вступить в группу",
	["Has invited you to their party."] 	= "Вас пригласили в группу.",
	["Accept?"] 							= "Принять?",
	["YES"] 								= "ДА",
	["NO"] 									= "НЕТ",
	["Request To Join Your Party"] 			= "Запрос в вступление в группу",
	["Would like to join your party"] 		= "Хотел бы присоединиться к вашей группе",
	["Party Menu"] 							= "Меню групп",
	["Welcome to the party menu!"] 			= "Добро пожаловать",
	["An easy way for you to"] 				= "Это быстрый способ сделать свою группу",
	["team up with your friends!"] 			= "объеденяйтесь со своими друзьями",
	["Start Party"] 						= "Создать группу",
	["WARNING!"] 							= "Внимание!",
	["By starting a new party"] 			= "By starting a new party",
	["you will be removed from"] 			= "you will be removed from",
	["your current party."]	 				= "ваша группа.",
	["Start A New Party"] 					= "Создать новую группу",
	["Party Name"] 							= "Название",
	["Join Party"] 							= "Присоедениться",
	["Members"] 							= "Участники",
	["Request Join"] 						= "Запрос о вступлении",
	["Leave Party"] 						= "Покинуть группу",
	["By leaving your party"] 				= "Выходя из группы",
	["you will no longer be protected"] 	= "вы больше не защищены",
	["from damage from"] 					= " от получаемого урона",
	["your former party members."] 			= "от ваших бывших союзников.",
	["Leave Current Party"] 				= "Покинуть группу",
	["Manage Party"] 						= "Редактировать группу",
	["Kick From Party"] 					= "Исключить",
	["offline"] 							= "Вышел",					--Also on hud
	["Invite To Party"] 					= "Пригласить",
	["Players"] 							= "Игроки",
	["Settings"] 							= "Настройки",
	["Color of party halo"] 				= "Цвет обводки",
	["Lowend Halo"]							= "Отключить обводку (FPS +)",
	["Admin"] 								= "Админ настройки",
	["Disban Party"] 						= "Распустить группу",
	["Parties"] 							= "Группы",
	
	--HUD
	["Party Name"] 							= "Название",
	["Alive"] 								= "ЖИвой",
	["Dead"] 								= "Мёртвый",
	["Disable Hud?"]						= "Отключить худ?",
	["Kick"]								= "Исключить",
	-- Messages sent to clients from the server(in chatbox)	 
	["Maximum number of players in this party."]			= "Максимальное количество игроков в этой группе.",
	["Please wait"]											= "Подождите...",
	["seconds between party requests."]						= "Подождите перед отправкой...",
	["seconds between party invites."]						= "Подождите перед отправкой...",
	["accepted your party request."]						= "Принял приглашение.",
	["declined your party request."]						= "Отклонил приглашение.",
	["accepted your party invite."]							= "Вы вошли в группу.",
	["declined your party invite."]							= "Вам отказали в ступлении.",
	["kicked you from the party."]							= "исключил из группы.",
	["disbaned your party."]								= "распустить группу.",
	["You must be the same team!"]							= "Вы должны быть в группе!",
	["You are not allowed to join this party."]				= "Вы не можете этого сделать.",
	["You are currently in a forced party, change jobs."] 	= "Вы дубина, выйди ат цуда.",
}

