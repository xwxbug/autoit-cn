--[[----------------------------------------------------------------------------
Select_And_Open_Filename.lua
Author: VladVRO
version 1.4.1

Расширение команды "Открыть выделенный файл" для случая когда выделения нет.
А также возможность открыть файл по двойному клику мыши на его имени при нажатой
клавише Ctrl.
Скрипт выделяет подходящую область рядом с курсором в качестве имени искомого
файла и пытается открыть его в текущей папке, если файл не найден, то скрипт
пытается расширить выделение до имени + путь и повторяет попытку открыть, в
случае неудачи попытки расширить выделение продолжаются до тех пор, пока не
будет выделен весь путь до файла, и если файл все еще не найден, то поиск
продолжается в папке на уровень выше и т.д. до корня.

Параметр select.and.open.include - определяет список дополнительных папок для
поиска, папки перечисляются через символ ;

Подключение:
Добавить в SciTEStartup.lua строку:
  dofile (props["SciteDefaultHome"].."\\tools\\Select_And_Open_Filename.lua")
Для срабатывания по клику мыши добавить в файл настроек:
  select.and.open.by.click=1
--]]----------------------------------------------------------------------------
require 'shell'

local function isFilenameChar(ch)
	if
		ch < 0 or
		( ch > 32
			and ch ~= 34  -- "
			and ch ~= 39  -- '
			and ch ~= 42  -- *
			and ch ~= 47  -- /
			and ch ~= 58  -- :
			and ch ~= 60  -- <
			and ch ~= 62  -- >
			and ch ~= 63  -- ?
			and ch ~= 92  -- \
			and ch ~= 124 -- |
		)
	then
		return true
	end
	return false
end

local includes = {}
local function loadIncludes(str)
	while #includes > 0 do
		table.remove(includes)
	end
	for path in str:gmatch('([^;]*);') do
		local ch = path:sub(path:len())
		if ch ~= '\\' or ch ~= '/' then
			path = path..'\\'
		end
		table.insert(includes, path)
	end
end

local for_open
local function launch_open()
	if for_open then
		scite.Open(for_open)
		for_open = nil
	end
end

local function Select_And_Open_File(immediately)
	local sci
	if editor.Focus then
		sci = editor
	else
		sci = output
	end 
	local filename = sci:GetSelText()

	if filename == '' then
		loadIncludes(props['select.and.open.include'])
		
		-- try to select file name near current position
		local cursor = sci.CurrentPos
		local s = cursor
		local e = s
		while isFilenameChar(sci.CharAt[s-1]) do -- find start
			s = s - 1
		end
		while isFilenameChar(sci.CharAt[e]) do -- find end
			e = e + 1
		end
		
		if s ~= e then
			-- set selection and try to find file
			sci:SetSel(s,e)
			local dir = props["FileDir"].."\\"
			filename = string.gsub(sci:GetSelText(), '\\\\', '\\')
			foropen = dir..filename
			local isFile = shell.fileexists(foropen)
			
			-- look at includes
			if not isFile then
				for _,path in ipairs(includes) do
					foropen = path..filename
					isFile = shell.fileexists(foropen)
					if isFile then
						break
					end
				end
			end
			
			while not isFile do
				ch = sci.CharAt[s-1]
				if ch == 92 or ch == 47 then -- \ /
					-- expand selection start
					s = s - 1
					while isFilenameChar(sci.CharAt[s-1]) do
						s = s - 1
					end
					sci:SetSel(s,e)
					filename = string.gsub(sci:GetSelText(), '\\\\', '\\')
					foropen = dir..filename
				elseif string.len(dir) > 3 then
					-- up to parent dir
					dir = string.gsub(dir, "(.*)\\([^\\]+)\\", "%1\\")
					foropen = dir..filename
				else
					break
				end
				isFile = shell.fileexists(foropen)
			end
			
			if isFile then
				for_open = foropen
				if immediately then
					launch_open()
				end
				return true
			end
		end
	
	end
end

-- Add user event handler OnMenuCommand
local old_OnMenuCommand = OnMenuCommand
function OnMenuCommand (msg, source)
	local result
	if old_OnMenuCommand then result = old_OnMenuCommand(msg, source) end
	if not result and msg == IDM_OPENSELECTED then
		if Select_And_Open_File(true) then return true end
	end
	return result
end

-- Add user event handler OnMouseButtonUp
local old_OnMouseButtonUp = OnMouseButtonUp
function OnMouseButtonUp()
	local result
	if old_OnMouseButtonUp then result = old_OnMouseButtonUp() end
	launch_open()
	return result
end

-- Add user event handler OnDoubleClick
local old_OnDoubleClick = OnDoubleClick
function OnDoubleClick(shift, ctrl, alt)
	local result
	if ctrl and props["select.and.open.by.click"] == "1" then
		local sci
		if editor.Focus then
			sci = editor
		else
			sci = output
		end
		local s = sci.CurrentPos
		sci:SetSel(s, s)
		if Select_And_Open_File(false) then return true end
	end
	if old_OnDoubleClick then result = old_OnDoubleClick(shift, ctrl, alt) end
	return result
end
