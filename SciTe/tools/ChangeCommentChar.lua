--[[--------------------------------------------------
ChangeCommentChar.lua
Authors: VladVRO, mozers™
Version: 1.0
------------------------------------------------------
Подставляет адекватный символ комментария для файлов обрабатываемых лексером props
(*.properties;*.abbrev;*.session;*.ini;*.inf;*.reg;*.url;*.cfg;*.cnf;*.aut;*.m3u)
------------------------------------------------------
Connection:
 In file SciTEStartup.lua add a line:
    dofile (props["SciteDefaultHome"].."\\tools\\ChangeCommentChar.lua")
--]]--------------------------------------------------

local function ChangeCommentChar()
	function IsINI()
		local ini = {'ini', 'inf', 'reg'}
		local ext = props['FileExt']:lower()
		for _, x in pairs(ini) do
			if x == ext then return true end
		end
		return false
	end
	if editor.LexerLanguage == 'props' then
		if IsINI() then
			props['comment.block.props']=';'
		else
			props['comment.block.props']='#'
		end
	end
end

-- Добавляем свой обработчик события OnSwitchFile
local old_OnSwitchFile = OnSwitchFile
function OnSwitchFile(file)
	local result
	if old_OnSwitchFile then result = old_OnSwitchFile(file) end
	ChangeCommentChar()
	return result
end

-- Добавляем свой обработчик события OnOpen
local old_OnOpen = OnOpen
function OnOpen(file)
	local result
	if old_OnOpen then result = old_OnOpen(file) end
	ChangeCommentChar()
	return result
end
