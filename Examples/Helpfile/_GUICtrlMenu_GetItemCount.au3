#include <GuiMenu.au3>

_Main()

Func _Main()
	Local $hWnd, $hMain

	; 打开记事本
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)

	; Show Main menu item count
	Writeln("Main menu item count: " & _GUICtrlMenu_GetItemCount($hMain))

EndFunc   ;==>_Main

; 写入一行文本到记事本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
EndFunc   ;==>Writeln
