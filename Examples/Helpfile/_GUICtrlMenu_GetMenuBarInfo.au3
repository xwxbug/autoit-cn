#include <GuiMenu.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hWnd, $aInfo

	; 打开记事本
	Run("Notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")

	; 获取菜单栏信息
	$aInfo = _GUICtrlMenu_GetMenuBarInfo($hWnd)
	Writeln("Left ............:" & $aInfo[0])
	Writeln("Top .............:" & $aInfo[1])
	Writeln("Right ...........:" & $aInfo[2])
	Writeln("Bottom ..........:" & $aInfo[3])
	Writeln("Menu handle .....: 0x" & Hex($aInfo[4]))
	Writeln("Submenu Handle ..: 0x" & Hex($aInfo[5]))
	Writeln("Menu bar focused :" & $aInfo[6])
	Writeln("Menu item focused:" & $aInfo[7])

endfunc   ;==>_Main

; 向记事本写入文本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
endfunc   ;==>Writeln

