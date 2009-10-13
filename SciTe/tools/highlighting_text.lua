--[[--------------------------------------------------
Text Highlighting
Version: 1.0
Author: VladVRO
------------------------------
Description:
Set mark on selected text.

Warning:
Script uses the functions from COMMON.lua (EditorMarkText, EditorClearMarks)
------------------------------
Installation:
Setup next propertions:
	highlighting.text.marker=6
	find.mark.6=#FF0080,@120

Setup next menu commands:
  command.name.40.*=Highlight Selected Text
  command.40.*=dofile $(SciteDefaultHome)\tools\highlighting_text.lua
  command.mode.40.*=subsystem:lua,savebefore:no

  command.name.41.*=Clear Text Highlighting
  command.41.*=dostring clear=true dofile(props["SciteDefaultHome"].."\\tools\\highlighting_text.lua")
  command.mode.41.*=subsystem:lua,savebefore:no

--]]----------------------------------------------------

local mark_num = props['highlighting.text.marker']

if clear then
	EditorClearMarks(mark_num)
else
	local err_start = editor.SelectionStart
	local err_end = editor.SelectionEnd
	EditorMarkText(err_start, err_end-err_start, mark_num)
end
