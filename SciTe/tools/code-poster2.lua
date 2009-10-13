-- Code Poster
-- Version: 3.0.1
-- Author: mozers™, frs (Идея и первая реализация: VladVRO)
---------------------------------------------------
-- Description:
-- конвертирует выделенный текст или весь файл в форматированный текст форума,
-- в точном соответствии с заданными в редакторе стилями (color, bold, italics)

-- Для подключения добавьте в свой файл .properties следующие строки:
--  command.name.125.*=Преобразовать в код для форума
--  command.125.*=dofile $(SciteDefaultHome)\tools\code-poster2.lua
--  command.mode.125.*=subsystem:lua,savebefore:no

-- ремарки по использованию:
--  в скрипте используются функция shell.msgbox
--  (сборка Ru-Board, http://scite.net.ru)
---------------------------------------------------
require 'shell'

function DEC_HEX(IN)
	local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
	while IN>0 do
		I=I+1
		IN,D=math.floor(IN/B),math.mod(IN,B)+1
		OUT=string.sub(K,D,D)..OUT
	end
	OUT = string.match("000000"..OUT,'%x%x%x%x%x%x$')
	OUT = string.gsub(OUT,'(%x%x)(%x%x)(%x%x)','%3%2%1')
	return OUT
end

local function ReplaceForumTag(pos)
	local tag = editor:textrange(pos+1, pos+3)
	if string.sub(tag, 1, 1) == "/" then
		tag = editor:textrange(pos+2, pos+4)
	end
	if tag == "b]" or tag == "i]" or tag == "s]" or tag == "u]" or tag == "st" or tag == "c]" or tag == "ce" or tag == "su" or tag == "si" or tag == "co" or tag == "fo" or tag == "qu" or tag == "q]" or tag == "no" or tag == "hr" or tag == "ur" or tag == "em" or tag == "im" or tag == "li" or tag == "*]" or tag == "ta" or tag == "tr" or tag == "br" or tag == "#]" or tag == "mo" then
		return "[no][[/no]"
	else
		return "["
	end
end

-----------------------------------

local sel_start = editor.SelectionStart
local sel_end = editor.SelectionEnd
local line_start = editor:LineFromPosition(sel_start)+1
-- Если ничего не выделено, то берем весь текст
if sel_start == sel_end then
	line_start = 0
	sel_start = 0
	sel_end = editor:PositionFromLine(editor.LineCount)
end

local fore
local fore_old = 0
local italics
local italics_old = false
local bold
local bold_old = false
local forum_text =""
-----------------------------------
for i = sel_start, sel_end-1 do
	local char = editor:textrange(i,i+1)
	if char == "\t" then char = string.rep(" ", props["tabsize"]) end
	if char == "[" then char = ReplaceForumTag(i) end
	if not string.find(char,"%s") then
		local style_num = editor.StyleAt[i]
		--------------------------------------------
		italics = editor.StyleItalic[style_num]
		if italics ~= italics_old then
			if italics then
				forum_text = forum_text.."[i]"
			else
				forum_text = forum_text.."[/i]"
			end
			italics_old = italics
		end
		--------------------------------------------
		bold = editor.StyleBold[style_num]
		if bold ~= bold_old then
			if bold then
				forum_text = forum_text.."[b]"
			else
				forum_text = forum_text.."[/b]"
			end
			bold_old = bold
		end
		--------------------------------------------
		fore = editor.StyleFore[style_num]
		if fore ~= fore_old and fore_old ~= 0 then
			forum_text = forum_text.."[/color]"
		end
		if fore ~= fore_old and fore ~= 0 then
			forum_text = forum_text.."[color=#"..DEC_HEX(fore).."]"
		end
		fore_old = fore
	end
	forum_text = forum_text..char
end
-----------------------------------
if fore ~= 0 then
	forum_text = forum_text.."[/color]"
end
if italics then
	forum_text = forum_text.."[/i]"
end
if bold then
	forum_text = forum_text.."[/b]"
end
-----------------------------------

local header = "[b][color=Blue]"..props["FileNameExt"].."[/color][/b]"
if line_start ~= 0 then
	header = header.." [s][[b]строка "..line_start.."[/b]][/s]"
end
local more = ""
local more_end = ""
if editor:LineFromPosition(sel_end) - line_start > 10 then
	more = "[more]"
	more_end = "[/more]"
end

forum_text = header.." : "..more.."[code]"..forum_text.."[/code]".."  [color=Purple][font=Wingdings][size=4]?[/size][/font]  [s]Код создан и опубликован с помощью[/s] [url=http://forum.ru-board.com/topic.cgi?forum=5&topic=24956&glp][s]SciTE-Ru[/s][/url][/color]"..more_end
editor:CopyText(forum_text)
shell.msgbox ("Код для форума успешно сформирован\n и помещен в буфер обмена", "Формирование кода для форума")