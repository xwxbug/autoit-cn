-- Изменение номера выделенных параметров
-- Возможно использование в файлах .properties (изменение нумерации пунктов меню Tools SciTE),
-- а так же в .ini (.bar) файлах (например, задание пунктов меню и тулбара в Total Commander)
-- version: 1.2.2
-- author: VladVRO, mozers™

-- Подключение:
-- В файл *.properties добавьте строки:
--   file.patterns.used.numeric.values=*.properties;*.ini;*.bar
--   command.name.3.$(file.patterns.used.numeric.values)=Increase number of items
--   command.3.$(file.patterns.used.numeric.values)=dostring delta=1 dofile(props["SciteDefaultHome"].."\\tools\\MoveMenuItem.lua")
--   command.mode.3.$(file.patterns.used.numeric.values)=subsystem:lua,savebefore:no
--   command.shortcut.3.$(file.patterns.used.numeric.values)=Alt+Shift+Up

--   command.name.4.$(file.patterns.used.numeric.values)=Decrease number of items
--   command.4.$(file.patterns.used.numeric.values)=dostring delta=-1 dofile(props["SciteDefaultHome"].."\\tools\\MoveMenuItem.lua")
--   command.mode.4.$(file.patterns.used.numeric.values)=subsystem:lua,savebefore:no
--   command.shortcut.4.$(file.patterns.used.numeric.values)=Alt+Shift+Down
---------------------------------------------
local text = editor:GetSelText()
text = string.gsub(text, "(%s-[%a.]+)(%d+)([%a%.%*%$%(%);]*=[^\n]-)", function (s1,s2,s3) return s1..tonumber(s2)+delta..s3 end)
local ss = editor.SelectionStart
editor:ReplaceSel(text)
editor:SetSel(ss+string.len(text), ss)
