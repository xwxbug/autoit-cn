#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.2.8.1
	Author:         David Nuttall

	Script Function:
	Base script to show functionality of Debug functions.

#ce ----------------------------------------------------------------------------

#include <Debug.au3>

_DebugSetup("Check Excel", True) ; 开始显示调试环境
For $i = 1 To 4
	WinActivate("Microsoft Excel")
	; 与 Excel 交互
	Send("{Down}")
	_DebugOut("Moved Mouse Down") ; 强制控制调试的记事本窗口
Next
