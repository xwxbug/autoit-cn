--[[--------------------------------------------------
SideBar.lua
Authors: Frank Wunderlich, mozersЩ, VladVRO, frs, BioInfo, Tymur Gubayev
version 1.14
------------------------------------------------------
  Note: Require gui.dll <http://scite-ru.googlecode.com/svn/trunk/lualib/gui/>
               lpeg.dll <http://scite-ru.googlecode.com/svn/trunk/lualib/lpeg/>
              shell.dll <http://scite-ru.googlecode.com/svn/trunk/lualib/shell/>
             COMMON.lua (function GetCurrentWord)
  Connection:
   In file SciTEStartup.lua add a line:
      dofile (props["SciteDefaultHome"].."\\tools\\SideBar.lua")
   Set in a file .properties:
      command.checked.17.*=$(sidebar.show)
      command.name.17.*=SideBar
      command.17.*=SideBar_ShowHide
      command.mode.17.*=subsystem:lua,savebefore:no

    # Set show(1) or hide(0) to SciTE start
    sidebar.show=1
    # Set default settings for Functions/Procedures List
    sidebar.functions.flags=1
    sidebar.functions.params=1
--]]--------------------------------------------------
require 'gui'
require 'lpeg'
require 'shell'

-- you can choose to make it a stand-alone window; just uncomment this line:
-- local win = true

-- local _DEBUG = true --включает вывод отладочной информации
-- отображение флагов/параметров по умолчанию:
local _show_flags = tonumber(props['sidebar.functions.flags']) == 1
local _show_params = tonumber(props['sidebar.functions.params']) == 1

local tab_index = 0
local panel_width = 200
local win_height = props['position.height']
if win_height == '' then win_height = 600 end

local style = props['style.*.32']
local colorback = style:match('back:(#%x%x%x%x%x%x)')
local colorfore
if colorback then
	colorfore = style:match('fore:(#%x%x%x%x%x%x)')
	if colorfore == nil then colorfore = '' end
end

----------------------------------------------------------
-- Common functions
----------------------------------------------------------
local function ReplaceWithoutCase(text, s_find, s_rep)
	local i, j = 1
	local replaced = nil
	repeat
		i, j = text:lower():find(s_find:lower(), j, true)
		if j == nil then return text, replaced end
		text = text:sub(1, i-1)..s_rep..text:sub(j+1)
		replaced = true
	until false
end

local function ShowCompactedLine(line_num)
	local function GetFoldLine(ln)
		while editor.FoldExpanded[ln] do ln = ln-1 end
		return ln
	end
	while not editor.LineVisible[line_num] do
		local x = GetFoldLine(line_num)
		editor:ToggleFold(x)
		line_num = x - 1
	end
end

if _DEBUG then
local nametotime = {} -- maps names to starttimes
	_DEBUG = {}

	_DEBUG.timerstart = function (name)
		nametotime[name] = os.clock()
	end -- _DEBUG.timerstart

	_DEBUG.timer = function (name,...)
		if nametotime[name] then
			local d = os.clock() - nametotime[name]
			print(name,('%.5fs'):format(d),...)
		end
		return d
	end -- _DEBUG.timer

	_DEBUG.timerstop = function (name,...)
		local d = _DEBUG.timer(name,...)
		nametotime[name] = nil
		return d
	end --_DEBUG.timerstop

else
	_DEBUG = {}
	local empty = function (...) end
	_DEBUG.timer, _DEBUG.timerstart, _DEBUG.timerstop = empty, empty, empty
end

----------------------------------------------------------
-- Create panels
----------------------------------------------------------
local tab0 = gui.panel(panel_width + 18)

local memo_path = gui.memo()
tab0:add(memo_path, "top", 22)
if colorback then memo_path:set_memo_colour('', colorback) end

local list_dir_height = win_height/3
if list_dir_height <= 0 then list_dir_height = 200 end
local list_favorites = gui.list(true)
list_favorites:add_column("Favorites", 600)
tab0:add(list_favorites, "bottom", list_dir_height)
if colorback then list_favorites:set_list_colour(colorfore,colorback) end

local list_dir = gui.list()
tab0:client(list_dir)
if colorback then list_dir:set_list_colour(colorfore,colorback) end

tab0:context_menu {
	'FileMan: Change Dir|FileMan_ChangeDir',
	'FileMan: Show All|FileMan_MaskAllFiles',
	'FileMan: Only current ext|FileMan_MaskOnlyCurrentExt',
	'', -- separator
	'FileMan: Copy to...|FileMan_FileCopy',
	'FileMan: Move to...|FileMan_FileMove',
	'FileMan: Rename|FileMan_FileRename',
	'FileMan: Delete\tDel|FileMan_FileDelete',
	'FileMan: Execute|FileMan_FileExec',
	'FileMan: Exec with Params|FileMan_FileExecWithParams',
	'FileMan: Add to Favorites\tIns|Favorites_AddFile',
	'', -- separator
	'Favorites: Add active buffer|Favorites_AddCurrentBuffer',
	'Favorites: Delete item\tDel|Favorites_DeleteItem',
}
-------------------------
local tab1 = gui.panel(panel_width + 18)

local list_func_height = win_height/3
if list_func_height <= 0 then list_func_height = 200 end
local list_bookmarks = gui.list(true)
list_bookmarks:add_column("@", 24)
list_bookmarks:add_column("Bookmarks", 600)
tab1:add(list_bookmarks, "bottom", list_func_height)
if colorback then list_bookmarks:set_list_colour(colorfore,colorback) end

local list_func = gui.list(true)
list_func:add_column("Functions/Procedures", 600)
tab1:client(list_func)
if colorback then list_func:set_list_colour(colorfore,colorback) end

tab1:context_menu {
	'Functions: Sort by Order|Functions_SortByOrder',
	'Functions: Sort by Name|Functions_SortByName',
	'Functions: Show/Hide Flags|Functions_ToggleFlags',
	'Functions: Show/Hide Parameters|Functions_ToggleParams',
}
-------------------------
local tab2 = gui.panel(panel_width + 18)

local list_abbrev = gui.list(true)
list_abbrev:add_column("Abbrev", 60)
list_abbrev:add_column("Expansion", 600)
tab2:client(list_abbrev)
if colorback then list_abbrev:set_list_colour(colorfore,colorback) end

-------------------------
local win_parent
if win then
	win_parent = gui.window "Side Bar"
else
	win_parent = gui.panel(panel_width)
end

local tabs = gui.tabbar(win_parent)
tabs:add_tab("FileMan", tab0)
tabs:add_tab("Func/Bmk", tab1)
tabs:add_tab("Abbrev", tab2)
win_parent:client(tab2)
win_parent:client(tab1)
win_parent:client(tab0)

if tonumber(props['sidebar.show'])==1 then
	if win then
		win_parent:size(panel_width + 24, 600)
		win_parent:show()
	else
		gui.set_panel(win_parent,"right")
	end
end

----------------------------------------------------------
-- tab0:memo_path   Path and Mask
----------------------------------------------------------
local current_path = ''
local file_mask = '*.*'

local function FileMan_ShowPath()
	local rtf = [[{\rtf\ansi\ansicpg1251{\fonttbl{\f0\fcharset204 Helv;}}{\colortbl;\red0\green0\blue255;\red255\green0\blue0;}\f0\fs16]]
	local path = '\\cf1'..current_path:gsub('\\', '\\\\')
	local mask = '\\cf2'..file_mask..'}'
	memo_path:set_text(rtf..path..mask)
end

----------------------------------------------------------
-- tab0:list_dir   File Manager
----------------------------------------------------------
local function FileMan_ListFILL()
	if current_path == '' then return end
	local folders = gui.files(current_path..'*', true)
	if not folders then return end
	list_dir:clear()
	list_dir:add_item ('[..]', {'..','d'})
	for i, d in ipairs(folders) do
		list_dir:add_item('['..d..']', {d,'d'})
	end
	local files = gui.files(current_path..file_mask)
	if files then
		for i, filename in ipairs(files) do
			list_dir:add_item(filename, {filename})
		end
	end
	list_dir:set_selected_item(0)
	FileMan_ShowPath()
end

local function FileMan_GetSelectedItem()
	local idx = list_dir:get_selected_item()
	if idx == -1 then return '' end
	local data = list_dir:get_item_data(idx)
	local dir_or_file = data[1]
	local attr = data[2]
	return dir_or_file, attr
end

function FileMan_ChangeDir()
	local newPath = gui.select_dir_dlg('Please change current directory', current_path)
	if newPath == nil then return end
	if newPath:match('[\\/]$') then
		current_path = newPath
	else
		current_path = newPath..'\\'
	end
	FileMan_ListFILL()
end

function FileMan_MaskAllFiles()
	file_mask = '*.*'
	FileMan_ListFILL()
end

function FileMan_MaskOnlyCurrentExt()
	local filename, attr = FileMan_GetSelectedItem()
	if filename == '' then return end
	if attr == 'd' then return end
	file_mask = '*.'..filename:gsub('.+%.','')
	FileMan_ListFILL()
end

function FileMan_FileCopy()
	local filename = FileMan_GetSelectedItem()
	if filename == '' or filename == '..' then return end
	local path_destination = gui.select_dir_dlg("Copy to...")
	if path_destination == nil then return end
	os_copy(current_path..filename, path_destination..'\\'..filename)
	FileMan_ListFILL()
end

function FileMan_FileMove()
	local filename = FileMan_GetSelectedItem()
	if filename == '' or filename == '..' then return end
	local path_destination = gui.select_dir_dlg("Move to...")
	if path_destination == nil then return end
	os.rename(current_path..filename, path_destination..'\\'..filename)
	FileMan_ListFILL()
end

function FileMan_FileRename()
	local filename = FileMan_GetSelectedItem()
	if filename == '' or filename == '..' then return end
	local filename_new = shell.inputbox("Rename", "Enter new file name:", filename, function(name) return not name:match('[\\/:|*?"<>]') end)
	if filename_new == nil then return end
	if filename_new ~= '' and filename_new ~= filename then
		os.rename(current_path..filename, current_path..filename_new)
		FileMan_ListFILL()
	end
end

function FileMan_FileDelete()
	local filename, attr = FileMan_GetSelectedItem()
	if filename == '' then return end
	if attr == 'd' then return end
	if shell.msgbox("Are you sure you want to DELETE this file?\n"..filename, "DELETE", 4+256) == 6 then
	-- if gui.message("Are you sure you want to DELETE this file?\n"..filename, "query") then
		os.remove(current_path..filename)
		FileMan_ListFILL()
	end
end

local function FileMan_FileExecWithSciTE(cmd, mode)
	local p0 = props["command.0.*"]
	local p1 = props["command.mode.0.*"]
	props["command.name.0.*"] = 'tmp'
	props["command.0.*"] = cmd
	if mode == nil then mode = 'console' end
	props["command.mode.0.*"] = 'subsystem:'..mode..',savebefore:no'
	scite.MenuCommand(9000)
	props["command.0.*"] = p0
	props["command.mode.0.*"] = p1
end

function FileMan_FileExec(params)
	if params == nil then params = '' end
	local filename = FileMan_GetSelectedItem()
	if filename == '' then return end
	local file_ext = filename:match("[^.]+$")
	if file_ext == nil then return end
	file_ext = '%*%.'..string.lower(file_ext)
	local cmd = ''
	local function CommandBuild(lng)
		local cmd = props['command.build.$(file.patterns.'..lng..')']
		cmd = cmd:gsub(props["FilePath"], current_path..filename)
		return cmd
	end
	-- Lua
	if string.match(props['file.patterns.lua'], file_ext) ~= nil then
		dostring(params)
		dofile(current_path..filename)
	-- Batch
	elseif string.match(props['file.patterns.batch'], file_ext) ~= nil then
		FileMan_FileExecWithSciTE(CommandBuild('batch'))
		return
	-- WSH
	elseif string.match(props['file.patterns.wscript']..props['file.patterns.wsh'], file_ext) ~= nil then
		FileMan_FileExecWithSciTE(CommandBuild('wscript'))
	-- Other
	else
		local ret, descr = shell.exec(current_path..filename..params)
		if not ret then
			print (">Exec: "..filename)
			print ("Error: "..descr)
		end
	end
end

function FileMan_FileExecWithParams()
	if scite.ShowParametersDialog('Exec "'..FileMan_GetSelectedItem()..'". Please set params:') then
		local params = ''
		for p = 1, 4 do
			local ps = props[tostring(p)]
			if ps ~= '' then
				params = params..' '..ps
			end
		end
		FileMan_FileExec(params)
	end
end

local function OpenFile(filename)
	if filename:match(".session$") ~= nil then
		filename = filename:gsub('\\','\\\\')
		scite.Perform ("loadsession:"..filename)
	else
		scite.Open(filename)
	end
	gui.pass_focus()
end

local function FileMan_OpenItem()
	local dir_or_file, attr = FileMan_GetSelectedItem()
	if dir_or_file == '' then return end
	if attr == 'd' then
		gui.chdir(dir_or_file)
		if dir_or_file == '..' then
			local new_path = current_path:gsub('(.*\\).*\\$', '%1')
			if not gui.files(new_path..'*',true) then return end
			current_path = new_path
		else
			current_path = current_path..dir_or_file..'\\'
		end
		FileMan_ListFILL()
	else
		OpenFile(current_path..dir_or_file)
	end
end

list_dir:on_double_click(function()
	FileMan_OpenItem()
end)

list_dir:on_key(function(key)
	if key == 13 then -- Enter
		FileMan_OpenItem()
	elseif key == 8 then -- BackSpace
		list_dir:set_selected_item(0)
		FileMan_OpenItem()
	elseif key == 46 then -- Delete
		FileMan_FileDelete()
	elseif key == 45 then -- Insert
		Favorites_AddFile()
	end
end)

----------------------------------------------------------
-- tab0:list_favorites   Favorites
----------------------------------------------------------
local favorites_filename = props['SciteUserHome']..'\\favorites.lst'
local list_fav_table = {}

local function Favorites_ListFILL()
	list_favorites:clear()
	table.sort(list_fav_table,
		function(a, b)
			local function IsSession(filepath)
				return filepath:gsub('^.*%.',''):upper() == 'SESSION'
			end
			local isAses = IsSession(a)
			local isBses = IsSession(b)
			if (isAses and isBses) or not (isAses or isBses) then
				return a < b
			else
				return isAses
			end
		end
	)
	for _, s in ipairs(list_fav_table) do
		list_favorites:add_item(s:gsub('.+\\',''), s)
	end
end

local function Favorites_OpenList()
	local favorites_file = io.open(favorites_filename)
	if favorites_file then
		for line in favorites_file:lines() do
			if line ~= '' then
				line = ReplaceWithoutCase(line, '$(SciteDefaultHome)', props['SciteDefaultHome'])
				list_fav_table[#list_fav_table+1] = line
			end
		end
		favorites_file:close()
	end
	Favorites_ListFILL()
end
Favorites_OpenList()

local function Favorites_SaveList()
	io.output(favorites_filename)
	local list_string = table.concat(list_fav_table,'\n')
	list_string = ReplaceWithoutCase(list_string, props['SciteDefaultHome'], '$(SciteDefaultHome)')
	io.write(list_string)
	io.close()
end

function Favorites_AddFile()
	local filename, attr = FileMan_GetSelectedItem()
	if filename == '' then return end
	if attr == 'd' then return end
	list_fav_table[#list_fav_table+1] = current_path..filename
	Favorites_ListFILL()
end

function Favorites_AddCurrentBuffer()
	list_fav_table[#list_fav_table+1] = props['FilePath']
	Favorites_ListFILL()
end

function Favorites_DeleteItem()
	local idx = list_favorites:get_selected_item()
	if idx == -1 then return end
	list_favorites:delete_item(idx)
	table.remove (list_fav_table, idx+1)
end

local function Favorites_OpenFile()
	local idx = list_favorites:get_selected_item()
	if idx == -1 then return end
	local filename = list_favorites:get_item_data(idx)
	OpenFile(filename)
end

local function Favorites_ShowFilePath()
	local sel_item = list_favorites:get_selected_item()
	if sel_item == -1 then return end
	local expansion = list_favorites:get_item_data(sel_item)
	editor:CallTipCancel()
	editor:CallTipShow(-2, expansion)
end

list_favorites:on_select(function()
	Favorites_ShowFilePath()
end)

list_favorites:on_double_click(function()
	Favorites_OpenFile()
end)

list_favorites:on_key(function(key)
	if key == 13 then -- Enter
		Favorites_OpenFile()
	elseif key == 46 then -- Delete
		Favorites_DeleteItem()
	end
end)

----------------------------------------------------------
-- tab1:list_func   Functions/Procedures
----------------------------------------------------------
local table_functions = {}
-- 1 - function names
-- 2 - line number
-- 3 - function paramaters with parentheses
local _sort = 'order'
local _backjumppos -- store position if jumping

local Lang2lpeg = {}
do
	local P, V, Cg, Ct, Cc, S, R, C, Carg, Cf, Cb, Cp, Cmt = lpeg.P, lpeg.V, lpeg.Cg, lpeg.Ct, lpeg.Cc, lpeg.S, lpeg.R, lpeg.C, lpeg.Carg, lpeg.Cf, lpeg.Cb, lpeg.Cp, lpeg.Cmt

	--@todo: переписать с использованием lpeg.Cf
	local function AnyCase(str)
		local res = P'' --empty pattern to start with
		local ch, CH
		for i = 1, #str do
			ch = str:sub(i,i):lower()
			CH = ch:upper()
			res = res * S(CH..ch)
		end
		assert(res:match(str))
		return res
	end

	local PosToLine = function (pos) return editor:LineFromPosition(pos) end

--v------- common patterns -------v--
	-- basics
	local EOF = P(-1)
	local BOF = P(function(s,i) return (i==1) and 1 end)
	local NL = P"\n"-- + P"\f" -- pattern matching newline, platform-specific. \f = page break marker
	local AZ = R('AZ','az')+"_"
	local N = R'09'
	local ANY =  P(1)
	local ESCANY = P'\\'*ANY + ANY
	local SINGLESPACE = S'\n \t\r\f'
	local SPACE = SINGLESPACE^1

	-- simple tokens
	local IDENTIFIER = AZ * (AZ+N)^0 -- simple identifier, without separators

	local Str1 = P'"' * ( ESCANY - (S'"'+NL) )^0 * (P'"' + NL)--NL == error'unfinished string')
	local Str2 = P"'" * ( ESCANY - (S"'"+NL) )^0 * (P"'" + NL)--NL == error'unfinished string')
	local STRING = Str1 + Str2

	-- c-like-comments
	local line_comment = '//' * (ESCANY - NL)^0*NL
	local block_comment = '/*' * (ESCANY - P'*/')^0 * (P('*/') + EOF)
	local COMMENT = (line_comment + block_comment)^1

	local SC = SPACE + COMMENT
	local IGNORED = SPACE + COMMENT + STRING
	-- special captures
	local cp = Cp() -- pos capture, Carg(1) is the shift value, comes from start_code_pos
	local cl = cp/PosToLine -- line capture, uses editor:LineFromPosition
	local par = C(P"("*(1-P")")^0*P")") -- captures parameters in parentheses
--^------- common patterns -------^--

	do --v------- asm -------v--
		-- redefine common patterns
		local SPACE = S' \t'^1
		local NL = P"\r\n"

		local IGNORED = (ESCANY - NL)^0 * NL -- just skip line by line

		-- define local patterns
		local p = P"proc"
		local F = P"FRAME"
		-- create flags:
		F = Cg(F*Cc(true),'F')
		-- create additional captures
		I = C(IDENTIFIER)*cl
		-- definitions to capture:
		local par = C((ESCANY - NL)^0)
		local def1 = I*SPACE*(p+F)
		local def2 = p*SPACE*I*P','^-1
		local def = (SPACE+P'')*Ct((def1+def2)*(SPACE*par)^-1)*NL
		-- resulting pattern, which does the work
		local patt = (def + IGNORED + 1)^0 * EOF

		Lang2lpeg.Assembler = lpeg.Ct(patt)
	end --do --^------- ASM -------^--

	do --v------- Lua -------v--
		-- redefine common patterns
		local IDENTIFIER = IDENTIFIER*(P'.'*IDENTIFIER)^0*(P':'*IDENTIFIER)^-1
		-- LONG BRACKETS
		local long_brackets = #(P'[' * P'='^0 * P'[') *
			function (subject, i1)
				local level = _G.assert( subject:match('^%[(=*)%[', i1) )
				local _, i2 = subject:find(']'..level..']', i1, true)  -- true = plain "find substring"
				return (i2 and (i2+1)) or #subject+1--error('unfinished long brackets')
				-- ^ if unfinished long brackets then capture till EOF (at #subject+1)
		end
		local LUALONGSTR = long_brackets

		local multi  = P'--' * long_brackets
		local single = P'--' * (1 - NL)^0 * NL
		local COMMENT = multi + single
		local SC = SPACE + COMMENT

		local IGNORED = SPACE + COMMENT + STRING + LUALONGSTR

		-- define local patterns
		local f = P"function"
		local l = P"local"
		-- create flags
		l = Cg(l*SC^1*Cc(true),'l')^-1
		-- create additional captures
		I = C(IDENTIFIER)*cl
		-- definitions to capture:
		local funcdef1 = l*f*SC^1*I*SC^0*par -- usual function declaration
		local funcdef2 = l*I*SC^0*"="*SC^0*f*SC^0*par -- declaration through assignment
		local def = Ct(funcdef1 + funcdef2)
		-- resulting pattern, which does the work
		local patt = (def + IGNORED^1 + IDENTIFIER + 1)^0 * (EOF) --+ error'invalid character')

		Lang2lpeg.Lua = lpeg.Ct(patt)
	end --do --^------- Lua -------^--

	do --v----- Pascal ------v--
		-- redefine common patterns
		local IDENTIFIER = IDENTIFIER*(P'.'*IDENTIFIER)^0
		local STRING = P"'" *( ANY - (P"'"+NL) )^0 *(P"'"+NL) --NL == error'unfinished string')
		--^ there's no problem with pascal strings with double single quotes in the middle, like this:
		--  'first''second'
		--  in the loop, STRING just matches the 'first'-part, and then the 'second'.

		local multi1  = P'(*' *(1-P'*)')^0 * (P'*)' + EOF)--unfinished long comment
		local multi2  = P'{' *(1-P'}')^0 * (P'}' + EOF)--unfinished long comment
		local single = P'//' * (1 - NL)^0 * NL
		local COMMENT = multi1 + multi2 + single

		local SC = SPACE + COMMENT
		local IGNORED = SPACE + COMMENT + STRING

		-- define local patterns
		local f = AnyCase"function"
		local p = AnyCase"procedure"
		local c = AnyCase"constructor"
		local d = AnyCase"destructor"
		local restype = AZ^1
		-- create flags:
		-- f = Cg(f*Cc(true),'f')
		restype = Cg(C(restype),'')
		p = Cg(p*Cc(true),'p')
		c = Cg(c*Cc(true),'c')
		d = Cg(d*Cc(true),'d')
		-- create additional captures
		local I = C(IDENTIFIER)*cl
		-- definitions to capture:
		local procdef = Ct((p+c+d)*SC^1*I*SC^0*par^-1)
		local funcdef = Ct(f*SC^1*I*SC^0*par^-1*SC^0*P':'*SC^0*restype*SC^0*P';')
		-- resulting pattern, which does the work
		local patt = (procdef + funcdef + IGNORED^1 + IDENTIFIER + 1)^0 * EOF

		Lang2lpeg.Pascal = lpeg.Ct(patt)
	end --^----- Pascal ------^--

	do --v----- C++ ------v--
		-- define local patterns
		local keywords = P'if'+P'else'+P'switch'+P'case'+P'while'+P'for'
		local nokeyword = -(keywords)
		local type = P"static "^-1*P"const "^-1*P"enum "^-1*P'*'^-1*IDENTIFIER*P'*'^-1
		local funcbody = P"{"*(ESCANY-P"}")^0*P"}"
		-- redefine common patterns
		local IDENTIFIER = P'*'^-1*P'~'^-1*IDENTIFIER
		IDENTIFIER = IDENTIFIER*(P"::"*IDENTIFIER)^-1
		-- create flags:
		type = Cg(type,'')
		-- create additional captures
		local I = nokeyword*C(IDENTIFIER)*cl
		-- definitions to capture:
		local funcdef = nokeyword*Ct((type*SC^1)^-1*I*SC^0*par*SC^0*(#funcbody))
		local classconstr = nokeyword*Ct((type*SC^1)^-1*I*SC^0*par*SC^0*P':'*SC^0*IDENTIFIER*SC^0*(P"("*(1-P")")^0*P")")*SC^0*(#funcbody)) -- this matches smthing like PrefDialog::PrefDialog(QWidget *parent, blabla) : QDialog(parent)
		-- resulting pattern, which does the work
		local patt = (classconstr + funcdef + IGNORED^1 + IDENTIFIER + ANY)^0 * EOF

		Lang2lpeg['C++'] = lpeg.Ct(patt)
	end --^----- C++ ------^--

	do --v----- JS ------v--
		-- redefine common patterns
		local NL = NL + P"\f"
		local regexstr = P'/' * (ESCANY - (P'/' + NL))^0*(P'/' * S('igm')^0 + NL)
		local STRING = STRING + regexstr
		-- define local patterns
		local f = P"function"
		local funcbody = P"{"*(ESCANY-P"}")^0*P"}"
		-- create additional captures
		local I = C(IDENTIFIER)*cl
		-- definitions to capture:
		local funcdef = Ct(f*SC^1*I*SC^0*par*SC^0*(#funcbody))

		-- resulting pattern, which does the work
		local patt = (funcdef + IGNORED^1 + IDENTIFIER + 1)^0 * EOF

		Lang2lpeg.JScript = lpeg.Ct(patt)
	end --^----- JS ------^--

	do --v----- VB ------v--
		-- redefine common patterns
		local STRING = P'"' * (ANY - (P'"' + NL))^0*(P'"' + NL)
		local COMMENT = (P"'" + P"REM ") * (ANY - NL)^0*NL
		local SC = SPACE
		-- define local patterns
		local f = AnyCase"function"
		local p = AnyCase"property"
			local let = AnyCase"let"
			local get = AnyCase"get"
			local set = AnyCase"set"
		local s = AnyCase"sub"
		-- create flags:
		-- f = Cg(f*Cc(true),'f')
		local restype = (P"As"+P"as")*SPACE*Cg(C(AZ^1),'')
		let = Cg(let*Cc(true),'pl')
		get = Cg(get*Cc(true),'pg')
		set = Cg(set*Cc(true),'ps')
		p = p*SC^1*(let+get+set)
		-- create additional captures
		local I = C(IDENTIFIER)*cl
		-- definitions to capture:
		f = f*SC^1*I*SC^0*par
		p = p*SC^1*I*SC^0*par
		s = s*SC^1*I*SC^0*par
		local def = Ct((f + s + p)*(SPACE*restype)^-1)
		-- resulting pattern, which does the work
		local patt = (def + IGNORED^1 + IDENTIFIER + 1)^0 * EOF

		Lang2lpeg.VisualBasic = lpeg.Ct(patt)
	end --^----- VB ------^--

	do --v------- Python -------v--
		-- redefine common patterns
		local SPACE = S' \t'^1
		local IGNORED = (ESCANY - NL)^0 * NL -- just skip line by line
		-- define local patterns
		local c = P"class"
		local d = P"def"
		-- create flags:
		c = Cg(c*Cc(true),'class')
		-- create additional captures
		I = C(IDENTIFIER)*cl
		-- definitions to capture:
		local def = (c+d)*SPACE*I
		def = (SPACE+P'')*Ct(def*SPACE^-1*par)*SPACE^-1*P':'
		-- resulting pattern, which does the work
		local patt = (def + IGNORED + 1)^0 * EOF

		Lang2lpeg.Python = lpeg.Ct(patt)
	end --do --^------- Python -------^--

	do --v------- nnCron -------v--
		-- redefine common patterns
		local IDENTIFIER = (ANY - SPACE)^1
		local SPACE = S' \t'^1
		local IGNORED = (ESCANY - NL)^0 * NL -- just skip line by line
		-- define local patterns
		local d = P":"
		-- create additional captures
		I = C(IDENTIFIER)*cl
		-- definitions to capture:
		local def = d*SPACE*I
		def = Ct(def*(SPACE*par)^-1)*IGNORED
		-- resulting pattern, which does the work
		local patt = (def + IGNORED + 1)^0 * EOF

		Lang2lpeg.nnCron = lpeg.Ct(patt)
	end --do --^------- nnCron -------^--

	do --v------- CSS -------v--
		-- helper
		local function clear_spaces(s)
			return s:gsub('%s+',' ')
		end
 		-- redefine common patterns
		local IDENTIFIER = (ANY - SPACE)^1
		local NL = P"\r\n"
		local SPACE = S' \t'^1
		local IGNORED = (ANY - NL)^0 * NL -- just skip line by line
		local par = C(P"{"*(1-P"}")^0*P"}")/clear_spaces -- captures parameters in parentheses
		-- create additional captures
		I = C(IDENTIFIER)*cl
		-- definitions to capture:
		local def = Ct(I*SPACE*par)--*IGNORED
		-- resulting pattern, which does the work
		local patt = (def + IGNORED + 1)^0 * EOF

		Lang2lpeg.CSS = lpeg.Ct(patt)
	end --do --^------- CSS -------^--

	do --v----- * ------v--
		-- redefine common patterns
		local NL = P"\r\n"+P"\n"+P"\f"
		local SC = S" \t\160" -- без пон€ти€ что за символ с кодом 160, но он встречаетс€ в SciTEGlobal.properties непосредственно после [Warnings] 10 раз.
		local COMMENT = P'#'*(ANY - NL)^0*NL
		-- define local patterns
		local somedef = S'fFsS'*S'uU'*S'bBnN'*AZ^0 --пытаемс€ поймать что-нибудь, похожее на определение функции...
		local section = P'['*(ANY-P']')^1*P']'
		-- create flags
		local somedef = Cg(somedef, '')
		-- create additional captures
		local I = C(IDENTIFIER)*cl
		section = C(section)*cl
		local tillNL = C((ANY-NL)^0)
		-- definitions to capture:
		local def1 = Ct(somedef*SC^1*I*SC^0*(par+tillNL))
		local def2 = (NL+BOF)*Ct(section*SC^0*tillNL)*NL

		-- resulting pattern, which does the work
		local patt = (def2 + def1 + COMMENT + IDENTIFIER + 1)^0 * EOF
		-- local patt = (def2 + def1 + IDENTIFIER + 1)^0 * EOF -- чуть медленнее

		Lang2lpeg['*'] = lpeg.Ct(patt)
	end --^----- * ------^--

end

local Lang2CodeStart = {
	['Pascal']='^IMPLEMENTATION$',
}

local Lexer2Lang = {
	['asm']='Assembler',
	['cpp']='C++',
	['js']='JScript',
	['vb']='VisualBasic',
	['vbscript']='VisualBasic',
	['css']='CSS',
	['pascal']='Pascal',
	['python']='Python',
	['lua']='Lua',
	['nncrontab']='nnCron',
}

local Ext2Lang = {}
do -- Fill_Ext2Lang
	local patterns = {
		[props['file.patterns.asm']]='Assembler',
		[props['file.patterns.cpp']]='C++',
		[props['file.patterns.wsh']]='JScript',
		[props['file.patterns.vb']]='VisualBasic',
		[props['file.patterns.wscript']]='VisualBasic',
		['*.css']='CSS',
		[props['file.patterns.pascal']]='Pascal',
		[props['file.patterns.py']]='Python',
		[props['file.patterns.lua']]='Lua',
		[props['file.patterns.nncron']]='nnCron',
	}
	for i,v in pairs(patterns) do
		for ext in (i..';'):gfind("%*%.([^;]+);") do
			Ext2Lang[ext] = v
		end
	end
end -- Fill_Ext2Lang

local function GetFlagsAndCut(findString)
	local findString = findString
	local t = {}
	findString,f = ReplaceWithoutCase(findString, "Sub ", "") -- VB
	t["s"] = f and true
	findString,f = ReplaceWithoutCase(findString, "Function ", "") -- JS, VB,...
	t["f"] = f and true
	findString,f = ReplaceWithoutCase(findString, "Procedure ", "") -- Pascal
	t["p"] = f and true
	findString,f = ReplaceWithoutCase(findString, "Proc ", "") -- C
	t["p"] = t.p or (f and true)
	findString,f = ReplaceWithoutCase(findString, "Property Let ", "") -- VB
	t["pl"] = f and true
	findString,f = ReplaceWithoutCase(findString, "Property Get ", "") -- VB
	t["pg"] = f and true
	findString,f = ReplaceWithoutCase(findString, "Property Set ", "") -- VB
	t["ps"] = f and true
	findString,f = ReplaceWithoutCase(findString, "CLASS ", "") -- Phyton
	t["c"] = f and true
	findString,f = ReplaceWithoutCase(findString, "DEF ", "") -- Phyton
	t["d"] = f and true
	return findString, t
end

local function Functions_GetNames()
	_DEBUG.timerstart('Functions_GetNames')
	table_functions = {}
	if editor.Length == 0 then return end

	local ext = props["FileExt"]:lower() -- a bit unsafe...
	local lang = Ext2Lang[ext]

	local start_code = Lang2CodeStart[lang]
	local lpegPattern = Lang2lpeg[lang]
	if not lpegPattern then
		lang = Lexer2Lang[editor.LexerLanguage]
		start_code = Lang2CodeStart[lang]
		lpegPattern = Lang2lpeg[lang]
		if not tablePattern then
			start_code = Lang2CodeStart['*']
			lpegPattern = Lang2lpeg['*']
		end
	end
	local textAll = editor:GetText()
	local start_code_pos = 0
	if start_code then
		start_code_pos = editor:findtext(start_code, SCFIND_REGEXP)
	end

	-- lpegPattern = nil
	table_functions = lpegPattern:match(textAll, start_code_pos+1) -- 2nd arg is the symbol index to start with
	_DEBUG.timerstop('Functions_GetNames','lpeg')
end

local function Functions_ListFILL()
	if tonumber(props['sidebar.show'])~=1 or tab_index~=1 then return end
	if _sort == 'order' then
		table.sort(table_functions, function(a, b) return a[2] < b[2] end)
	else
		table.sort(table_functions, function(a, b) return a[1]:lower() < b[1]:lower() end)
	end
	-- remove duplicates
	for i = #table_functions, 2, -1 do
		if table_functions[i][2] == table_functions[i-1][2] then
			table.remove (table_functions, i)
		end
	end
	list_func:clear()

	local function emptystr(...) return '' end
	local function GetParams (funcitem)
		return (funcitem[3] and ' '..funcitem[3]) or ''
	end
	local function GetFlags (funcitem)
		local res = ''
		local add = ''
		for flag,value in pairs(funcitem) do
			if type(flag)=='string' then
				if type(value)=='string' then	add = flag .. value
				elseif type(value)=='number' then add = flag..':'..value
				else add = flag end
				res = res .. '['.. add ..']'
			end
		end
		if res~='' then res = res .. ' ' end
		return res or ''
	end
	if not _show_params then GetParams = emptystr end
	if not _show_flags then GetFlags = emptystr end

	local function fixname (funcitem)
		return GetFlags(funcitem)..funcitem[1]..GetParams(funcitem)
	end
	for _, a in ipairs(table_functions) do
		list_func:add_item(fixname(a), a[2])
	end
end

function Functions_SortByOrder()
	_sort = 'order'
	Functions_ListFILL()
end

function Functions_SortByName()
	_sort = 'name'
	Functions_ListFILL()
end

function Functions_ToggleParams ()
	_show_params = not _show_params
	Functions_ListFILL()
end

function Functions_ToggleFlags ()
	_show_flags = not _show_flags
	Functions_ListFILL()
end

local function Functions_GotoLine()
	local sel_item = list_func:get_selected_item()
	if sel_item == -1 then return end
	local pos = list_func:get_item_data(sel_item)
	if pos then
		ShowCompactedLine(pos)
		editor:GotoLine(pos)
		gui.pass_focus()
	end
end

list_func:on_double_click(function()
	Functions_GotoLine()
end)

list_func:on_key(function(key)
	if key == 13 then -- Enter
		Functions_GotoLine()
	end
end)

----------------------------------------------------------
-- tab1:list_bookmarks   Bookmarks
----------------------------------------------------------
local table_bookmarks = {}

local function GetBufferNumber()
	local buf = props['BufferNumber']
	if buf == '' then buf = 1 else buf = tonumber(buf) end
	return buf
end

local function Bookmark_Add(line_number)
	local line_text = editor:GetLine(line_number)
	if line_text == nil then line_text = '' end
	line_text = line_text:gsub('^%s+', ''):gsub('%s+', ' ')
	if line_text == '' then
		line_text = ' - empty line - ('..(line_number+1)..')'
	end
	for _, a in ipairs(table_bookmarks) do
		if a.FilePath == props['FilePath'] and a.LineNumber == line_number then
		return end
	end
	local bmk = {}
	bmk.FilePath = props['FilePath']
	bmk.BufferNumber = GetBufferNumber()
	bmk.LineNumber = line_number
	bmk.LineText = line_text
	table_bookmarks[#table_bookmarks+1] = bmk
end

local function Bookmark_Delete(line_number)
	for i = #table_bookmarks, 1, -1 do
		if table_bookmarks[i].FilePath == props['FilePath'] then
			if line_number == nil then
				table.remove(table_bookmarks, i)
			elseif table_bookmarks[i].LineNumber == line_number then
				table.remove(table_bookmarks, i)
				break
			end
		end
	end
end

local function Bookmarks_ListFILL()
	if tonumber(props['sidebar.show'])~=1 or tab_index~=1 then return end
	table.sort(table_bookmarks, function(a, b)
									return a.BufferNumber < b.BufferNumber or
											a.BufferNumber == b.BufferNumber and
											a.LineNumber < b.LineNumber
								end)
	list_bookmarks:clear()
	for _, bmk in ipairs(table_bookmarks) do
		list_bookmarks:add_item({bmk.BufferNumber, bmk.LineText}, {bmk.FilePath, bmk.LineNumber})
	end
end

local function Bookmarks_RefreshTable()
	Bookmark_Delete()
	for i = 0, editor.LineCount do
		if editor:MarkerGet(i) == 2 then
			Bookmark_Add(i)
		end
	end
	Bookmarks_ListFILL()
end

local function Bookmarks_GotoLine()
	local sel_item = list_bookmarks:get_selected_item()
	if sel_item == -1 then return end
	local pos = list_bookmarks:get_item_data(sel_item)
	if pos then
		scite.Open(pos[1]) -- FilePath
		ShowCompactedLine(pos[2]) -- LineNumber
		editor:GotoLine(pos[2])
		gui.pass_focus()
	end
end

list_bookmarks:on_double_click(function()
	Bookmarks_GotoLine()
end)

list_bookmarks:on_key(function(key)
	if key == 13 then -- Enter
		Bookmarks_GotoLine()
	end
end)

-- Add user event handler OnClose
local old_OnClose = OnClose
function OnClose(file)
	local result
	if old_OnClose then result = old_OnClose(file) end
	for i = #table_bookmarks, 1, -1 do
		if table_bookmarks[i].FilePath == file then
			table.remove(table_bookmarks, i)
		end
	end
	Bookmarks_ListFILL()
	return result
end

----------------------------------------------------------
-- tab2:list_abbrev   Abbreviations
----------------------------------------------------------
local function Abbreviations_ListFILL()
	local function ReadAbbrev(file)
		local abbrev_file = io.open(file)
		if abbrev_file then
			for line in abbrev_file:lines() do
				if line ~= '' then
					local _abr, _exp = line:match('^([^#].-)=(.+)')
					if _abr ~= nil then
						list_abbrev:add_item({_abr, _exp}, _exp)
					else
						local import_file = line:match('^import%s+(.+)')
						if import_file ~= nil then
							ReadAbbrev(file:match('.+\\')..import_file)
						end
					end
				end
			end
			abbrev_file:close()
		end
	end

	list_abbrev:clear()
	local abbrev_filename = props['AbbrevPath']
	ReadAbbrev(abbrev_filename)
end

local function Abbreviations_InsertExpansion()
	local sel_item = list_abbrev:get_selected_item()
	if sel_item == -1 then return end
	local expansion = list_abbrev:get_item_data(sel_item)
	scite.InsertAbbreviation(expansion)
	gui.pass_focus()
	editor:CallTipCancel()
end

local function Abbreviations_ShowExpansion()
	local sel_item = list_abbrev:get_selected_item()
	if sel_item == -1 then return end
	local expansion = list_abbrev:get_item_data(sel_item)
	expansion = expansion:gsub('\\\\','\4'):gsub('\\r','\r'):gsub('(\\n','\n'):gsub('\\t','\t'):gsub('\4','\\')
	editor:CallTipCancel()
	editor:CallTipShow(editor.CurrentPos, expansion)
end

list_abbrev:on_double_click(function()
	Abbreviations_InsertExpansion()
end)

list_abbrev:on_select(function()
	Abbreviations_ShowExpansion()
end)

list_abbrev:on_key(function(key)
	if key == 13 then -- Enter
		Abbreviations_InsertExpansion()
	end
end)

----------------------------------------------------------
-- Events
----------------------------------------------------------
local line_count

local function OnSwitch()
	_DEBUG.timerstart('OnSwitch')
	line_count = editor.LineCount
	if tab0:bounds() then -- visible FileMan
		local path = props['FileDir']
		if path == '' then return end
		path = path:gsub('\\$','')..'\\'
		if path ~= current_path then
			current_path = path
			FileMan_ListFILL()
		end
	elseif tab1:bounds() then -- visible Funk/Bmk
		Functions_GetNames()
		Functions_ListFILL()
		Bookmarks_ListFILL()
	elseif tab2:bounds() then -- visible Abbrev
		Abbreviations_ListFILL()
	end
	_DEBUG.timerstop('OnSwitch')
end

tabs:on_select(function(ind)
	tab_index=ind
	OnSwitch()
end)

-- —крытие / показ панели
function SideBar_ShowHide()
	if tonumber(props['sidebar.show'])==1 then
		if win then
			win_parent:hide()
		else
			gui.set_panel()
		end
		props['sidebar.show']=0
	else
		if win then
			win_parent:show()
		else
			gui.set_panel(win_parent,"right")
		end
		props['sidebar.show']=1
		OnSwitch()
	end
end

local function OnDocumentCountLinesChanged(def_line_count)
	if tab1:bounds() then -- visible Funk/Bmk
		local cur_line = editor:LineFromPosition(editor.CurrentPos)
		for i = 1, #table_functions do
			local table_line = table_functions[i][2]
			if table_line > cur_line then
				table_functions[i][2] = table_line + def_line_count
			end
		end
		Functions_ListFILL()

		Bookmarks_RefreshTable()
	end
end

-- Add user event handler OnSwitchFile
local old_OnSwitchFile = OnSwitchFile
function OnSwitchFile(file)
	local result
	if old_OnSwitchFile then result = old_OnSwitchFile(file) end
	OnSwitch()
	return result
end

-- Add user event handler OnOpen
local old_OnOpen = OnOpen
function OnOpen(file)
	local result
	if old_OnOpen then result = old_OnOpen(file) end
	OnSwitch()
	return result
end

-- Add user event handler OnUpdateUI
local old_OnUpdateUI = OnUpdateUI
function OnUpdateUI()
	local result
	if old_OnUpdateUI then result = old_OnUpdateUI() end
	if (editor.Focus and line_count) then
		local line_count_new = editor.LineCount
		local def_line_count = line_count_new - line_count
		if def_line_count ~= 0 then
			OnDocumentCountLinesChanged(def_line_count)
			line_count = line_count_new
		end
	end
	return result
end

-- Add user event handler OnSave
local old_OnSave = OnSave
function OnSave(file)
	local result
	if old_OnSave then result = old_OnSave(file) end
	Functions_GetNames()
	Functions_ListFILL()
	return result
end

-- Add user event handler OnSendEditor
local old_OnSendEditor = OnSendEditor
function OnSendEditor(id_msg, wp, lp)
	local result
	if old_OnSendEditor then result = old_OnSendEditor(id_msg, wp, lp) end
	if id_msg == SCI_MARKERADD then
		if lp == 1 then Bookmark_Add(wp) Bookmarks_ListFILL() end
	elseif id_msg == SCI_MARKERDELETE then
		if lp == 1 then Bookmark_Delete(wp) Bookmarks_ListFILL() end
	elseif id_msg == SCI_MARKERDELETEALL then
		if wp == 1 then Bookmark_Delete() Bookmarks_ListFILL() end
	end
	return result
end

-- Add user event handler OnFinalise
local old_OnFinalise = OnFinalise
function OnFinalise()
	local result
	if old_OnFinalise then result = old_OnFinalise() end
	Favorites_SaveList()
	return result
end

----------------------------------------------------------
-- Go to function definition
----------------------------------------------------------

-- ѕо имени функции находим строку с ее объ€влением (инфа беретс€ из table_functions)
local function Func2Line(funcname)
	if not next(table_functions) then
		Functions_GetNames()
	end
	for i = 1, #table_functions do
		if funcname == table_functions[i][1] then
			return table_functions[i][2]
		end
	end
end

-- ѕереход на строку с объ€влением функции
local function JumpToFuncDefinition()
	local funcname = GetCurrentWord()
	local line = Func2Line(funcname)
	if line then
		_backjumppos = editor.CurrentPos
		editor:GotoLine(line)
		return true
	end
	return false
end

local function JumpBack()
	if not _backjumppos then return false end
	editor:GotoPos(_backjumppos)
	_backjumppos = nil
	return true
end

-- Add user event handler OnDoubleClick
local old_OnDoubleClick = OnDoubleClick
function OnDoubleClick(shift, ctrl, alt)
	local result
	if old_OnDoubleClick then result = old_OnDoubleClick(shift, ctrl, alt) end
	if shift then
		if JumpToFuncDefinition() then return true end
	end
	return result
end

-- Add user event handler OnKey
local old_OnKey = OnKey
function OnKey(key, shift, ctrl, alt, char)
	local result
	if old_OnKey then result = old_OnKey(key, shift, ctrl, alt, char) end
	if (editor.Focus) then
		if ctrl and key == 188 and JumpBack() then return true end --char == ','
		if ctrl and key == 190 and JumpToFuncDefinition() then return true end --char == '.'
	end
	return result
end
