#include <GUIConstantsEx.au3>
#include <GuiMonthCal.au3>
#include <WindowsConstants.au3>

$Debug_MC = False ; 检查传递给 MonthCal 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hMonthCal

	; 创建 GUI
	GUICreate("Month Calendar Set Day State", 400, 300)
	$hMonthCal = GUICtrlCreateMonthCal("", 4, 4, -1, -1, BitOR($WS_BORDER, $MCS_DAYSTATE), 0x00000000)

	; 获取我们必须屏蔽的月份数.  正常时此数字将为 3.
	Local $aMasks[_GUICtrlMonthCal_GetMonthRangeSpan($hMonthCal, True)]

	; 让当前月份的第一, 第八和第十六日显示为粗体. 这个的二进制掩码为 1000 0000 1000 0001 或
	; 十六进制中为 0x8081.
	$aMasks[1] = 0x8081
	_GUICtrlMonthCal_SetDayState($hMonthCal, $aMasks)

	GUISetState()

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
