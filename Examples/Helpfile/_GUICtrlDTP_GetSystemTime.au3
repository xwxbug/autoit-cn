#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

$Debug_DTP = False 检查传递给 DTP 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

Global $iMemo, $tRange, $aDate

_Main()

Func _Main()
	Local $hDTP, $a_Date[7] = [False, @YEAR, 8, 19, 21, 57, 34]

	; 创建 GUI
	GUICreate("DateTimePick Get System Time", 400, 300)
	$hDTP = GUICtrlGetHandle(GUICtrlCreateDate("", 2, 6, 190))
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 设置显示的格式
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; 设置系统时间
	_GUICtrlDTP_SetSystemTime($hDTP, $a_Date)

	; 显示系统时间
	$aDate = _GUICtrlDTP_GetSystemTime($hDTP)
	MemoWrite("Current date: " & GetDateStr())
	MemoWrite("Current time: " & GetTimeStr())

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

; 返回日期部分
Func GetDateStr()
	Return StringFormat("%02d/%02d/%04d", $aDate[1], $aDate[2], $aDate[0])
EndFunc   ;==>GetDateStr

; 返回时间部分
Func GetTimeStr()
	Return StringFormat("%02d:%02d:%02d", $aDate[3], $aDate[4], $aDate[5])
EndFunc   ;==>GetTimeStr

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
