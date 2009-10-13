-- Включает HTML подсветку для нераспознанных файлов,
-- открываемых из меню "просмотр HTML-кода" Internet Explorer
-- author: VladVRO

-- Подключение:
-- В файл SciTEStartup.lua добавьте строку:
--   dofile (props["SciteDefaultHome"].."\\tools\\set_language_onopen.lua")
------------------------------------------------

local function SetLanguage(lng_name)
	local i = 0
	for _,name,_ in string.gfind(props["menu.language"], "([^|]*)|([^|]*)|([^|]*)|") do
		if name == lng_name then
			local IDM_LANGUAGE = 1400 -- constant from SciTE.h
			scite.MenuCommand(IDM_LANGUAGE + i)
			return
		end
		i = i + 1
	end
end

-- Добавляем свой обработчик события OnOpen
local old_OnOpen = OnOpen
function OnOpen(file)
	local result
	if old_OnOpen then result = old_OnOpen(file) end
	if string.sub(props["FilePath"],-1) == ']' then
		local p, _, _ = string.find(props["FilePath"], "Temporary Internet Files", 1)
		if p ~= nil then
			SetLanguage("html")
		end
	end
	-- for wget site mirror
	if string.sub(props["FileExt"],1,5) == 'html@' then
		SetLanguage("html")
	end
	return result
end
