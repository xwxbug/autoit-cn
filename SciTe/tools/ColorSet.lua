--[[--------------------------------------------------
ColorSet.lua
Authors: mozers™
version 1.1
------------------------------------------------------
  Connection:
   Set in a file .properties:
     command.name.6.*=Choice Color
     command.6.*=dofile $(SciteDefaultHome)\tools\ColorSet.lua
     command.mode.6.*=subsystem:lua,savebefore:no

  Note: Needed gui.dll <http://scite-ru.googlecode.com/svn/trunk/lualib/gui/>
--]]--------------------------------------------------
require 'gui'

local colour = props["CurrentSelection"]
local prefix = false
if colour:match("[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]$") then
	if colour:match("^#") then
		prefix = true
	else
		colour = "#"..colour
	end
else
	prefix = true
	colour = "#FFFFFF"
end

colour = gui.colour_dlg(colour)
if colour ~= nil then
	if not prefix then colour = colour:gsub('^#', '') end
	editor:ReplaceSel(colour)
end
