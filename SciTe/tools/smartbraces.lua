--[[--------------------------------------------------
SciTE Smart braces
Version: 1.2.2
Authors: Dmitry Maslov, Julgo, TymurGubayev
-------------------------------------------------
Работает, если:

 Подключен в автозагрузку
 В настройках установлено braces.autoclose = 1 
 В настройках установлено braces.open = открывающиеся скобки
 В настройках установлено braces.close = закрывающиеся скобки
 Используется только в русской сборке из-за расширенной функции OnKey

-------------------------------------------------
Функционал:

 Автозакрытие скобок
 Автозакрытие выделенного текста в скобки
 Особая обработка { и } в cpp: автоматом делает отступ

-------------------------------------------------
Логика работы:

 Скрипт срабатывает только если braces.autoclose = 1

 Если мы вводим символ из braces.open, то автоматически вставляется
 ему пара из braces.close, таким образом, курсор оказывается между скобок

 Если мы вводим закрывающуюся скобку из braces.close и следующий символ
 эта же закрывающаяся скобка, то ввод проглатывается и лишняя закрывающаяся
 скобка не печатается

 Если у нас выделен текст и мы вводим символ из braces.open
 то текст обрамляется кавычками braces.open - braces.close
 если он уже был обрамлен кавычками, то они снимаются,
 при этом учитывается символ переноса строки, т.е. если выделенный
 текст оканчивается переводом строки, то скобки вставляются до переноса
 строки

 Если мы вводим символ { при редактировании файла cpp или css, то автоматически
 вставляется перенос строки два раза, а после } - курсор при этом оказывается
 в середине, т.е. после первого переноса строки, все отступы сохраняются

 Если мы вставляем символ } при редактировании файла cpp или css, то отступ
 автоматически уменьшается на один

 Если мы только что вставили скобку автоматом, то после того
 как нажимаем BACK_SPACE удаляется вставленная скобка, т.е.
 срабатывает как DEL, а не как BACK_SPACE

 Если вставляем скобку у которой braces.open == braces.close
 то вставляется пара только если таких скобок четно в строке

 ВНИМАНИЕ: В скрипте используется ф-ция string.pattern из COMMON.lua
--]]--------------------------------------------------

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

local function FindCount( text, textToFind )
	local count = 0;
	for w in string.gmatch( text, textToFind:pattern() )
	do
		count = count + 1
	end
	return count
end

-- позиция это начало строки (учитывая отступ)
local function IsLineStartPos( pos )
	return ( editor.LineIndentPosition[editor:LineFromPosition(pos)] == pos )
end

-- Получить номер текущей строки
local function GetCurrLineNumber()
	return editor:LineFromPosition( editor.CurrentPos )
end

-- Получить отступ в строке
local function GetLineIndentation( num_line )
	if ( num_line < 0 ) then num_line = 0 end
	if ( num_line >= editor.LineCount ) then num_line = editor.LineCount - 1 end
	return ( editor.LineIndentation[num_line] / editor.Indent )
end

-- последний в строке ?
local function IsInLineEnd( num_line, text )
	local endpos = editor.LineEndPosition[num_line]
	if	( endpos >= string.len( text ) )
		and
		string.find( editor:textrange( editor:PositionBefore( endpos - string.len( text ) + 1 ), endpos ), text:pattern() )
	then
		return true
	end
	return false
end

-- последний символ в строке - конец строки?
local function IsEOLlast( text )
	-- в луа конец строки всегда один символ
--[[	if string.find( text, GetEOL(), string.len( text ) - 1 ) then
		return true
	end
	return false]]
	return (text:sub(-1) == GetEOL())
end

-- следующий за позицией текст == text ?
local function nextIs(pos, text)
	if ( string.find( editor:textrange( pos, editor:PositionAfter( pos + string.len( text ) - 1 ) ), text:pattern() ) ) then
		return true
	end
	return false
end

-- следующий символ позиции конец строки?
local function nextIsEOL(pos)
	if	( pos == editor.Length )
		or
		( nextIs( pos, GetEOL() ) )
	then
		return true
	end
	return false
end

-----------------------------------------------------------------
-- проверяет скобки, заданные bracebegin и braceend в строке s на 
-- сбалансированность: "(x)y(z)" -> true, "x)y(z" -> false
local function BracesBalanced (s, bracebegin, braceend)
	if (#bracebegin + #braceend) > 2 then
		--@warn: данная функция не будет работать со "скобками" больше одного символа.
		--@todo: для "длинных" скобок нужно переписать эту функцию на lpeg. Но кому оно надо?..
		return true
	end
	local b,e    = s:find("%b"..bracebegin..braceend)
	local b2 = s:find(bracebegin, 1, true)
	local e2 = s:find(braceend, 1, true)
	return (b == b2) and (e == e2)
end -- BracesBalanced

local function BlockBraces( bracebegin, braceend )
	local text, lenght = editor:GetSelText()
	local selbegin = editor.SelectionStart
	local selend = editor.SelectionEnd
	local b, e   = string.find( text, "^%s*"..bracebegin:pattern() )
	local b2, e2 = string.find( text, braceend:pattern().."%s*$" )
	local add = ( IsEOLlast( text ) and GetEOL() ) or ""
	
	editor:BeginUndoAction()
	if (b and b2) and BracesBalanced( text:sub( e+1, b2-1 ) , bracebegin, braceend ) then
		text = string.sub( text, e+1, b2-1 )
		editor:ReplaceSel( text..add )
		editor:SetSel( selbegin, selbegin + #( text..add ) )
	else
		editor:insert( selend - #add, braceend )
		editor:insert( selbegin, bracebegin )
		editor:SetSel( selbegin, selend + #( bracebegin..braceend ) )
	end
	editor:EndUndoAction()
	
	return true
end

local function GetIndexFindCharInProps( value, findchar )
	if findchar then
		local resIndex = string.find( props[value], findchar:pattern() , 1 )
		if	( resIndex ~= nil )
			and
			( string.sub( props[value], resIndex,resIndex ) == findchar )
		then
			return resIndex
		end
	end
	return nil
end

local function GetCharInProps( value, index )
	return string.sub( props[value], index, index )
end

-- возвращает открывающуюся скобку и закрывающуюся скобку
-- по входящему символу, т.е. например,
-- если на входе ')' то на выходе '(' ')'
-- если на входе '(' то на выходе '(' ')'
local function GetBraces( char )
	local braceOpen = ''
	local braceClose = ''
	local symE = ''
	local brIdx = GetIndexFindCharInProps( 'braces.open', char )
	if ( brIdx ~= nil ) then
		symE = GetCharInProps( 'braces.close', brIdx )
		if ( symE ~= nil ) then 
			braceOpen = char
			braceClose = symE
		end
	else
		brIdx = GetIndexFindCharInProps( 'braces.close', char )
		if ( brIdx ~= nil ) then
			symE = GetCharInProps( 'braces.open', brIdx )
			if ( symE ~= nil ) then 
				braceOpen = symE
				braceClose = char
			end
		end
	end
	return braceOpen, braceClose
end

local g_isPastedBraceClose = false

-- "умные скобки/кавычки" 
-- возвращает true когда обрабатывать дальше символ не нужно
local function SmartBraces( char )
	if ( props['braces.autoclose'] == '1' ) then
		local isSelection = editor.SelectionStart ~= editor.SelectionEnd
		-- находим парный символ
		local braceOpen, braceClose = GetBraces(char)
		if ( braceOpen ~= '' and braceClose ~= '' ) then
			-- проверяем выделен ли у нас какой либо текст
			if ( isSelection == true ) then
				-- делаем обработку по автозакрытию текста скобками
				return BlockBraces( braceOpen, braceClose )
			else
				-- если следующий символ закрывающаяся скобка
				-- и мы ее вводим, то ввод проглатываем
				local nextsymbol = string.format( "%c", editor.CharAt[editor.CurrentPos] )
				if	( GetIndexFindCharInProps( 'braces.close', nextsymbol ) ~= nil )
					and
					( nextsymbol == char )
				then 
					editor:CharRight()
					return true
				end
				-- если мы ставим открывающуюся скобку и 
				-- следующий символ конец строки или это парная закрывающаяся скобка
				-- то сразу вставляем закрывающуюся скобку
				if	( char == braceOpen )
					and
					( nextIsEOL( editor.CurrentPos ) or nextIs( editor.CurrentPos, braceClose ) )
				then
					-- по волшебному обрабатываем скобку { в cpp
					if	( char == '{' ) and
						( editor.LexerLanguage == 'cpp' or editor.LexerLanguage == 'css' )
					then
						editor:BeginUndoAction()
						local ln = GetCurrLineNumber()
						if	( ln > 0 and GetLineIndentation( ln ) > GetLineIndentation( ln - 1 ) )
							and
							( IsLineStartPos( editor.CurrentPos ) )
							and 
							( not IsInLineEnd( ln-1, '{' ) )
						then
							editor:BackTab()
						end
						editor:AddText( '{' )
						editor:NewLine()
						if ( GetLineIndentation( ln ) == GetLineIndentation( ln + 1 ) ) then
							editor:Tab()
						end
						local pos = editor.CurrentPos
						editor:NewLine()
						if ( GetLineIndentation( ln + 2 ) == GetLineIndentation( ln + 1 ) ) then
							editor:BackTab()
						end
						editor:AddText( '}' )
						editor:GotoPos( pos )
						editor:EndUndoAction()
						return true
					end
					-- если вставляем скобку с одинаковыми правой и левой, то смотрим есть ли уже открытая в строке
					if	( braceOpen == braceClose )
						and
						( math.fmod( FindCount( editor:GetCurLine(), braceOpen ), 2 ) == 1 )
					then
						return false
					end
					-- вставляем закрывающуюся скобку
					editor:BeginUndoAction()
					editor:InsertText( editor.CurrentPos, braceClose )
					editor:EndUndoAction()
					g_isPastedBraceClose = true
				end
				-- если мы ставим закрывающуюся скобку
				if ( char == braceClose ) then
					-- "по волшебному" обрабатываем скобку } в cpp и css
					if ( char == '}' ) and
						( editor.LexerLanguage == 'cpp' or editor.LexerLanguage == 'css' )
					then
						editor:BeginUndoAction()
						if (IsLineStartPos( editor.CurrentPos ) )
						then
							editor:BackTab()
						end
						editor:AddText( '}' )
						editor:EndUndoAction()
						return true
					end
				end
			end
		end
	end
	return false
end

-- Перехватываем функцию редактора OnKey
local old_OnKey = OnKey
function OnKey( key, shift, ctrl, alt, char )
	-- если кто-то уже обработал символ то мы не обрабатываем
	if ( old_OnKey and old_OnKey( key, shift, ctrl, alt, char ) ) then
		return true
	end

	if ( editor.Focus ) then
		if ( key == 8 and g_isPastedBraceClose == true ) then -- VK_BACK (08)
			g_isPastedBraceClose = false
			editor:BeginUndoAction()
			editor:CharRight()
			editor:DeleteBack()
			editor:EndUndoAction()
			return true
		end
		
		g_isPastedBraceClose = false
		
		if ( char ~= '' ) then
			return SmartBraces( char )
		end
	end

	return false
end
