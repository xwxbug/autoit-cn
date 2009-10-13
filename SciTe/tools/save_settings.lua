--[[--------------------------------------------------
 Save SciTE Settings
 Version: 1.7.1
 Author: mozers™, Dmitry Maslov
---------------------------------------------------
 Save current settings on SciTE close.
 Сохраняет текущие установки при закрытии SciTE (в файле SciTE.session)
---------------------------------------------------
Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\tools\\save_settings.lua")
Set in a file .properties:
  save.settings=1
  import home\SciTE.session
--]]----------------------------------------------------

local text = ''

-- установить в text текущее значение проперти key
local function SaveKey(key)
	local value = props[key]
	if tonumber(value) then
		local regex = '([^%w.]'..key..'=)%-?%d+'
		if text:find(regex) == nil then
			text = text..'\n'..key..'='..value
			return
		end
		text = text:gsub(regex, "%1"..value)
	end
	return
end

local function SaveSettings()
	local file = props["scite.userhome"]..'\\SciTE.session'
	io.input(file)
	text = io.read('*a')
	SaveKey('toolbar.visible')
	SaveKey('tabbar.visible')
	SaveKey('statusbar.visible')
	SaveKey('view.whitespace')
	SaveKey('view.eol')
	SaveKey('view.indentation.guides')
	SaveKey('line.margin.visible')
	SaveKey('split.vertical')
	SaveKey('wrap')
	SaveKey('output.wrap')
	SaveKey('magnification') -- параметр изменяется в Zoom.lua
	SaveKey('output.magnification') -- параметр изменяется в Zoom.lua
	SaveKey('print.magnification') -- параметр изменяется в Zoom.lua
	SaveKey('sidebar.show') -- параметр изменяется в SideBar.lua
	SaveKey('highlighting.identical.text') -- параметр изменяется в highlighting_identical_text.lua
	io.output(file)
	io.write(text)
	io.close()
end

local function ToggleProp(prop_name)
	local prop_value = tonumber(props[prop_name])
	if prop_value==0 then
		props[prop_name] = '1'
	elseif prop_value==1 then
		props[prop_name] = '0'
	end
end

-- Добавляем свой обработчик события OnMenuCommand
-- При изменении параметров через меню, меняются и соответствующие значения props[]
local old_OnMenuCommand = OnMenuCommand
function OnMenuCommand(cmd, source)
	local result
	if old_OnMenuCommand then result = old_OnMenuCommand(cmd, source) end
	if cmd == IDM_VIEWTOOLBAR then
		ToggleProp('toolbar.visible')
	elseif cmd == IDM_VIEWTABBAR then
		ToggleProp('tabbar.visible')
	elseif cmd == IDM_VIEWSTATUSBAR then
		ToggleProp('statusbar.visible')
	elseif cmd == IDM_VIEWSPACE then
		ToggleProp('view.whitespace')
	elseif cmd == IDM_VIEWEOL then
		ToggleProp('view.eol')
	elseif cmd == IDM_VIEWGUIDES then
		ToggleProp('view.indentation.guides')
	elseif cmd == IDM_LINENUMBERMARGIN then
		ToggleProp('line.margin.visible')
	elseif cmd == IDM_SPLITVERTICAL then
		ToggleProp('split.vertical')
	elseif cmd == IDM_WRAP then
		ToggleProp('wrap')
	elseif cmd == IDM_WRAPOUTPUT then
		ToggleProp('output.wrap')
	end
	return result
end

-- Добавляем свой обработчик события OnFinalise
-- Сохранение настроек при закрытии SciTE
local old_OnFinalise = OnFinalise
function OnFinalise()
	local result
	if old_OnFinalise then result = old_OnFinalise() end
	if tonumber(props['save.settings']) == 1 then
		SaveSettings()
	end
	return result
end
