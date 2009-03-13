#include <GuiMenu.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hWnd, $hMenu, $iCount, $iI

	; Open Notepad
	Run("Notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMenu = _GUICtrlMenu_GetSystemMenu($hWnd)

	; Play with system menu
	_GUICtrlMenu_InsertMenuItem($hMenu, 5, "&AutoIt")

	; Display system menu
	$iCount = _GUICtrlMenu_GetItemCount($hMenu)
	Writeln("System menu handle: 0x" & Hex($hMenu))
	Writeln("Item count .......: " & $iCount)
	For $iI = 0 To $iCount - 1
		Writeln("Item " & $iI & " text ......: " & _GUICtrlMenu_GetItemText($hMenu, $iI))
	Next

EndFunc   ;==>_Main

; Write a line of text to Notepad
Func Writeln($sText)
	ControlSend("Untitled - Notepad", "", "Edit1", $sText & @CR)
EndFunc   ;==>Writeln