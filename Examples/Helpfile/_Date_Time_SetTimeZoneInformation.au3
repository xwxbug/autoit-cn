#include <GuiConstantsEx.au3>
#include <Date.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $aOld, $aNew

	; Create GUI
	$hGUI = GUICreate("Time", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; Show current time zone information
	$aOld = _Date_Time_GetTimeZoneInformation ()
	ShowTimeZoneInformation($aOld)

	; Set new time zone information
	_Date_Time_SetTimeZoneInformation ($aOld[1], "A3L CST", $aOld[3], $aOld[4], "A3L CDT", $aOld[6], $aOld[7])

	; Show new time zone information
	$aNew = _Date_Time_GetTimeZoneInformation ()
	ShowTimeZoneInformation($aNew)

	; Reset original time zone information
	_Date_Time_SetTimeZoneInformation ($aOld[1], $aOld[2], $aOld[3], $aOld[4], $aOld[5], $aOld[6], $aOld[7])

	; Show current time zone information
	$aOld = _Date_Time_GetTimeZoneInformation ()
	ShowTimeZoneInformation($aOld)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
EndFunc   ;==>_Main

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

; Show time zone information
Func ShowTimeZoneInformation(ByRef $aInfo)
	MemoWrite("Result ............: " & $aInfo[0])
	MemoWrite("Current bias ......: " & $aInfo[1])
	MemoWrite("Standard name .....: " & $aInfo[2])
	MemoWrite("Standard date/time : " & _Date_Time_SystemTimeToDateTimeStr ($aInfo[3]))
	MemoWrite("Standard bias......: " & $aInfo[4])
	MemoWrite("Daylight name .....: " & $aInfo[5])
	MemoWrite("Daylight date/time : " & _Date_Time_SystemTimeToDateTimeStr ($aInfo[6]))
	MemoWrite("Daylight bias......: " & $aInfo[7])
EndFunc   ;==>ShowTimeZoneInformation