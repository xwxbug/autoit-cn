#include <GuiMenu.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hWnd, $hMain, $hFile

	; 打开记事本
	Run("Notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)
	$hFile = _GUICtrlMenu_GetItemSubMenu($hMain, 0)

	; 获取/设置打开项目的文本
	Writeln("Open item text:" & _GUICtrlMenu_GetItemText($hFile, 1))
	_GUICtrlMenu_SetItemText($hFile, 1, "&Closed")
	Writeln("Open item text:" & _GUICtrlMenu_GetItemText($hFile, 1))

endfunc   ;==>_Main

; 向记事本写入文本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
endfunc   ;==>Writeln

