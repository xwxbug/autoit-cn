#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

$Debug_DTP = False 检查传递给 DTP 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

Global $iMemo, $aRange[14] = [True, @YEAR, 1, 1, 21, 45, 32, True, @YEAR, 12, 31, 23, 59, 59]

_Main()

Func _Main()
	Local $hDTP

	; 创建 GUI
	GUICreate("DateTimePick Get Range", 400, 300)
	$hDTP = GUICtrlGetHandle(GUICtrlCreateDate("", 2, 6, 190))
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 设置显示的格式
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; 设置日期范围
	_GUICtrlDTP_SetRange($hDTP, $aRange)

	; 显示日期范围
	$aRange = _GUICtrlDTP_GetRange($hDTP)
	MemoWrite("Minimum date: " & GetDateStr())
	MemoWrite("Maximum date: " & GetDateStr(7))
	MemoWrite("Minimum time: " & GetTimeStr(4))
	MemoWrite("Maximum time: " & GetTimeStr(11))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

; 返回日期部分
Func GetDateStr($iOff = 0)
	Return StringFormat("%02d/%02d/%04d", $aRange[$iOff + 2], $aRange[$iOff + 3], $aRange[$iOff + 1])
EndFunc   ;==>GetDateStr

; 返回时间部分
Func GetTimeStr($iOff = 0)
	Return StringFormat("%02d:%02d:%02d", $aRange[$iOff], $aRange[$iOff + 1], $aRange[$iOff + 2])
EndFunc   ;==>GetTimeStr

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
