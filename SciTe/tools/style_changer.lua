-- Style Changer
-- Автор скрипта: mozers™
-- Автор стиля cpp_style_classic: mimir
-- Быстрая смена стиля оформления файлов на С

-- Для подключения добавьте в свой файл .properties следующие строки:
--   command.name.9.$(file.patterns.cpp)=Style Classic C
--   command.9.$(file.patterns.cpp)=dofile $(SciteDefaultHome)\tools\style_changer.lua
--   command.mode.9.$(file.patterns.cpp)=subsystem:lua,savebefore:no
-----------------------------------------------
local file = props["SciteDefaultHome"].."\\languages\\cpp.properties"
local classic = 'import languages\\cpp_style_classic'
io.input(file)
local text = io.read('*a')
local find = string.find(text, '#'..classic)
if find == nil then
	text = string.gsub(text, classic, '#'..classic)
	props["command.checked.5.$(file.patterns.cpp)"] = 0
else
	text = string.gsub(text, '#'..classic, classic)
	props["command.checked.5.$(file.patterns.cpp)"] = 1
end
io.output(file)
io.write (text)
io.close()
scite.Perform("reloadproperties:")
