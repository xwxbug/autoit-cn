
#include  <GuiConstantsEx.au3>
#include  <GuiStatusBar.au3>
#include  <WinAPI.au3>

Opt('MustDeclareVars', 1)

$Debug_SB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()

	Local $hGUI, $hStatus
	Local $aParts[3] = [75, 150, -1]

	; 创建界面
	$hGUI = GUICreate("(示例 1) StatusBar Set Min Height", 400, 300)
	$hStatus = _GUICtrlStatusBar_Create($hGUI)
	GUISetState()


	; 设置部分
	_GUICtrlStatusBar_SetParts($hStatus, $aParts)
	_GUICtrlStatusBar_SetText($hStatus, "Part 1")
	_GUICtrlStatusBar_SetText($hStatus, "Part 2", 1)

	; 设置最小高度
	_GUICtrlStatusBar_SetMinHeight($hStatus, 30)

	; 循环至用户退出
	Do

	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main


