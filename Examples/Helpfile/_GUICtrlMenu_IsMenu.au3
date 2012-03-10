#include <GuiMenu.au3>

_Main()

Func _Main()
	Local $hWnd, $hMain

	; 打开记事本
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)

	; Check return value
	Writeln("Is Menu: " & _GUICtrlMenu_IsMenu($hWnd))
	Writeln("Is Menu: " & _GUICtrlMenu_IsMenu($hMain))

EndFunc   ;==>_Main

; 写入一行文本到记事本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
EndFunc   ;==>Writeln
