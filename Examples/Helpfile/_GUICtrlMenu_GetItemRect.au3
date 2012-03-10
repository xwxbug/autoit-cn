#include <GuiMenu.au3>

_Main()

Func _Main()
	Local $hWnd, $hMain, $aRect

	; 打开记事本
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)

	; 获取文件菜单矩形
	$aRect = _GUICtrlMenu_GetItemRect($hWnd, $hMain, 0)

	Writeln("File X1: " & $aRect[0])
	Writeln("File Y1: " & $aRect[1])
	Writeln("File X2: " & $aRect[2])
	Writeln("File Y2: " & $aRect[3])

EndFunc   ;==>_Main

; 写入一行文本到记事本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
EndFunc   ;==>Writeln
