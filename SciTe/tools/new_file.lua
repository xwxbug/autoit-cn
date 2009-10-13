--[[--------------------------------------------------
new_file.lua
mozers™, VladVRO (при активном участии dB6)
version 2.2
----------------------------------------------
Заменяет стандартную команду SciTE "File|New" (Ctrl+N)
Создает новый буфер в текущем каталоге с расширением текущего файла
Благодаря этому, сразу же включаются все фичи лексера (подсветка, подсказки и пр.)
----------------------------------------------
Подключение:
В файл SciTEStartup.lua добавьте строку:
  dofile (props["SciteDefaultHome"].."\\tools\\new_file.lua")
----------------------------------------------
Replaces SciTE command "File|New" (Ctrl+N)
Creates new buffer in the current folder with current file extension
----------------------------------------------
Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\tools\\new_file.lua")
--]]----------------------------------------------------
require 'shell'

props["untitled.file.number"] = 0

local function CreateUntitledFile()
	local file_ext = "."..props["FileExt"]
	if file_ext == "." then file_ext = props["default.file.ext"] end
	repeat
		local file_path = props["FileDir"].."\\"..scite.GetTranslation('Untitled')..props["untitled.file.number"]..file_ext
		props["untitled.file.number"] = tonumber(props["untitled.file.number"]) + 1
		if not shell.fileexists(file_path) then
			local warning_couldnotopenfile_disable = props['warning.couldnotopenfile.disable']
			props['warning.couldnotopenfile.disable'] = 1
			scite.Open(file_path)
			props['warning.couldnotopenfile.disable'] = warning_couldnotopenfile_disable
			return true
		end
	until false
end

-- Add user event handler OnMenuCommand
local old_OnMenuCommand = OnMenuCommand
function OnMenuCommand (msg, source)
	local result
	if old_OnMenuCommand then result = old_OnMenuCommand(msg, source) end
	if msg == IDM_NEW then
		if CreateUntitledFile() then return true end
	end
	return result
end
