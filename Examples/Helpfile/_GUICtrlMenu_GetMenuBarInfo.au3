#include <GuiMenu.au3>

_Main()

Func _Main()
	Local $hWnd, $aInfo

	; 打开记事本
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")

	; Get menu bar info
	$aInfo = _GUICtrlMenu_GetMenuBarInfo($hWnd)
	Writeln("Left ............: " & $aInfo[0])
	Writeln("Top .............: " & $aInfo[1])
	Writeln("Right ...........: " & $aInfo[2])
	Writeln("Bottom ..........: " & $aInfo[3])
	Writeln("Menu handle .....: 0x" & Hex($aInfo[4]))
	Writeln("Submenu Handle ..: 0x" & Hex($aInfo[5]))
	Writeln("Menu bar focused : " & $aInfo[6])
	Writeln("Menu item focused: " & $aInfo[7])

EndFunc   ;==>_Main

; 写入一行文本到记事本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
EndFunc   ;==>Writeln
