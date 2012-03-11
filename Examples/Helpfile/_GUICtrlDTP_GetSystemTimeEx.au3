#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

$Debug_DTP = False 检查传递给 DTP 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

Global $iMemo, $tDate

_Main()

Func _Main()
	Local $hDTP

	; 创建 GUI
	GUICreate("DateTimePick Get System TimeEx", 400, 300)
	$hDTP = GUICtrlGetHandle(GUICtrlCreateDate("", 2, 6, 190))
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 设置显示的格式
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; 设置系统时间
	$tDate = DllStructCreate($tagSYSTEMTIME)
	DllStructSetData($tDate, "Year", @YEAR)
	DllStructSetData($tDate, "Month", 8)
	DllStructSetData($tDate, "Day", 19)
	DllStructSetData($tDate, "Hour", 21)
	DllStructSetData($tDate, "Minute", 57)
	DllStructSetData($tDate, "Second", 34)
	_GUICtrlDTP_SetSystemTimeEx($hDTP, $tDate)

	; 显示系统时间
	$tDate = _GUICtrlDTP_GetSystemTimeEx($hDTP)
	MemoWrite("Current date: " & GetDateStr())
	MemoWrite("Current time: " & GetTimeStr())

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

; 返回日期部分
Func GetDateStr()
	Return StringFormat("%02d/%02d/%04d", DllStructGetData($tDate, "Month"), DllStructGetData($tDate, "Day"), DllStructGetData($tDate, "Year"))
EndFunc   ;==>GetDateStr

; 返回时间部分
Func GetTimeStr()
	Return StringFormat("%02d:%02d:%02d", DllStructGetData($tDate, "Hour"), DllStructGetData($tDate, "Minute"), DllStructGetData($tDate, "Second"))
EndFunc   ;==>GetTimeStr

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
