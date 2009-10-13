--[[--------------------------------------------------
goto_line.lua
Author: mozers™
version: 1.0
------------------------------------------------------
При переходе на букмарк, текущее положение курсора на экране сохраняется
для чего текст прокручивается на нужное количество строк.
Теперь вам не придется искать курсор по всему экрану!
(Реализация Issue 21 http://code.google.com/p/scite-ru/issues/detail?id=21)

  Connection:
   In file SciTEStartup.lua add a line:
      dofile (props["SciteDefaultHome"].."\\tools\\goto_line.lua")
--]]--------------------------------------------------

local function GotoLine(line)
	local linecur = editor:LineFromPosition(editor.CurrentPos)
	local linecur_onscreen = linecur - editor.FirstVisibleLine
	editor:GotoLine(line)
	local line_onscreen = line - editor.FirstVisibleLine
	if line_onscreen ~= linecur_onscreen then
		editor:LineScroll(0, line_onscreen - linecur_onscreen)
	end
	return 0
end

-- Add user event handler OnSendEditor
local old_OnSendEditor = OnSendEditor
function OnSendEditor(id_msg, wp, lp)
	local result
	if old_OnSendEditor then result = old_OnSendEditor(id_msg, wp, lp) end
	if id_msg == SCI_GOTOLINE then
		GotoLine(wp)
	end
	return result
end