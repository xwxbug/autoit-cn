--[[--------------------------------------------
xComment
Version: 1.4.1
Author: mozers™, VladVRO
-------------------------------------------------
  C блеском заменяет стандартную комбинацию Ctrl+Q (комментирование|снятие комментария)

Вид комментария зависит от выделения текста:
  * Если выделен поток текста, то скрипт ставит|снимает потоковый комментарий.
  * Если выделена целая строка(включая символ перевода строки) или несколько строк, то то скрипт ставит|снимает блочный комментарий.
  * Если выделение отсутствует, то ставится|снимается блочный комментарий на текущую строку.
  * Если параметры comment.stream.* отсутсвуют, то независимо от способа выделения ставится|снимается блочный комментарий.

Снятие/установка комментария зависит от первого символа выделения:
  * Если первый символ в выделении закомментированн, то комментарий снимается со всего выделения.
  * Если - нет, то на все выделение ставится комментарий.

Подключение:
В файл SciTEStartup.lua добавьте строку:
  dofile (props["SciteDefaultHome"].."\\tools\\xComment.lua")
Задайте в файле .properties используемых вами языков параметры:
  comment.block.lexer
  comment.block.at.line.start.lexer
  comment.stream.start.lexer
  comment.stream.end.lexer

И забудьте навсегда про этот атавизм "~". Тильда вам больше никогда не понадобится!
Внимание: В скрипте используется функция IsComment (обязательно подключение COMMON.lua)
--]]--------------------------------------------

-- local iDEBUG = true -- включается при отладке скрипта
local lexer = ""
local sel_text = ""
local sel_start = 0
local sel_end = 0
local line_sel_start = 0
local line_sel_end = 0
local comment_block = ""
local comment_block_at_line_start = 0
local comment_block_use_space = 1 -- можно задать кол-во пробелов, отделяющих коммент от кода
local comment_stream_start = ""
local comment_stream_end = ""
local PatternStream = ""

--------------------------------------------------
local function Pattern(text)
-- Получение паттерна для поиска символов комментария в тексте
	local pat = ""
	for i = 1, string.len(text) do
		pat = pat.."%"..string.sub(text,i,i)
	end
	return pat
end

---------------------------------------------
local function FirstLetterFromBlock()
-- Возвращает позицию первого не пробельного символа в блоке
	local text_line = sel_text
	if sel_text == "" then
		text_line = editor:GetLine(line_sel_start)
		sel_start = editor:PositionFromLine(line_sel_start)
	end
	local first_letter, _, _ = string.find(text_line, "[^%s]", 1)
	if first_letter ~= nil then
			first_letter = sel_start + first_letter - 1
	else
		first_letter = -1
	end
	if iDEBUG then print("FirstLetterFromBlock = "..first_letter) end
	return first_letter
end

--------------------------------------------------
local function IsBlock()
-- Определение что выделено - блок или поток
	if sel_text == "" then return true end
	if sel_end > 0 and editor.CharAt[sel_end - 1] == 10 then
		if iDEBUG then print ("This Block") end
		return true
	end
	if iDEBUG then print ("This NOT Block") end
	return false
end

--------------------------------------------------
local function IsStreamComment()
-- Определение что выделено - потоковый комментарий или закомментированные строки
	if PatternStream ~= "" then
		if string.find(sel_text,PatternStream) then
			if iDEBUG then print ("This Stream Comment") end
			return true
		end
	end
	if iDEBUG then print ("This NOT Stream Comment") end
	return false
end

--------------------------------------------------
local function LineComment()
-- Комментирование одной невыделенной строки
	if iDEBUG then print ("Line Comment") end
	if comment_block == "" then
		print("! Отсутствует параметр ".."comment.block."..lexer)
	else
		comment_block = comment_block..string.rep(" ", comment_block_use_space)
		local cur_pos = editor.CurrentPos
		if comment_block_at_line_start == 1 then
			editor:GotoPos(editor:PositionFromLine(line_sel_start))
		else
			editor:GotoPos(editor.LineIndentPosition[line_sel_start])
		end
		editor:ReplaceSel(comment_block)
		editor:GotoPos(cur_pos + string.len(comment_block))
	end
end

--------------------------------------------------
local function BlockComment()
-- Комментирование нескольких выделенных строк
	if iDEBUG then print ("Block Comment") end
	if comment_block == "" then
		print("! Отсутствует параметр ".."comment.block."..lexer)
	else
		comment_block = comment_block..string.rep(" ", comment_block_use_space)
		local text_comment = ""
		for i = line_sel_start, line_sel_end-1 do
			local text_line = editor:GetLine(i)
			if string.find(text_line,"[^%s]") then
				if comment_block_at_line_start == 1 then
					text_comment = text_comment..comment_block..text_line
				else
					text_comment = text_comment..string.gsub(text_line,"([^%s])",comment_block.."%1",1)
				end
				sel_end = sel_end + string.len(comment_block)
			else
				text_comment = text_comment..text_line
			end
		end
		editor:ReplaceSel(text_comment)
		-- восстанавливаем выделение
		editor:SetSel(sel_start, sel_end)
	end
end

--------------------------------------------------
local function LineUnComment()
-- Снятие комментария с одной невыделенной строки
	if iDEBUG then print ("Line UnComment") end
	if comment_block == "" then
		print("! Отсутствует параметр ".."comment.block."..lexer)
	else
		local cur_pos = editor.CurrentPos
		local text_line = editor:GetCurLine()
		local comment_pos, _ = string.find(text_line,Pattern(comment_block).."~? ?", 1)
		local line_uncomment = string.gsub(text_line,Pattern(comment_block).."~? ?","",1)
		local line_pos_start = editor:PositionFromLine(line_sel_start)
		local line_pos_end = line_pos_start + string.len(text_line)
		editor:SetSel(line_pos_start, line_pos_end)
		editor:ReplaceSel(line_uncomment)
		if comment_pos and cur_pos > (line_pos_start + comment_pos) then
			editor:GotoPos(cur_pos - string.len(text_line) + string.len(line_uncomment))
		else
			editor:GotoPos(cur_pos)
		end
	end
end

--------------------------------------------------
local function BlockUnComment()
-- Снятие комментария с нескольких выделенных строк
	if iDEBUG then print ("Block UnComment") end
	if comment_block == "" then
		print("! Отсутствует параметр ".."comment.block."..lexer)
	else
		local text_uncomment = ""
		for i = line_sel_start, line_sel_end-1 do
			local text_line = editor:GetLine(i)
			local line_uncomment = string.gsub(text_line,Pattern(comment_block).."~? ?","",1)
			text_uncomment = text_uncomment..line_uncomment
			if line_uncomment ~= text_line then
				sel_end = sel_end - string.len(text_line) + string.len(line_uncomment)
			end
		end
		editor:ReplaceSel(text_uncomment)
		-- восстанавливаем выделение
		editor:SetSel(sel_start, sel_end)
	end
end

--------------------------------------------------
local function StreamComment()
-- Комментирование выделенного потока текста
	if iDEBUG then print ("Stream Comment") end
	if comment_stream_start == "" or comment_stream_end == "" then
		print("! Отсутствуют параметры ".."comment.stream.start."..lexer.." и ".."comment.stream.end."..lexer)
	else
		local text_comment = comment_stream_start..sel_text..comment_stream_end
		editor:ReplaceSel(text_comment)
		if sel_text ~= "" then
			-- восстанавливаем выделение
			editor:SetSel(sel_start, sel_end + string.len(comment_stream_start) + string.len(comment_stream_end))
		end
	end
end

--------------------------------------------------
local function StreamUnComment()
-- Снятие комментария с выделенного потока текста
	if iDEBUG then print ("Stream UnComment") end
	if PatternStream == "" then
		print("! Отсутствуют параметры ".."comment.stream.start."..lexer.." и ".."comment.stream.end."..lexer)
	else
		local text_uncomment = string.gsub(sel_text,PatternStream,"%1",1)
		editor:ReplaceSel(text_uncomment)
		if sel_text ~= "" then 
			-- восстанавливаем выделение
			editor:SetSel(sel_start, sel_end - string.len(comment_stream_start) - string.len(comment_stream_end))
		end
	end
end

---------------------------------------------
local function xComment()
-- Обработка нажатия на Ctrl+Q
	lexer = editor.LexerLanguage
	sel_text = editor:GetSelText()
	sel_start = editor.SelectionStart
	sel_end = editor.SelectionEnd
	line_sel_start = editor:LineFromPosition(sel_start)
	line_sel_end = editor:LineFromPosition(sel_end)
	comment_block = props["comment.block."..lexer]

	comment_block_at_line_start = tonumber(props["comment.block.at.line.start."..lexer])
	comment_stream_start = props["comment.stream.start."..lexer]
	comment_stream_end = props["comment.stream.end."..lexer]

	if sel_text == "" then
		-- This Line
		if IsComment(FirstLetterFromBlock()) then
			LineUnComment()
		else
			LineComment()
		end
		return true
	end

	if IsBlock() then
	-- This Block
		if IsComment(FirstLetterFromBlock()) then
			BlockUnComment()
		else
			BlockComment()
		end
	else
	-- This Stream
		if comment_stream_start ~= "" and comment_stream_end ~= "" then
			PatternStream = Pattern(comment_stream_start).."(.-)"..Pattern(comment_stream_end)
		else
			-- если параметры comment.stream.* отсутствуют, то расширяем выделение потока до блока
			-- и комментируем|сниманием блочный комментарий
			-- (предложение frs <http://forum.ru-board.com/topic.cgi?forum=5&topic=24956&start=660#6>)
			line_sel_end = line_sel_end + 1
			editor:SetSel(editor:PositionFromLine(line_sel_start), editor:PositionFromLine(line_sel_end))
			-- This Block
			if IsComment(FirstLetterFromBlock()) then
				BlockUnComment()
			else
				BlockComment()
			end
			return true
		end

		if IsStreamComment() then
			StreamUnComment()
		else
			StreamComment()
		end
	end
	return true
end

--------------------------------------------------
-- Add user event handler OnMenuCommand
local old_OnMenuCommand = OnMenuCommand
function OnMenuCommand (msg, source)
	local result
	if old_OnMenuCommand then result = old_OnMenuCommand(msg, source) end
	if msg == IDM_BLOCK_COMMENT then -- (Ctrl+Q)
		if xComment() then return true end
	end
	return result
end
