#include <GuiMenu.au3>

_Main()

Func _Main()
	Local $hWnd, $hMain, $hFile

	; 打开记事本
	Run("Notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)
	$hFile = _GUICtrlMenu_GetItemSubMenu($hMain, 0)

	; 获取/设置文件菜单数据
	Writeln("File data: " & _GUICtrlMenu_GetMenuData($hFile))
	_GUICtrlMenu_SetMenuData($hFile, 1234)
	Writeln("File data: " & _GUICtrlMenu_GetMenuData($hFile))

EndFunc   ;==>_Main

; 写入一行文本到记事本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
EndFunc   ;==>Writeln
