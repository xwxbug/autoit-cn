-- OpenFindFiles.lua
-- Version: 1.3
-- Author: mozers™
---------------------------------------------------
-- После выполнения команды "Найти в файлах..."
-- создает пункт в контекстном меню консоли - "Открыть найденные файлы"
-- Подключение:
-- В файл SciTEStartup.lua добавьте строку:
--   dofile (props["SciteDefaultHome"].."\\tools\\OpenFindFiles.lua")
---------------------------------------------------
local user_outputcontext_menu           -- исходное контекстное меню консоли
local clear_before_execute              -- исходное значение параметра clear.before.execute
local outputcontextmenu_changed = false -- признак модификации контекстного меню
local command_num                       -- номер команды "OpenFindFiles" в меню Tools
local IDM_TOOLS = 9000

--------------------------------------------------
-- Поиск незанятого пункта меню Tools
local function GetFreeCommandNumber()
	for i = 20, 299 do
		if props["command."..i..".*"] == "" then return i end
	end
end

--------------------------------------------------
-- Создание команды в меню Tools и вставка ее в контекстное меню консоли
local function CreateMenu()
	local command_name = scite.GetTranslation("Open Find Files")
	command_num = GetFreeCommandNumber()

	-- пункт в в контекстном меню консоли
	user_outputcontext_menu = props["user.outputcontext.menu.*"]
	props["user.outputcontext.menu.*"] = command_name.."|"..(IDM_TOOLS+command_num).."|||"..user_outputcontext_menu
	outputcontextmenu_changed = true

	-- команда в меню Tools
	props["command."..command_num..".*"] = "OpenFindFiles"
	props["command.mode."..command_num..".*"] = "subsystem:lua,savebefore:no"

	clear_before_execute = props["clear.before.execute"]
	props["clear.before.execute"] = 0 -- чтобы можно было воспользоваться output:GetText()
end

--------------------------------------------------
-- Удаление команды из меню Tools и восстановление исходного контекстного меню консоли
local function RemoveMenu()
	props["user.outputcontext.menu.*"] = user_outputcontext_menu
	outputcontextmenu_changed = false
	props["command."..command_num..".*"] = ""
	props["clear.before.execute"] = clear_before_execute
end

--------------------------------------------------
-- Открытие файлов, перечисленных в консоли
function OpenFindFiles()
	local output_text = output:GetText()
	local str, path = output_text:match('"(.-)" in "(.-)"')
	path = path:match('^.+\\')
	local filename_prev = ''
	for filename in output_text:gmatch('([^\r\n:]+):%d+:[^\r\n]+') do
		filename = filename:gsub('^%.\\', path)
		if filename ~= filename_prev then
			scite.Open(filename)
			local pos = editor:findtext(str)
			if pos ~= nil then editor:GotoPos(pos) end
			filename_prev = filename
		end
	end
	RemoveMenu()
end

--------------------------------------------------
-- Add user event handler OnMenuCommand
local old_OnMenuCommand = OnMenuCommand
function OnMenuCommand (msg, source)
	local result
	if old_OnMenuCommand then result = old_OnMenuCommand(msg, source) end
	if outputcontextmenu_changed then
		if msg ~= IDM_TOOLS+command_num and msg ~= IDM_FINDINFILES then RemoveMenu() end
	else
		if msg == IDM_FINDINFILES then CreateMenu() end
	end
	return result
end
