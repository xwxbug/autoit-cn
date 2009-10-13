--[[-------------------------------------------------
Zoom.lua
Version: 1.2.1
Authors: mozers™, Дмитрий Маслов
-----------------------------------------------------
Обработка стандартной команды Zoom
Вместе с отображаемыми шрифтами, масштабируется и выводимый на принтер шрифт
Изменяет значение пользовательской переменной font.current.size, используемой для отображения текщего размера шрифта в строке состояния
Изменяет значения параметров (magnification, print.magnification, output.magnification) сохраняемых с помощью save_settings.lua
-----------------------------------------------------
Для подключения добавьте в файл .properties:
  statusbar.text.1=$(font.current.size)px
в файл SciTEStartup.lua:
  dofile (props["SciteDefaultHome"].."\\tools\\Zoom.lua")
--]]-------------------------------------------------

local function ChangeFontSize(zoom)
	if output.Focus then
		props["output.magnification"] = output.Zoom
	else
		props["magnification"] = zoom
		props["print.magnification"] = zoom
		editor.PrintMagnification = zoom
		local font_current_size = props["style.*.32"]:match("size:(%d+)")
		props["font.current.size"] = font_current_size + zoom -- Used in statusbar
		scite.UpdateStatusBar()
	end
end

-- Добавляем свой обработчик события OnSendEditor
local old_OnSendEditor = OnSendEditor
function OnSendEditor(id_msg, wp, lp)
	local result
	if old_OnSendEditor then result = old_OnSendEditor(id_msg, wp, lp) end
	if id_msg == SCI_SETZOOM then
		ChangeFontSize(lp)
	end
	return result
end