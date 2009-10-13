--[[-------------------------------------------------
MakeAbbrev.lua
Version: 1.5
Author: frs, mozers™
-------------------------------------------------
add selected text to SciTE Abbreviation, enter the abbreviature in a dialog
добавляем выделенный текст в аббревиатуры данного языка, задать аббревиатуру можно в диалоговом окне
-------------------------------------------------
Для подключения добавьте в свой файл .properties следующие строки:
 command.parent.96=9
 command.name.96.*=Add to Abbreviation
 command.96.*=dofile $(SciteDefaultHome)\tools\MakeAbbrev.lua
 command.mode.96.*=subsystem:lua,savebefore:no
--]]-------------------------------------------------
require 'shell'

-- Возвращает текущий символ перевода строки
local function GetEOL()
	local eol = "\r\n"
	if editor.EOLMode == SC_EOL_CR then
		eol = "\r"
	elseif editor.EOLMode == SC_EOL_LF then
		eol = "\n"
	end
	return eol
end

local sel_text = editor:GetSelText()
if #sel_text < 10 then return end --ограничим минимум длины строки для аббревиатуры

local title = scite.GetTranslation("Abbreviation")
local text = scite.GetTranslation("Enter abbreviation for code:")

local key = sel_text:match("%w+")
key = shell.inputbox(title, text, key, function(name) return not name:match('[# \t=]') end)
if key == nil then return end

local abbrev_file_text = ''
local abbrev_file = io.open(props["AbbrevPath"])
if abbrev_file then
	abbrev_file_text = abbrev_file:read('*a').."\r\n"
	abbrev_file:close()
end

io.output(props["AbbrevPath"])
sel_text = sel_text:gsub("\\","\\\\"):gsub(GetEOL(),"\\n"):gsub("\t","\\t")
io.write(abbrev_file_text..key.."="..sel_text)
io.close()
