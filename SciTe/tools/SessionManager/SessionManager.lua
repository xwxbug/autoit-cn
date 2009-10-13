-- SessionManager
-- Автор: mozers™
-- Version: 1.0
-----------------------------------------------
require 'shell'
local sessionmanager_path = props['SciteDefaultHome']..'\\tools\\SessionManager\\SessionManager.hta'

local function LoadSession()
	shell.exec('mshta "'..sessionmanager_path..'"', nil, true, false)
end

local function SaveSession()
	shell.exec('mshta "'..sessionmanager_path..'" '..props['FileName'], nil, true, false)
end

local function SaveSessionOnQuit()
	props['save.session']=1
	shell.exec('mshta "'..sessionmanager_path..'" QUIT '..props['FileName'], nil, true, false)
end

local function SaveSessionOnQuitAuto()
	local path = ""
	local i = 0
	repeat
		local filename = props['FileName']..'_'..string.sub('0'..i, -2)
		filename = string.gsub(filename,' ','_')
		path = props['scite.userhome']..'\\'..filename..'.session'
		i = i + 1
	until not shell.fileexists(path)
	local session_file = props['scite.userhome']..'\\SciTE.session'
	os_copy (session_file, path)
end

-- Добавляем свой обработчик события OnMenuCommand
local old_OnMenuCommand = OnMenuCommand
function OnMenuCommand (msg, source)
	local result
	if old_OnMenuCommand then result = old_OnMenuCommand(msg, source) end
	if tonumber(props['session.manager'])==1 then
		if msg == IDM_SAVESESSION then
			SaveSession()
			return true
		elseif msg == IDM_LOADSESSION then
			LoadSession()
			return true
		end
	end
	return result
end

-- Добавляем свой обработчик события OnFinalise
-- Сохранение текущей сессиии при закрытии SciTE
local old_OnFinalise = OnFinalise
function OnFinalise()
	local result
	if old_OnFinalise then result = old_OnFinalise() end
	if props['FileName'] ~= '' then
		if tonumber(props['session.manager'])==1 then
			if tonumber(props['save.session.manager.on.quit'])==1 then
				if tonumber(props['save.session.on.quit.auto'])==1 then
					SaveSessionOnQuitAuto()
				else
					SaveSessionOnQuit()
				end
				return false
			end
		end
	end
	return result
end
