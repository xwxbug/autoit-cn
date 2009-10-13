-- ROWrite
-- Version: 1.1
-- Автор: Midas, VladVRO
-----------------------------------------------
-- Скрипт для поддержки сохранения RO/Hidden/System файлов
-- Подключение:
--   Добавьте в SciTEStartup.lua строку
--     dofile (props["SciteDefaultHome"].."\\tools\\ROWrite.lua")
-----------------------------------------------
require 'shell'

local function iif (expresion, onTrue, onFalse)
	if (expresion) then return onTrue; else return onFalse; end
end

local function BSave(FN)
	-- Получим аттрибуты файла.
	local FileAttr = props['FileAttr']
	props['FileAttrNumber'] = 0
	if string.find(FileAttr, '[RHS]') then --  Если в файл нельзя записать, то спросим
		if shell.msgbox("Файл доступен только для чтения. Все равно сохранить?\n"
			.."Аттрибуты файла: "..FileAttr, "SciTE", 65)==1 then
			-- сохраним текущии, затем снимем все аттрибуты
			local FileAttrNumber, err = shell.getfileattr(FN)
			if (FileAttrNumber == nil) then
				print("> "..err)
				props['FileAttrNumber'] = 32 + iif(string.find(FileAttr,'R'),1,0) + iif(string.find(FileAttr,'H'),2,0) + iif(string.find(FileAttr,'S'),4,0)
			else
				props['FileAttrNumber'] = FileAttrNumber
			end
			shell.setfileattr(FN, 2080)
		end
	end
end

local function AfterSave(FN)
	-- Если была сохранена строка с аттрибутами, то установим их
	local FileAttrNumber = tonumber(props['FileAttrNumber'])
	if FileAttrNumber ~= nil and FileAttrNumber > 0 then
		shell.setfileattr(FN, FileAttrNumber)
	end
end

-- Добавляем свой обработчик события OnBeforeSave
local old_OnBeforeSave = OnBeforeSave
function OnBeforeSave(file)
	local result
	if old_OnBeforeSave then result = old_OnBeforeSave(file) end
	if BSave(file) then return true end
	return result
end

-- Добавляем свой обработчик события OnSave
local old_OnSave = OnSave
function OnSave(file)
	local result
	if old_OnSave then result = old_OnSave(file) end
	if AfterSave(file) then return true end
	return result
end
