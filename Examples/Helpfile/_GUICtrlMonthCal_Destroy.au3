
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiMonthCal.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_MC = False ; 检查传递给MonthCal函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hGUI, $HandleBefore, $hMonthCal

	; 创建界面
	$hGUI = GUICreate("Month Calendar Destroy", 400, 300)

	$hMonthCal = _GUICtrlMonthCal_Create($hGUI, 4, 4, $WS_BORDER)

	GUISetState()

	$HandleBefore = $hMonthCal

	MsgBox(4160, "Information", "Destroying the Control for Handle:" & $hMonthCal)

	MsgBox(4160, "Information", "Control Destroyed:" & _GUICtrlMonthCal_Destroy($hMonthCal) & @LF & _
			"Handel Before Destroy:" & $HandleBefore & @LF & _
			"Handle After Destroy:" & $hMonthCal)


	; 循环至用户退出
	Do

	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

