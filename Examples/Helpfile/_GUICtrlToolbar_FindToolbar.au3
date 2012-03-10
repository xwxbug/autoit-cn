#include <GuiToolbar.au3>
#include <GUIConstantsEx.au3>

$Debug_TB = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hToolbar

	Run("explorer.exe /root, ,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}")
	WinWaitActive("[CLASS:CabinetWClass]")
	Sleep(1000)
	$hToolbar = _GUICtrlToolbar_FindToolbar("[CLASS:CabinetWClass]", "&File")
	MsgBox(4096, "Information", "File Toolbar handle: 0x" & Hex($hToolbar))

EndFunc   ;==>_Main
