--[[
Eng: Creating SVN commands submenu in tab context menu
Rus: —оздает в контекстном меню таба (вкладки) подменю дл€ команд SVN
Version: 1.2
Author: VladVRO

Using:
Add next line to lua startup file (SciTEStartup.lua):
	dofile ("svn_menu.lua")
]]
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++
require 'shell'

-- SVN menu
local SVNContectMenu =
	"||"..
	"SVN|POPUPBEGIN|"..
	"$(FileMenuCommands)"..
	"$(BranchMenuCommands)"..
	"$(RootMenuCommands)"..
	"SVN|POPUPEND|"
local FileMenuCommands =
	"Update|9181|"..
	"CommitЕ|9182|"..
	"RevertЕ|9183|"..
	"Diff|9184|"..
	"Show log|9186|"
local NewFileMenuCommands =
	"AddЕ|9185|"
local RootMenuCommands =
	"||"..
	"Update All|9190|"..
	"Commit AllЕ|9191|"..
	"Show log for All|9192|"
local BranchMenuCommands =
	"||"..
	"Update 'trunk'|9187|"..
	"Commit 'trunk'Е|9188|"..
	"Show log for 'trunk'|9189|"

local function update_svn_menu()
	local menu = props["user.tabcontext.menu.*"]
	local filedir = props["FileDir"]
	local svnroot = ""
	local svnbranch = ""
	local isSVN = false
	local svnSign
	-- test SVN context
	if shell.fileexists(filedir.."\\.svn") then
		isSVN = true
		svnSign = "."
	elseif shell.fileexists(filedir.."\\_svn") then
		isSVN = true
		svnSign = "_"
	end
	if isSVN then
		-- file in SVN context
		svnroot = filedir
		local filemenu = FileMenuCommands
		local branchmenu = ""
		local child = ""
		-- open SVN data file
		local entries = io.open(filedir.."\\"..svnSign.."svn\\entries")
		if entries ~= nil then
			entries:seek("set")
			local data = entries:read("*a")
			entries:close()
			if not string.find(data, "\n"..props["FileNameExt"].."\n", 1, 1) then
				filemenu = NewFileMenuCommands
			end
		end
		-- find SVN branch/trunk and root
		repeat
			local _,_,parent,name = string.find(svnroot, "(.*)\\([^\\]+)")
			if name == "trunk" then
				svnbranch = svnroot
				branchmenu = BranchMenuCommands
			elseif name == "branches" then
				svnbranch = child
				local _,_,branchname = string.find(svnbranch, ".*\\([^\\]+)")
				branchmenu = string.gsub(BranchMenuCommands, "trunk", branchname)
			end
			if parent then
				if shell.fileexists(parent.."\\"..svnSign.."svn") then
					child = svnroot
					svnroot = parent
				else
					break
				end
			end
		until not parent
		-- set menu
		if not string.find(menu,"|||SVN|") then
			menu = menu.."||SVN||"
		end
		props["user.tabcontext.menu.*"] =
			string.gsub(menu, "||SVN|.*", 
			string.gsub(string.gsub(string.gsub(SVNContectMenu,
			"$%(FileMenuCommands%)", filemenu),
			"$%(BranchMenuCommands%)", branchmenu),
			"$%(RootMenuCommands%)", RootMenuCommands))
	else
		-- no SVN context
		if string.find(menu,"|||SVN|") then
			props["user.tabcontext.menu.*"] = string.gsub(menu, "||SVN|.*", "")
		end
	end
	-- set variables for SVN menu
	props["SVNRoot"] = svnroot
	props["SVNCurrentBranch"] = svnbranch
end

-- ƒобавл€ем свой обработчик событи€ OnOpen
local old_OnOpen = OnOpen
function OnOpen(file)
	local result
	if old_OnOpen then result = old_OnOpen(file) end
	update_svn_menu()
	return result
end

-- ƒобавл€ем свой обработчик событи€ OnSwitchFile
local old_OnSwitchFile = OnSwitchFile
function OnSwitchFile(file)
	local result
	if old_OnSwitchFile then result = old_OnSwitchFile(file) end
	update_svn_menu()
	return result
end
