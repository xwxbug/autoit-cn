--[[-------------------------------------------------
Exec.lua
Version: 1.2.2
Author: HSolo, mozers™
---------------------------------------------------
Расчет выделенного текста как математического выражения
или открытие в браузере выделенного URL
http://forum.ru-board.com/topic.cgi?forum=5&topic=3215&start=2020#3
--]]-------------------------------------------------

local function FindExpression(str)
	local patternNum = "([\-\+\*\/%b()%s]*%d+[\.\,]*%d*[\)]*)"
	local startPos, endPos, number, formula
	startPos = 1
	formula = ''
	while true do
		startPos, endPos, number = str:find(patternNum, startPos) -- Находим числа, знаки, скобки (т.е. все что можно принять за часть формулы)
		if startPos == nil then break end
		startPos = endPos + 1
		number = number:gsub('%s+', '')                           -- Убираем пробелы
		number = number:gsub('^([\(%d]+)', '+%1')                 -- Там, где перед числом нет знака, ставим "+" (т.е. пробелы и переводы строк заменяются на "+")
		number = number:gsub('^([\)]+)([%d]+)', '%1+%2')          -- Добавляем знак "+" (при его отсутствии) между числом и скобкой
		formula = formula..number                                 -- Склеиваем вновь преобразованную строку
	end
	formula = formula:gsub('^[\+]', '')                      -- В самом начале получился лишний "+" - убиваем его
	formula = formula:gsub("[\,]+",'.')                      -- Не будем строги к символу - разделителю десятичных чисел :)
	formula = formula:gsub("([\+])([\+]+)",'%1')             -- Удаляем сдвоенные знаки (++) = (+)
	formula = formula:gsub("([\-])([\+]+)",'%1')             -- Удаляем сдвоенные знаки (-+) = (-)
	formula = formula:gsub("([\+\-\*\/])([\*\/]+)",'%1')     -- Удаляем сдвоенные знаки перед * и / т.к. это явный косяк
	formula = formula:gsub("([\+\-\*\/])([\*\/]+)",'%1')     -- Для успокоения совести проделаем дважды
	formula = formula:gsub("([%d\)]+)([\+\*\/\-])",'%1 %2 ') -- Разделяем группы пробелами
	return formula
end

local str = ''
if editor.Focus then
	str = editor:GetSelText()
else
	str = props['CurrentSelection']
end
if (str == '') then
	str = editor:GetCurLine()
end
if (#str < 3) then return end

if str:find('https?://(.*)') then
	shell.exec(str)
else
	if str:find("(math\.%w+)") then  -- В случае сложных математических выражений форматирование оставляем на пользователя
		str = str:gsub("[=]",'')
	else
		str = FindExpression(str)
	end
	local result = loadstring('return '..str)()

	print('-> '..scite.GetTranslation("Calculate Expression")..': '..str)
	print('>> '..scite.GetTranslation("Result")..': '..result)

	--[[ -------- insert result to text ------
	editor:LineEnd() 
	local sel_start = editor.SelectionStart + 1
	local sel_end = sel_start + string.len(result)
	editor:AddText('\n= '..result)
	editor:SetSel(sel_start, sel_end+2)
	--]] -------------------------------------
end

--[[-------------------------------------------------
Тесты типа :)
1/2 56/4 - 56 (8-6)*4  4,5*(1+2)    66
3/6 6.4/2 6  (7-6)*4  45/4.1 66

dmfdmk v15*6dmd.ks skm4.37/3d(k)gm/sk+d skdmg(6,7+6)skdmgk

Колбаса = 24.5кг. * 120руб./кг
Бензин(ABC) = (2500км. / (11,5л./100км.)) * 18.4руб./л + Канистра =100руб.
Штукатурка = 22.4 м2 /80руб./100 м2

http://scite.net.ru
--]]-------------------------------------------------
