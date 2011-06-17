#include <GuiConstantsEx.au3>
#include <Date.au3>
#include <WindowsConstants.au3>

; 由于系统安全性,在 Vista 中 Windows API "SetTimeZoneInformation" 可能被拒绝

Global $iMemo

_Main()

Func _Main()
	Local $aOld, $aNew

	; 创建 GUI
	GUICreate("Time", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 显示当前的时区信息
	$aOld = _Date_Time_GetTimeZoneInformation()
	ShowTimeZoneInformation($aOld, "Current")

	; 设置新的时区信息
	If Not _Date_Time_SetTimeZoneInformation($aOld[1], "A3L CST", $aOld[3], $aOld[4], "A3L CDT", $aOld[6], $aOld[7]) Then
		MsgBox(4096, "Error", "System timezone cannot be SET" & @CRLF & @CRLF & _WinAPI_GetLastErrorMessage())
		Exit
	EndIf

	; 显示新的时区信息
	$aNew = _Date_Time_GetTimeZoneInformation()
	ShowTimeZoneInformation($aNew, "New")

	; 重设为原来的时区信息
	_Date_Time_SetTimeZoneInformation($aOld[1], $aOld[2], $aOld[3], $aOld[4], $aOld[5], $aOld[6], $aOld[7])

	; 显示当前的时区信息
	$aOld = _Date_Time_GetTimeZoneInformation()
	ShowTimeZoneInformation($aOld, "Reset")

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

; 显示时区信息
Func ShowTimeZoneInformation(ByRef $aInfo, $comment)
	MemoWrite("******************* " & $comment & " *******************")
	MemoWrite("Result ............: " & $aInfo[0])
	MemoWrite("Current bias ......: " & $aInfo[1])
	MemoWrite("Standard name .....: " & $aInfo[2])
	MemoWrite("Standard date/time : " & _Date_Time_SystemTimeToDateTimeStr($aInfo[3]))
	MemoWrite("Standard bias......: " & $aInfo[4])
	MemoWrite("Daylight name .....: " & $aInfo[5])
	MemoWrite("Daylight date/time : " & _Date_Time_SystemTimeToDateTimeStr($aInfo[6]))
	MemoWrite("Daylight bias......: " & $aInfo[7])
EndFunc   ;==>ShowTimeZoneInformation
