#include <GuiMenu.au3>

_Main()

Func _Main()
	Local $hWnd, $hMain, $tRect

	; 打开记事本
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)

	; 获取文件菜单矩形
	$tRect = _GUICtrlMenu_GetItemRectEx($hWnd, $hMain, 0)

	Writeln("File X1: " & DllStructGetData($tRect, "Left"))
	Writeln("File Y1: " & DllStructGetData($tRect, "Top"))
	Writeln("File X2: " & DllStructGetData($tRect, "Right"))
	Writeln("File Y2: " & DllStructGetData($tRect, "Bottom"))

EndFunc   ;==>_Main

; 写入一行文本到记事本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
EndFunc   ;==>Writeln
