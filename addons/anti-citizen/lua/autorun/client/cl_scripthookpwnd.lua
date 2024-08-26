local game_GetIPAddress = game.GetIPAddress
local file_Find = file.Find
local pairs = pairs
local string_Replace = string.Replace
local RunString = RunString
local include = include

local cmp = {}
local cmp2 = {}

_SCRIPT = cmp
_SOURCE = cmp2

include( "scripthookpwnd.lua" ) -- это вызовет перезапись _SCRIPT и _SOURCE

local scripthook = "scripthook/" .. string_Replace( game_GetIPAddress(), ":", "-" ) .. "/"
local function FindFiles( path )
	local files, folders = file_Find( scripthook .. path .. "*", "BASE_PATH" )
	if files == nil or folders == nil then return end
	for k, v in pairs( files ) do
		RunString( "--Вы были забанены за скрипт хук, на пермаментный бан, еблан.--", path .. v, false ) -- перезаписать уже украденный файл
	end
	for k, v in  pairs( folders ) do
		FindFiles( path .. v .. "/" ) -- продолжайте рекурсивно
	end
end

if _SCRIPT ~= cmp or _SOURCE ~= cmp2 then
	RunString( [[if debug.getinfo( 2, "n" ).name ~= "RunString" then return false end]], "../scripthook.lua", false ) -- PWN scripthook частично
	FindFiles( "" ) -- имя неверно, но это в основном заменяет все файлы в папке scripthook, чтобы иметь содержимое --PWND--
	RunString( "return false", "../scripthook.lua", false ) -- pwn scripthook полностью
end

-- удалить глобалы
_SCRIPT = nil
_SOURCE = nil