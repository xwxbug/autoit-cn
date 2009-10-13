--[[--------------------------------------------------
abbrevlist.lua
Authors: Dmitry Maslov, frs, mozers™
version 2.1.2
------------------------------------------------------
  Если при вставке расшифровки аббревиатуры (Ctrl+B) не нашлось точного соответствия,
  то выводится список соответствий начинающихся с этой комбинации символов.
  Возможен автоматический режим работы (появление списка без нажатия на Ctrl+B).
  Он включается параметром abbrev.lexer.auto=3,
        где lexer - имя соответсвующего лексера,
              а 3 - min длина введеной строки при которой она будет анализироваться как аббревиатура
  Подключение:
    В файл SciTEStartup.lua добавьте строку:
    dofile (props["SciteDefaultHome"].."\\tools\\abbrevlist.lua")

------------------------------------------------------
History:
2.1 (mozers)
	* при вводе символов ? * возникал список всех имеющихся расшифровок
	* теперь при показе списка скрипт игнорирует регистр введенной аббревиатуры
	* исправлено регулярное выражение для идентификации аббревиатуры (т.к. символы пробела и # недопустимы только в ее начале)
	* параметр abbrev.lexer.auto теперь задает min длину введеной строки при котором она будет анализироваться как аббревиатура

--]]--------------------------------------------------

local table_expansions = {}   -- полный список аббревиатур и расшифровок к ним
local get_abbrev = true       -- признак того, что этот список надо пересоздать
local abbrev = ''             -- введеннная аббревиатура
local chars_count_min = 0     -- min длина введенной строки при которой она будет анализироваться
local event_IDM_ABBREV = true -- событие, вызвавшее срабатывание скрипта (IDM_ABBREV или OnChar)
local sep = '•'               -- разделитель для строки раскрывающегося списка
local typeUserList = 11       -- идентификатор раскрывающегося списка

-- читает один из файлов abbrev в таблицу table_expansions
local function ReadAbbrevFile(file)
	local abbrev_file = io.open(file)
	if abbrev_file then
		for line in abbrev_file:lines() do
			if line ~= '' then
				local _abr, _exp = line:match('^([^#].-)=(.+)')
				if _abr ~= nil then
					table_expansions[#table_expansions+1] = {_abr, _exp}
				else
					local import_file = line:match('^import%s+(.+)')
					-- если обнаружена запись import то рекурсивно вызываем эту же функцию
					if import_file ~= nil then
						ReadAbbrevFile(file:match('.+\\')..import_file)
					end
				end
			end
		end
		abbrev_file:close()
	end
end

-- читает все подключенные файлы abbrev в таблицу table_expansions
local function CreateExpansionList()
	table_expansions = {}
	local abbrev_filename = props["AbbrevPath"]
	if abbrev_filename == '' then return end
	ReadAbbrevFile(abbrev_filename)
end

-- выводит раскрывающийся список из расшифровок, соответствующих введенной аббревиатуре
local function ShowExpansionList()
	-- находим аббревиатуру
	local abbr_end = editor.SelectionStart
	local line_start_pos = editor:PositionFromLine(editor:LineFromPosition(abbr_end))
	abbrev = editor:textrange(line_start_pos, abbr_end):reverse():match('^.?[^#%s]+')
	if abbrev == nil then return false end
	abbrev = abbrev:reverse()

	-- если длина аббревиатуры меньше заданного кол-ва символов то выходим
	if #abbrev < chars_count_min then return false end
	-- если мы переключились на другой файл, то строим таблицу table_expansions заново
	if get_abbrev then
		CreateExpansionList(abbrev)
		get_abbrev = false
	end
	if #table_expansions == 0 then return false end
	-- выбираем из table_expansions только записи соответствующие введенной аббревиатуре
	local table_expansions_select = {}
	local abbrev_match = '' -- для хранения найденной аббревиатуры (используется ниже, если найден единственный вариант)
	for i = 1, #table_expansions do
		local _isfind = table_expansions[i][1]:upper():find(abbrev:upper(), 1, true)
		if _isfind == 1 then
			table_expansions_select[#table_expansions_select+1] = table_expansions[i][2]
			abbrev_match = table_expansions[i][1]
		end
	end
	if #table_expansions_select == 0 then return false end
	-- если мы используем Ctrl+B (а не автоматическое срабатывание)
	if (event_IDM_ABBREV)
		-- и если найден единственный вариант расшифровки
		and (#table_expansions_select == 1)
		-- и аббревиатура полностью соотвествует введенной
		and (abbrev == abbrev_match)
			-- то вставку производим немедленно (для этого передаем на обработку стандартной функции IDM_ABBREV)
			then return false
	end
	-- показываем раскрывающийся список из расшифровок, соответствующих введенной аббревиатуре
	local table_expansions_select_string = table.concat(table_expansions_select, sep)
	local sep_tmp = editor.AutoCSeparator
	editor.AutoCSeparator = string.byte(sep)
	editor:UserListShow(typeUserList, table_expansions_select_string)
	editor.AutoCSeparator = sep_tmp
	return true
end

-- Вставка расшифровки, из раскрывающегося списка
local function InsertExpansion(expansion)
	editor:BeginUndoAction()
	-- удаление введенной аббревиатуры с сохранением выделения
	local sel_start, sel_end = editor.SelectionStart - #abbrev, editor.SelectionEnd - #abbrev
	editor:remove(sel_start, editor.SelectionStart)
	editor:SetSel(sel_start, sel_end)
	-- вставка расшифровки
	scite.InsertAbbreviation(expansion)
	editor:EndUndoAction()
end
------------------------------------------------------

-- Add user event handler OnMenuCommand
local old_OnMenuCommand = OnMenuCommand
function OnMenuCommand (msg, source)
	local result
	if old_OnMenuCommand then result = old_OnMenuCommand(msg, source) end
	if msg == IDM_ABBREV then
		event_IDM_ABBREV = true
		if ShowExpansionList() then return true end
	end
	return result
end

-- Add user event handler OnChar
local old_OnChar = OnChar
function OnChar(char)
	local result
	if old_OnChar then result = old_OnChar(char) end
	chars_count_min = tonumber(props['abbrev.'..editor.LexerLanguage..'.auto']) or 0
	if chars_count_min == 0 then chars_count_min = tonumber(props['abbrev.*.auto']) or 0 end
	if chars_count_min ~= 0 then
		event_IDM_ABBREV = false
		if tonumber(props['macro-recording']) ~= 1
			and ShowExpansionList() then
				return true
		end
	end
	return result
end

-- Add user event handler OnUserListSelection
local old_OnUserListSelection = OnUserListSelection
function OnUserListSelection(tp, sel_value)
	local result
	if old_OnUserListSelection then result = old_OnUserListSelection(tp,sel_value) end
	if tp == typeUserList then
		if InsertExpansion(sel_value) then return true end
	end
	return result
end

-- Add user event handler OnSwitchFile
local old_OnSwitchFile = OnSwitchFile
function OnSwitchFile(file)
	local result
	if old_OnSwitchFile then result = old_OnSwitchFile(file) end
	get_abbrev = true
	return result
end

-- Add user event handler OnOpen
local old_OnOpen = OnOpen
function OnOpen(file)
	local result
	if old_OnOpen then result = old_OnOpen(file) end
	get_abbrev = true
	return result
end
