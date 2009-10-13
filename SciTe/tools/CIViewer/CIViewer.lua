--[[--------------------------------------------------
CIViewer (Color Image Viewer) v2.0.1
Автор: mozers™

* Preview of color or image under mouse cursor
* Предпросмотр цвета, заданного значением в виде "#6495ED" или "red" или рисунка по его URI
* Данный скрипт служит для обеспечения работоспособности основного приложения CIViewer.hta
-----------------------------------------------
Для обеспечения работоспособности добавьте в SciTEStartup.lua строку:
    dofile (props["SciteDefaultHome"].."\\tools\\CIViewer\\CIViewer.lua")

Для вызова приложения из меню Tools добавьте в свой файл .properties следующие строки:
    command.parent.112.*=9
    command.name.112.*=Color Image Viewer
    command.112.*="$(SciteDefaultHome)\tools\CIViewer\CIViewer.hta"
    command.mode.112.*=subsystem:shellexec
--]]----------------------------------------------------

-- Поиск по строке (возвращается только результат в заданной позиции)
local function FindInLine(str_line, pattern, cur_pos)
	local _start, _end, _match
	_start = 1
	repeat
		_start, _end, _match = string.find(str_line, pattern, _start)
		if _start == nil then return '' end
		if ((cur_pos >= _start) and (cur_pos < _end)) then return _match end
		_start = _end + 1
	until false
end

-- Поиск стринга похожего на URI в позиции курсора мыши
local function GetURI(pos)
	local cur_line = editor:LineFromPosition(pos)
	local line_start_pos = editor:PositionFromLine(cur_line)
	local line_string = editor:GetLine(cur_line)
	local pos_from_line = pos - line_start_pos + 1

	local URI = ''
	URI = FindInLine(line_string, '"(.-)"', pos_from_line)
	if URI ~= '' then return URI end
	URI = FindInLine(line_string, "'(.-)'", pos_from_line)
	if URI ~= '' then return URI end
	URI = FindInLine(line_string, '%((.-)%)', pos_from_line)
	if URI ~= '' then return URI end
	URI = FindInLine(line_string, '([^%s"|=]+)', pos_from_line)
	return URI
end

-- Add user event handler OnDwellStart
local old_OnDwellStart = OnDwellStart
function OnDwellStart(pos, word)
	local result
	if old_OnDwellStart then result = old_OnDwellStart(pos, word) end
	if pos ~= 0 then
		-- Присваиваем значения переменным (CIViewer.hta будет периодически их проверять)
		props["civiewer.word"] = word
		props["civiewer.pos"] = pos
		props["civiewer.uri"] = GetURI(pos)
	end
	return result
end
