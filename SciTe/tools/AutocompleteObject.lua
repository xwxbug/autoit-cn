--[[--------------------------------------------------
AutocompleteObject.lua
mozers™, Tymur Gubayev
version 3.10.4
------------------------------------------------------
Inputting of the symbol set in autocomplete.[lexer].start.characters causes the popup list of properties and methods of input_object. They undertake from corresponding api-file.
In the same case inputting of a separator changes the case of symbols in input_object's name according to a api-file.
(for example "ucase" is automatically replaced on "UCase".)

Warning: This script needed function IsComment and string.pattern (COMMON.lua)
props["APIPath"] available only in SciTE-Ru

Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\tools\\AutocompleteObject.lua")
Set in a file .properties:
  autocomplete.lua.start.characters=.:

------------------------------------------------------
Ввод разделителя, заданного в autocomplete.[lexer].start.characters
вызывает список свойств и медодов объекта из соответствующего api файла
Ввод разделителя изменяют регистр символов в имени объекта в соответствии с записью в api файле (например "ucase" при вводе автоматически заменяется на "UCase")

Внимание: В скрипте используется функция IsComment и string.pattern из COMMON.lua
props["APIPath"] доступно только в SciTE-Ru

Подключение:
В файл SciTEStartup.lua добавьте строку:
  dofile (props["SciteDefaultHome"].."\\tools\\AutocompleteObject.lua")
задайте в файле .properties соответствующего языка
символ, после ввода которого, будет включатся автодополнение:
  autocomplete.lua.start.characters=.:
------------------------------------------------------
Для понимания алгоритма работы скрипта, условимся, что в записи
azimuth:left;list-style-|type:upper-roman
где курсор стоит в позиции, отмеченной знаком "|", а символ "-" является одним из разделителей, часть
list-style  - будет называться "объект"
type        - будет называться "метод"
Все вышесказанное относится ко всем языкам программирования (css тут - только для примера)
Скрипт будет корректно работать только с "правильными" api файлами (см. описание формата в ActiveX.api)
------------------------------------------------------
Совет:
Если после ввода разделителя список свойств и методов не возник (хотя они описаны в api файле)
то, возможно, скрипт не смог распознать имя вашего объекта.
Помогите ему в этом, дописав такую строчку в редактируемый документ:
mydoc = document
где mydoc - имя Вашего объекта
document - имя этого же объекта, заданное в api файле
------------------------------------------------------
History:
3.10.3 (Tymur):
	- функция преобразования стринга в паттерн для поиска вынесена в COMMON.lua
3.0 (Tymur):
	- скрипт стал чуть более case sensitive по сравнению со старым
	* переписал таблицы objects_table, alias_table из массивов строк в таблицы со строковыми ключами
	* попутно выполнил задачи 1 и 2 из списка выше
	+ добавил фичу для луа: распознавание строковых переменных в коде (ассоциируются с таблицей string)
	+ добавил в тестовом режиме слегка изменённый режим распознавания имён объектов. См. new_delim_behavior
	* FindDeclaration() ищет определения в соответствии с языком: допустимые символы берутся из $(word.characters.$(file.patterns.LANGUAGE))$(autocomplete.LANGUAGE.start.characters)
	* в целом скрипт должен работать быстрее (особенно после первого вызова) за счёт объединения выполнения старых CreateObjectsTable() и CreateAliasTable() за один проход, и только по необходимости (get_api == true)
	* исправил старый баг, описанный в сообщении VoidVolker: http://forum.ru-board.com/topic.cgi?forum=5&topic=24956&start=840#5
	Проверено только для Луа, пока что работает :)
	+ если в api-файле Луа втречаются строчки вида: t["a-b+c"]\nэто очень хитрый параметр
	  то имеет смысл добавить в autocomplete.lua.start.characters символ '['
3.01(Tymur):
	+ скрипт опять нечувствительный к регистру (см. "-" версии 3.0)
	+ автоматически исправляется регистр символов введенного имени объекта (слово слева от разделителя) на указанный в api-файле (для Луа: StriNG станет string), но только при использовании автодополнения.
3.05(Tymur):
	* исправление регистра происходит непосредственно после ввода разделителя
	+ по многочисленным просьбам трудящихся теперь роль new_delim_behavior играет props["autocomplete.object.alt"]=="1", так что желающие наслаждаться новым алгоритмом должны прописать соотв. настройку.
	* исправлена ошибка нового алгоритма, когда он не работал для *.css (и не только) файлов (Обнаружил mozers). Теперь можно из word.characters.*.css убрать символ "-".
	* улучшена обратная совместимость нового алгоритма: при отсутствии объекта для длинного варианта имени (новый алгоритм) используется короткое имя (без разделителей) (старый алгоритм).
3.06(mozers):
	* Параметр autocomplete.object.alt и переменная new_delim_behavior_better_buggy заменены на единый параметр autocomplete.object.method=0|1|2 с помощью которого можно выбрать один из трех алгоритмов обработки.
3.07(mozers):
	- Параметр autocomplete.object.method теперь не используется. Вся обработка ведется одним алгоритмом.
	* Функция GetInputObject переписана. Используется доработка [GetWordChars] BioInfo.
3.08(mozers):
	* Поиск в тексте определений объектов и стрингов выделен в отдельные процедуры IsObject и IsString
	* Теперь в lua методы объекта string выводятся после точки, а аналогичные методы строковых переменных - после : (потребовалась доработка SciTELua.api)
3.09(Tymur):
	- IsString упразднена за ненадобностью
	+ теперь в .api файлах допустима конструкция вида #$string_value=^'.*' и даже #$file=io.open%b(). Часть справа от знака "=" -- паттерн, используемый для распознавания объекта. Т.о. возможно расширить функциональность фичи для распознавания строк на всё, что ловиться регулярными выражениями Луа.
	! скрипт сам по себе больше не распознаёт строковые объекты! Необходима правка .api-файлов:
		Например, в конце lua.api необходимо поместить следующие строчки:
			#$string_value=^".*"
			#$string_value=^'.*'
			#$string_value=^%[%[.*%]%]
3.10(Tymur):
	* пофикшен мелкий баг, когда не распознавались некоторые объекты ("azimuth:right-" не вызывал список с "side")
	* пофикшен паттерн распознавания методов (эффект заметен только если autocomplete.lexer.start.characters пересекаются с word.characters.lexer, например, для css)
3.10.2(Tymur):
	* очередной патч для css (в выпадающем списке больше не будут появляться неправильные элементы, сравн. "text-"до и после патча)
--]]----------------------------------------------------

local current_pos = 0    -- текущая позиция курсора, важно для InsertMethod
local sep_char = ''      -- введенный с клавиатуры символ (в нашем случае - один из разделителей ".:")
local auto_start_chars_patt = '' -- паттерн, содержащий экранированные символы из параметра autocomplete.lexer.start.characters
local get_api = true     -- флаг, определяющий необходимость перезагрузки api файла
local api_table = {}     -- все строки api файла (очищенные от ненужной нам информации)
local objects_table = {} -- все "объекты", найденные в api файле в виде objects_table[objname]=true
local alias_table = {}   -- сопоставления "объект = синоним"
local patterns_table = {}-- сопоставления "объект = паттерн для проверки строки"
local methods_table = {} -- все "методы" заданного "объекта", найденные в api файле
local object_names = {}  -- все имена имеющихся api файле "объектов", которым соответствует найденный в текущем файле "объект"
local autocomplete_start_characters = '' -- символы разделители объектов (из параметра autocomplete.lexer.start.characters)
local object_good_name = '' -- "хорошее" имя объекта, так, как указано в api-файле, учитывая регистр
local word_chars_patt = ''

------------------------------------------------------
-- Сортирует таблицу по алфавиту и удаляет дубликаты
local function TableSort(table_name)
	table.sort(table_name, function(a, b) return a:upper() < b:upper() end)
	-- remove duplicates
	for i = #table_name-1, 0, -1 do
		if table_name[i] == table_name[i+1] then
			table.remove (table_name, i+1)
		end
	end
	return table_name
end

------------------------------------------------------
-- Извлечение из api-файла реальных имен объектов, которые соответствуют введенному
-- т.е. введен "объект" wShort, а методы будем искать для WshShortcut и WshURLShortcut
local function GetObjectNames(text)
	local TEXT = text:upper()
	local obj_names = {}
	-- Поиск по таблице имен "объектов"
	if objects_table[TEXT] then
		obj_names[1] = objects_table[TEXT]
		return obj_names, objects_table[TEXT] -- если успешен, то завершаем поиск
	end
	
	-- Поиск по таблице сопоставлений "объект - синоним"
	if alias_table[TEXT] then
		for _,v in pairs(alias_table[TEXT]) do obj_names[#obj_names+1] = v end
		return obj_names , (alias_table[TEXT] and alias_table[TEXT]())
	end

	-- Проверка по паттернам:
	for obj_name, patterns in pairs(patterns_table) do
		for _, patt in ipairs(patterns) do
			if text:find(patt) then
				obj_names[#obj_names+1] = obj_name
			end
		end	
	end
	return obj_names , nil -- если нашли по паттерну, то нет "правильного" имени объекта, на которое можно было бы исправить введенное
end

------------------------------------------------------
-- Извлечение из текущего файла имени объекта, с которым "работаем":
-- Берем "слово" слева от курсора, причем считаем символы autocomplete.start.characters частью этого слова
local function GetInputObject()
	local word_chars = editor.WordChars
	-- добавляем разделители - они теперь тоже часть слова
	editor.WordChars = word_chars..autocomplete_start_characters
	
	-- если разделитель стоит после скобок -- берём слово слева от скобок вместе с ними.
	-- нужно для продвинутых алиасов-паттернов
	local word_start_pos = editor:BraceMatch(current_pos-2)
	if word_start_pos == -1 then word_start_pos = current_pos end
	-- пусть за нас сделает всю работу editor:WordStartPosition
	word_start_pos = editor:WordStartPosition(word_start_pos-1)
	-- возвращаем настройки назад
	editor.WordChars = word_chars
	return editor:textrange(word_start_pos, current_pos-1)
end

------------------------------------------------------
-- возвращает пустую таблицу-функцию, которая возвращает "правильное" имя
local function CreateAliasEntry(obj)
	return setmetatable({}, { __call = function () return obj end })
end

------------------------------------------------------
-- добавлям алиас в таблицу сопоставлений "объект - синоним"
local function AddAlias(alias, obj)
	local ALIAS = alias:upper()
	-- если впервые такое слово, создаём таблицу
	alias_table[ALIAS] = alias_table[OBJ] or CreateAliasEntry(alias)
	-- добавляем синоним alias к объекту obj
	alias_table[ALIAS][obj:upper()] = obj
end

------------------------------------------------------
-- добавлям паттерн в таблицу сопоставлений "объект - паттерн"
local function AddPattern(obj, patt)
	-- если впервые такое слово, создаём таблицу
	patterns_table[obj] = patterns_table[obj] or {}
	-- добавляем паттерн patt к объекту obj
	table.insert(patterns_table[obj], patt)
end

------------------------------------------------------
-- проверка не является ли текст определением объекта
local function IsObject(text)
	-- делаем таблицу слов для проверки. На первом месте вся строка целиком -- для проверки на паттерн.
	local words_to_test = {text}
	for words in text:gmatch(word_chars_patt) do
		words_to_test[#words_to_test+1] = words
	end
	
	for _, sValue in ipairs(words_to_test) do
		local objects = GetObjectNames(sValue)
		for i = 1, #objects do
			-- следующая проверка нужна чтобы вернуть действительно _имя_ объекта, а не алиас.
			if objects_table[objects[i]:upper()] then
				return objects[i]
			end
		end
		--@debug: это на всякий пожарный случай.
		if #objects > 0 then
			print('ATTENTION: object '..sValue..' has only aliases, and no correct name!\n\tSee function IsObject from AutocompleteObject.lua')
		end
	end --for words in text
	--return ''
end

------------------------------------------------------
-- Поиск деклараций присвоения пользовательской переменной реального объекта
-- т.е. в текущем файле ищем конструкции вида "синоним = объект"
local function FindDeclaration()
	local text_all = editor:GetText()
	local _start, _end, sVar, sRightString
	-- берём то, что хранится в, например, word.characters.$(file.patterns.lua)
	word_chars_patt = '['..editor.WordChars:pattern()..auto_start_chars_patt..']+'

	-- @todo: правую часть также хорошо бы слегка поправить.
	local pattern = '('..word_chars_patt..')%s*=%s*(%C+)'
	_start = 1
	while true do
		_start, _end, sVar, sRightString = text_all:find(pattern, _start)
		if _start == nil then break end
		-- убираем пробелы в начале/конце
		sRightString = sRightString:gsub("^%s*(%S*)%s*$", "%1")
		if sRightString ~= '' then
			-- анализируем текст справа от знака "="
			-- проверяем, а не содержится ли там описанный в api объект?
			local obj = IsObject(sRightString)
			-- если действительно, такой "объект" существует, то добавляем его в таблицу сопоставлений "объект - синоним"
			if obj then AddAlias(sVar, obj) end
		end
		_start = _end + 1
	end
end

------------------------------------------------------
-- Чтение api файла в таблицу api_table (чтобы потом не опрашивать диск, а все тащить из нее)
local function CreateAPITable()
	api_table = {}
	local word_patt = editor.WordChars:pattern()
	local word_extended_patt = '['..word_patt..auto_start_chars_patt..']'
	for api_filename in props["APIPath"]:gmatch("[^;]+") do
		if api_filename ~= nil then
			local api_file = io.open(api_filename)
			if api_file then
				for line in api_file:lines() do
					-- обрезаем комментарии, оставляя алиасы-паттерны без изменений
					line = line:match('^#$%s*'..word_extended_patt..'+=.+$') or line:match('^[^%s%(]+')
					if line then
						api_table[#api_table+1] = line
					end
				end
				api_file:close()
			end
		end
	end
	get_api = false
	return false
end

------------------------------------------------------
-- Создание таблицы, содержащей все имена "объектов" описанных в api файле
-- Создание таблицы, содержащей все сопоставления "#синоним = объект" описанные в api файле
local function CreateObjectsAndAliasTables()
	objects_table = {}
	alias_table = {}
	patterns_table = {}
	local word_patt = editor.WordChars:pattern()
	local word_extended_patt = '['..word_patt..auto_start_chars_patt..']'
	word_patt = '['..word_patt..']'
	
	for i = 1, #api_table do
		local line = api_table[i]
		-- здесь КРАЙНЕ ВАЖНО, чтобы в матче был именно [auto_start_chars_patt], т.е. например "[.:]" для Луа
		-- т.к. эта таблица строится только при api_get, может выйти фигня.
		local obj_name = line:match('^[^#]') and line:match('^('..word_extended_patt..'*)['..auto_start_chars_patt..']')
		if obj_name then objects_table[obj_name:upper()]=obj_name end

		-- для строк вида "#a=b" записываем a,b в таблицу алиасов
		local sObj, sAlias = line:match('^#('..word_extended_patt..'+)=(%S+)$') --@todo: подумать над паттерном...
		if sObj then
			AddAlias(sAlias, sObj)
		end

		-- для строк вида "#$a=b" записываем a,b в таблицу паттернов
		local sObj, sPatt = line:match('^#$%s*('..word_extended_patt..'+)=(.+)$') --@todo: подумать над паттерном...
		if sObj then
			AddPattern(sObj, sPatt)
		end
	end
end

------------------------------------------------------
-- Создание таблицы "методов" заданного "объекта"
local function CreateMethodsTable(obj)
	for i = 1, #api_table do
		local line = api_table[i]
		-- ищем строки, которые начинаются с заданного "объекта"
		local _start, _end = line:find(obj..sep_char, 1, true)
		if _end ~= nil and line:sub(1,1)~='#' and
			(_start == 1 or line:gsub(_start-1,_start-1)==sep_char) then
			-- local _start, _end, str_method = line:find('([^'..auto_start_chars_patt..']+)', _end+1)
			local _start, _end, str_method = line:find('(['..editor.WordChars:pattern()..']+)', _end+1)
			if _start ~= nil then
				methods_table[#methods_table+1] = str_method
			end
		end
	end
end

------------------------------------------------------
-- Показываем раскрывающийся список "методов"
local function ShowUserList()
	if #methods_table == 0 then return false end
	local sep = '•' -- разделитель для строки раскрывающегося списка
	local methods_list = table.concat(methods_table, sep)
	if methods_list == '' then return false end
	local sep_tmp = editor.AutoCSeparator
	editor.AutoCSeparator = string.byte(sep)
	editor:UserListShow(7, methods_list)
	editor.AutoCSeparator = sep_tmp
	return true
end

------------------------------------------------------
-- Вставляет выбранный из раскрывающегося списка метод в редактируемую строку
local function InsertMethod(str)
	-- current_pos указывает, где мы были при вводе разделителя, editor.CurrentPos сейчас - это начало слова слева от current_pos, str содержит это слово+разделитель+что надо добавить.
	editor:SetSel(current_pos, editor.CurrentPos)
	editor:ReplaceSel(--[[object_good_name..]]str)
end

-- Заменяет введенное имя объекта на его имя из api файла (например, 'wscript' на 'WScript'))
local function CorrectRegisterSymbols(object_name)
	editor:SetSel(current_pos - #object_name, current_pos)
	editor:ReplaceSel(object_name)
end

-- ОСНОВНАЯ ПРОЦЕДУРА (обрабатываем нажатия на клавиши)
local function AutocompleteObject(char)
	if IsComment(editor.CurrentPos-2) then return false end  -- Если строка закомментирована, то выходим

	autocomplete_start_characters = props["autocomplete."..editor.LexerLanguage..".start.characters"]
	-- Если в параметр autocomplete.lexer.start.characters пустой, то выходим
	if autocomplete_start_characters == '' then return false end

	-- workaround для проблемы исчезающих списков
	-- если char НЕ из autocomplete.lexer.start.characters то
	if not autocomplete_start_characters:find(char, 1, 1) then
		local word_start = editor:WordStartPosition(editor.CurrentPos)
		local leftchar = editor:textrange(word_start-1, word_start)
		-- если слева от начала слова всё-таки разделитель, то возвращаем статус списка: показан/непоказан.
		-- т.о., если показывается список, то все следующие обработчики OnChar не срабатывают.
		return autocomplete_start_characters:find(leftchar, 1, 1) and editor:AutoCActive()
	end

	-- Наконец то мы поняли что введенный символ - именно тот разделитель!
	sep_char = char
	auto_start_chars_patt = autocomplete_start_characters:pattern()

	if get_api then
		CreateAPITable()
		CreateObjectsAndAliasTables()
	end
	-- если в api_table пусто - выходим.
	if not next(api_table) then return false end

	FindDeclaration()

	-- Важно: запоминаем текщую позицию курсора (Иначе "string.b|[Enter]" превратиться в "string.bbyte")
	current_pos = editor.CurrentPos

	-- Берем в качестве объекта слово слева от курсора, обновляем current_pos на начало слова слева от курсора.
	local input_object = GetInputObject(autocomplete_start_characters)

	-- Если слева от курсора отсутствует слово, которое можно истолковать как имя объекта, то выходим
	if input_object == '' then return false end

	object_names, object_good_name = GetObjectNames(input_object)
	if object_good_name and input_object ~= object_good_name then
		CorrectRegisterSymbols(object_good_name..char)
	end
	
	-- выходим, если введенное слово не имя объекта
	if not next(object_names) then return false end

	-- убиваем остатки старых методов, заполняем новыми
	methods_table = {}
	for i = 1, #object_names do
		CreateMethodsTable(object_names[i])
	end
	methods_table = TableSort(methods_table)
	return ShowUserList()
end

------------------------------------------------------
-- Add user event handler OnChar
local old_OnChar = OnChar
function OnChar(char)
	local result
	if old_OnChar then result = old_OnChar(char) end
	if props['macro-recording'] ~= '1' and AutocompleteObject(char) then return true end
	return result
end

-- Add user event handler OnUserListSelection
local old_OnUserListSelection = OnUserListSelection
function OnUserListSelection(tp,sel_value)
	local result
	if old_OnUserListSelection then result = old_OnUserListSelection(tp,sel_value) end
	if tp == 7 then
		if InsertMethod(sel_value) then return true end
	end
	return result
end

-- Add user event handler OnSwitchFile
local old_OnSwitchFile = OnSwitchFile
function OnSwitchFile(file)
	local result
	if old_OnSwitchFile then result = old_OnSwitchFile(file) end
	get_api = true
	return result
end

-- Add user event handler OnOpen
local old_OnOpen = OnOpen
function OnOpen(file)
	local result
	if old_OnOpen then result = old_OnOpen(file) end
	get_api = true
	return result
end

-- Add user event handler OnBeforeSave
local old_OnBeforeSave = OnBeforeSave
function OnBeforeSave(file)
	local result
	if old_OnBeforeSave then result = old_OnBeforeSave(file) end
	get_api = true
	return result
end