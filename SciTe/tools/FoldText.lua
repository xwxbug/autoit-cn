--[[--------------------------------------------------
FoldText.lua
mozers™
version 1.1
------------------------------------------------------
It is primitive variant of Steve Donovan's script <http://lua-users.org/wiki/SciteTextFolding>
extman.lua is not required.
------------------------------------------------------
Упрощенный вариант скрипта Стива Донована <http://lua-users.org/wiki/SciteTextFolding>
для организации фолдинга в файлах, лексеры которых его не обеспечивают.
Данный скрипт добавляет свертку в текстовые файлы.
В качестве признака начала очередного блока используется символ, заданный параметром fold.text.outline.
Количество таких символов, расположенных в начале блока текста, обозначает уровень вложенности данного блока.
Например:
*PART 1
  any text
  any text

  **PARTITION 1.1
    any text
    any text

  **PARTITION 1.2
    any text
    any text

    ***SubPartition 1.2.1
       any text
       any text

    ***SubPartition 1.2.2
       any text
       any text

*PART 2
  any text
  any text

Если в параметре fold.text.outline вместо символа задать 1, то началом блока свертки будут считаться пронумерованные заголовки.
Например:
1 PART
  any text
  any text

  1.1 PARTITION
    any text
    any text

  1.2 PARTITION
    any text
    any text

    1.2.1 SubPartition
       any text
       any text

    1.2.2 SubPartition
       any text
       any text

2 PART
  any text
  any text

------------------------------------------------------
Подключение:
В файл SciTEStartup.lua добавьте строку:
  dofile (props["SciteDefaultHome"].."\\tools\\FoldText.lua")

Задайте в файле .properties символ начала блока свертывания
  fold.text.outline=# (символ * используется по умолчанию)
или
  fold.text.outline=1 (для использования нумерованных заголовков)
и расширения обрабатываемых файлов:
  fold.text.ext=txt,doc
------------------------------------------------------
Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\tools\\FoldText.lua")

Optional set in a file .properties:
  fold.text.outline=# (change the character used. * as default)
or
  fold.text.outline=1 (use numbered sections, like 1.2.1)
and
  fold.text.ext=txt,doc
--]]----------------------------------------------------

local num_pos = ""
local fold_text_outline = props["fold.text.outline"]
if fold_text_outline == "" then fold_text_outline = "*" end

local function set_level(line_num, level, fold)
	-- print(line_num, level, fold)
	local foldlevel = level + SC_FOLDLEVELBASE
	if fold then
		foldlevel = foldlevel + SC_FOLDLEVELHEADERFLAG
		editor.FoldExpanded[line_num] = true
	end
	editor.FoldLevel[line_num] = foldlevel
end

local function get_level(line_num)
	local line = editor:GetLine(line_num)
	if line ~= nil then
		local outline
		if fold_text_outline ~= "1" then
			-- chars (e.g. "*** Chapter Two")
			outline = string.match (line, "^%s*(%"..fold_text_outline.."+)")
			if outline ~= nil then
				return string.len(outline)
			end
		else
			-- number (e.g. "Chapter 2.3.1" or "3.1 Header")
			local _, level
			level = 0
			if num_pos == "start" or num_pos == "" then
				outline = string.match(line,"^%s*([%d%.]+)")
				if outline ~= nil then
					_, level = string.gsub(outline, "%d+", "")
				end
				if level > 0 then num_pos = "start" end
			end
			if num_pos == "end" or num_pos == "" then
				outline = string.match(line,"%s([%d%.]+)%s*$")
				if outline ~= nil then
					_, level = string.gsub(outline, "%d+", "")
				end
				if level > 0 then num_pos = "end" end
			end
			if level > 0 then return level end
		end
	end
	return nil
end

local function fold()
	num_pos = ""
	local current_level = 0
	for i = 0, editor.LineCount do
		local new_level = get_level(i)
		if new_level == nil then
			set_level(i, current_level, false)
		else
			set_level(i, new_level-1, true)
			current_level = new_level
		end
	end
end

-- Add user event handler OnOpen
local old_OnOpen = OnOpen
function OnOpen(file)
	local result
	if old_OnOpen then result = old_OnOpen(file) end
	if string.find(props['fold.text.ext'], string.lower(props['FileExt']), 1, true) ~= nil then
		fold()
	end
	return result
end
