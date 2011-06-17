#include <GuiConstantsEx.au3>
#include <Date.au3>
#include <WindowsConstants.au3>

; 由于系统安全性在 Vista 中 Windows API "SetLocalime" 可能被拒绝

Global $iMemo

_Main()

Func _Main()
	Local $tCur, $tNew

	; 创建 GUI
	GUICreate("Time", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 显示当前的本地时间
	$tCur = _Date_Time_GetLocalTime()
	MemoWrite("Current date/time .: " & _Date_Time_SystemTimeToDateTimeStr($tCur))

	; 设置新的本地时间
	$tNew = _Date_Time_EncodeSystemTime(8, 19, @YEAR, 3, 10, 45)
	If Not _Date_Time_SetLocalTime(DllStructGetPtr($tNew)) Then
		MsgBox(4096, "Error", "System clock cannot be SET" & @CRLF & @CRLF & _WinAPI_GetLastErrorMessage())
		Exit
	EndIf
	$tNew = _Date_Time_GetLocalTime()
	MemoWrite("New date/time .....: " & _Date_Time_SystemTimeToDateTimeStr($tNew))

	; 重设本地时间
	_Date_Time_SetLocalTime(DllStructGetPtr($tCur))

	; 显示当前的本地时间
	$tCur = _Date_Time_GetLocalTime()
	MemoWrite("Current date/time .: " & _Date_Time_SystemTimeToDateTimeStr($tCur))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
