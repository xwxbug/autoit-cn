--[[--------------------------------------------------
CopyMarkedLines.lua v1.1
Authors: Jos van der Zande (JdeB), Philippe Lhoste, mozers™

* Copy to clipboard or insert to current position marked (on Ctrl+F2) line(s)
-----------------------------------------------
Connection:
In file .properties add a lines:

  command.name.14.*=Copy To Clipboard marked (on Ctrl+F2) lines
  command.14.*=dofile $(SciteDefaultHome)\tools\CopyMarkedLines.lua
  command.mode.14.*=subsystem:lua,savebefore:no

  command.name.15.*=Insert marked (on Ctrl+F2) lines
  command.15.*=dostring action="Ins" dofile(props["SciteDefaultHome"].."\\tools\\CopyMarkedLines.lua")
  command.mode.15.*=subsystem:lua,savebefore:no
--]]----------------------------------------------------

local ml = 0
local lines = {}
while true do
	ml = editor:MarkerNext(ml, 2)
	if (ml == -1) then break end
	table.insert(lines, (editor:GetLine(ml)))
	ml = ml + 1
end
local text = table.concat(lines)
editor:CopyText(text)
-- _ALERT('> Copied '..table.getn(lines)..' lines')

if (action ~= nil) then
	-- Inserted bookmarked lines to current position
	local sel_start = editor.CurrentPos
	editor:AddText(text)
	local sel_end = editor.CurrentPos
	editor:SetSel(sel_start, sel_end)
	action = nil
end
