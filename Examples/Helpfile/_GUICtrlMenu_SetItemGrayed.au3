
#include  <GuiMenu.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hWnd, $hMain, $hFile

	; Open Notepad
	Run("Notepad.exe")

	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)
	$hFile = _GUICtrlMenu_GetItemSubMenu($hMain, 0)

	; Get/Set Open grayed

	Writeln( "Open is grayed:
	"  &  _GUICtrlMenu_GetItemGrayed ( $hFile ,  1 ))
	_GUICtrlMenu_SetItemGrayed($hFile, 1)

	Writeln( "Open is grayed:
	"  &  _GUICtrlMenu_GetItemGrayed ( $hFile ,  1 ))

endfunc   ;==>_Main

; Write a line of text to
Notepad
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
endfunc   ;==>Writeln

