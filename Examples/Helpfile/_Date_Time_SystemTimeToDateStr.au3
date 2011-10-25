
#include  <GuiConstantsEx.au3>
#include  <Date.au3>
#include  <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $tDate

	; 创建界面
	$hGUI = GUICreate("Time", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 获取当前系统日期
	$tDate = _Date_Time_GetSystemTime()
	MemoWrite("Current system date .:" & _Date_Time_SystemTimeToDateStr($tDate))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

; 写入memo控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

