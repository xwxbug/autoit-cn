--[[--------------------------------------------------
FindText v7.2.1
Авторы: mozers™, mimir, Алексей, codewarlock1101, VladVRO

* Если текст выделен - ищется выделенная подстрока
* Если текст не выделен - ищется текущее слово
* Поиск возможен как в окне редактирования, так и в окне консоли
* Строки, содержащие результаты поиска, выводятся в консоль
* Перемещение по вхождениям - F3 (вперед), Shift+F3 (назад)
* Каждый новый поиск оставляет маркеры своего цвета
* Очистка от маркеров поиска - Ctrl+Alt+C

Внимание:
В скрипте используются функции из COMMON.lua (EditorMarkText, EditorClearMarks)
-----------------------------------------------
Для подключения добавьте в свой файл .properties следующие строки:
	command.name.130.*=Find String/Word
	command.130.*=dofile $(SciteDefaultHome)\tools\FindText.lua
	command.mode.130.*=subsystem:lua,savebefore:no
	command.shortcut.130.*=Ctrl+Alt+F

	command.name.131.*=Clear All Marks
	command.131.*=dostring EditorClearMarks() scite.SendEditor(SCI_SETINDICATORCURRENT, ifnil(tonumber(props['findtext.first.mark']),31))
	command.mode.131.*=subsystem:lua,savebefore:no
	command.shortcut.131.*=Ctrl+Alt+C

Дополнительно необходимо задать в файле настроек стили используемых маркеров и номер первого из используемых стилей:
	findtext.first.mark=27
	find.mark.27=#CC00FF
	find.mark.28=#0000FF
	find.mark.29=#00CC66
	find.mark.30=#CCCC00
	find.mark.31=#336600

Дополнительно можно задать дополнительные параметры поиска:
	# Поиск с учетом регистра
	findtext.matchcase=1
	# Отмечать букмарками найденные строки
	findtext.bookmarks=1
	# Выводить все найденные строки в консоль
	findtext.output=1
	# Показывать подсказку по горячим клавишам
	findtext.tutorial=1
--]]----------------------------------------------------

local firstNum = ifnil(tonumber(props['findtext.first.mark']),31)
if firstNum < 1 or firstNum > 31 then firstNum = 31 end

local sText = props['CurrentSelection']
local flag0 = 0
if (sText == '') then
	sText = props['CurrentWord']
	flag0 = SCFIND_WHOLEWORD
end
local flag1 = 0
if props['findtext.matchcase'] == '1' then flag1 = SCFIND_MATCHCASE end
local bookmark = props['findtext.bookmarks'] == '1'
local isOutput = props['findtext.output'] == '1'
local isTutorial = props['findtext.tutorial'] == '1'

local current_mark_number = scite.SendEditor(SCI_GETINDICATORCURRENT)
if current_mark_number < firstNum then current_mark_number = firstNum end
if string.len(sText) > 0 then
	if bookmark then editor:MarkerDeleteAll(1) end
	local msg
	if isOutput then
		if flag0 == SCFIND_WHOLEWORD then
			msg = '> '..scite.GetTranslation('Search for current word')..': "'
		else
			msg = '> '..scite.GetTranslation('Search for selected text')..': "'
		end
		props['lexer.errorlist.findtitle.begin'] = msg
		scite.SendOutput(SCI_SETPROPERTY, 'lexer.errorlist.findtitle.begin', msg)
		props['lexer.errorlist.findtitle.end'] = '"'
		scite.SendOutput(SCI_SETPROPERTY, 'lexer.errorlist.findtitle.end', '"')
		print(msg..sText..'"')
	end
	local s,e = editor:findtext(sText, flag0 + flag1, 0)
	local count = 0
	if(s~=nil)then
		local m = editor:LineFromPosition(s) - 1
		while s do
			local l = editor:LineFromPosition(s)
			EditorMarkText(s, e-s, current_mark_number)
			count = count + 1
			if l ~= m then
				if bookmark then editor:MarkerAdd(l,1) end
				local str = string.gsub(' '..editor:GetLine(l),'%s+',' ')
				if isOutput then
					print('./'..props['FileNameExt']..':'..(l + 1)..':\t'..str)
				end
				m = l
			end
			s,e = editor:findtext(sText, flag0 + flag1, e+1)
		end
		if isOutput then
			print('> '..string.gsub(scite.GetTranslation('Found: @ results'), '@', count))
			if isTutorial then
				print('F3 (Shift+F3) - '..scite.GetTranslation('Jump by markers')..
					'\nF4 (Shift+F4) - '..scite.GetTranslation('Jump by lines')..
					'\nCtrl+Alt+C - '..scite.GetTranslation('Erase all markers'))
			end
		end
	else
		print('> '..string.gsub(scite.GetTranslation("Can't find [@]!"), '@', sText))
	end
	current_mark_number = current_mark_number + 1
	if current_mark_number > 31 then current_mark_number = firstNum end
	scite.SendEditor(SCI_SETINDICATORCURRENT, current_mark_number)
		-- обеспечиваем возможность перехода по вхождениям с помощью F3 (Shift+F3)
		if flag0 == SCFIND_WHOLEWORD then
			editor:GotoPos(editor:WordStartPosition(editor.CurrentPos))
		else
			editor:GotoPos(editor.SelectionStart)
		end
		scite.Perform('find:'..sText)
else
	EditorClearMarks()
	if bookmark then editor:MarkerDeleteAll(1) end
	scite.SendEditor(SCI_SETINDICATORCURRENT, firstNum)
	print('> '..scite.GetTranslation('Select text for search! (search for selection)'))
	print('> '..scite.GetTranslation('Or put cursor on the word for search. (search for word)'))
	print('> '..scite.GetTranslation('You can also select text in console.'))
end
--~ editor:CharRight() editor:CharLeft() --Снимает выделение с исходного текста
