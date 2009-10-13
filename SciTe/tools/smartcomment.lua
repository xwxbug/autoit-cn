-- SciTE Smart comment
-- Version: 2.7
-- Author: Dmitry Maslov
---------------------------------------------------
-- Веделяем текст нажимаем на клавиатуре символ 
-- с которого начинается комментарий и строка комментируется
-- пример: выделить строку в cpp, нажать на клавишу * или /
---------------------------------------------------
-- Версия 2.7
-- Убраны части связанные с автозакрытием скобок
---------------------------------------------------
-- Версия 2.3
-- Скрипт сделан полностью автономным
---------------------------------------------------
-- Версия 2.2
-- Исправлен баг, если нажали не печатный символ
-- то скрипт вел себя не предсказуемо
---------------------------------------------------
-- Версия 2.1
-- Закрытие блочным комментирием во всех языках по первому 
-- символу блочного комментария во как загнул ;) 
-- Благодарность mozers за подсказку в реализации.
---------------------------------------------------
-- Версия 1.0
-- Обработка комментариев в cpp * и / (/**/ и //~ )
-- Обработка коментариев в lua - ( -- )
-- Обработка скобок в lua [ ( [[...]] )
-- Обработка комментария в props # ( #~ )
---------------------------------------------------

-- Возвращает текущий символ перевода строки
local function GetEOL()
	local eol = "\r\n"
	if editor.EOLMode == SC_EOL_CR
	then
		eol = "\r"
	elseif editor.EOLMode == SC_EOL_LF
	then
		eol = "\n"
	end
	return eol
end

-- сделать текст шаблоном для поиска
-- (фактически экранирование служебных символов)
local function MakeFind( text )
	local strres = ''
	local simbol
	for i = 1, string.len(text), 1
	do
		simbol = string.format( '%c', string.byte( text, i ) )
		if	( simbol == "(" )
			or
			( simbol == "[" )
			or
			( simbol == "." )
			or
			( simbol == "%" )
			or
			( simbol == "*" )
			or
			( simbol == "/" )
			or
			( simbol == "-" )
			or
			( simbol == ")" )
			or
			( simbol == "]" )
			or
			( simbol == "?" )
			or
			( simbol == "+" )
		then
			simbol = string.format( "%%%s", simbol )
		end
		strres = strres..simbol
	end
	return strres
end

-- предыдущий символ позиции конец строки?
local function prevIsEOL(pos)
	if string.find(editor:textrange(editor:PositionBefore(pos-string.len(GetEOL())+1), pos),GetEOL())
	then
		return true
	end
	return false
end

-- последний символ в строке - конец строки?
local function IsEOLlast(text)
	-- в луа конец строки всегда один символ
	if string.find(text,GetEOL(),string.len(text)-1)
	then
		return true
	end
	return false
end

local function StrimComment(commentbegin, commentend)
	local text, lenght = editor:GetSelText()
	local selbegin = editor.SelectionStart
	local selend = editor.SelectionEnd
	local b,e = string.find(text, MakeFind(commentbegin))
	if (e and (string.byte(text, e+1) == 10 or string.byte(text, e+1) == 13))
	then
		e=e+1 
	end
	if (e and (string.byte(text, e+1) == 10 or string.byte(text, e+1) == 13))
	then
		e=e+1 
	end
	local b2,e2
	if IsEOLlast(text)
	then
		b2,e2 = string.find(text, MakeFind(commentend), 
			string.len(text)-string.len(commentend)-string.len(GetEOL()))
	else
		b2,e2 = string.find(text, MakeFind(commentend), 
			string.len(text)-string.len(commentend))
	end
	if (b2 and (string.byte(text, b2-1) == 10 or string.byte(text, b2-1) == 13))
	then
		b2=b2-1 
	end
	if (b2 and (string.byte(text, b2-1) == 10 or string.byte(text, b2-1) == 13))
	then
		b2=b2-1 
	end
	editor:BeginUndoAction()
	if (b and b2)
	then
		local add=''
		if (string.find(text,GetEOL(),string.len(text)-string.len(GetEOL())))
		then
			add = GetEOL()
		end
		text = string.sub(text,e+1,b2-1)
		editor:ReplaceSel(text..add)
		editor:SetSel(selbegin, selbegin+string.len(text..add))
	else
		if (editor:LineFromPosition(selend)==editor:LineFromPosition(selbegin))
		then
			editor:insert(selend, commentend)
			editor:insert(selbegin, commentbegin)
			editor:SetSel(selbegin, selend+string.len(commentbegin)+string.len(commentend))
		else
			local eolcount = 0
			if (prevIsEOL(selend))
			then
				editor:insert(selend, commentend..GetEOL())
				eolcount = eolcount + 1
			else
				editor:insert(selend, commentend)
			end
			if (prevIsEOL(selbegin))
			then
				editor:insert(selbegin, commentbegin..GetEOL())
				eolcount = eolcount + 1
			else
				editor:insert(selbegin, commentbegin)
			end
			editor:SetSel(selbegin, selend+string.len(commentbegin)+string.len(commentend)+string.len(GetEOL())*eolcount)
		end
	end
	editor:EndUndoAction()
	return true
end

local function BlockComment()
	local selbegin = editor.SelectionStart
	editor:BeginUndoAction()
	if (string.find(editor:textrange(selbegin-string.len(GetEOL()), selbegin),GetEOL()))
	then
		scite.MenuCommand(IDM_BLOCK_COMMENT)
		editor:SetSel(selbegin, editor.SelectionEnd)
	else
		scite.MenuCommand(IDM_BLOCK_COMMENT)
		editor:SetSel(editor.SelectionStart, editor.SelectionEnd)
	end
	editor:EndUndoAction()
	return true
end

local function GetIndexFindCharInProps(value, findchar)
	if findchar
	then
		local resIndex = string.find(props[value], MakeFind(findchar), 1)
		if (resIndex~=nil) and (string.sub(props[value],resIndex,resIndex) == findchar)
		then
			return resIndex
		end
	end
	return nil
end

local function SmartComment(char)
	if (editor.SelectionStart~=editor.SelectionEnd)
	then
		-- делаем индивидуальную обработку по лексерам
		if (editor.LexerLanguage == 'cpp')
		then
			if (char == '*' ) then return StrimComment('/*', '*/') end
		end
		-- делаем проверку на блочный комментарий
		if GetIndexFindCharInProps('comment.block.'..editor.LexerLanguage, char) == 1
		then
			return BlockComment()
		end
	end

	return false
end

-- Add user event handler OnKey
local old_OnKey = OnKey
function OnKey(key, shift, ctrl, alt, char)
	if old_OnKey and old_OnKey(key, shift, ctrl, alt, char)
	then
		return true
	end
	if editor.Focus and char~='' and SmartComment(char)
	then
		return true
	end

	return false
end
