
#include  <GuiConstantsEx.au3>
#include  <Date.au3>
#include  <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $sDate

	; 创建界面
	$hGUI = GUICreate("Time", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 显示FAT日期/时间
	$sDate = _Date_Time_DOSDateTimeToStr(0x3621, 0x944a) ; 01/01/2007 18:34:20
	MemoWrite("FAT date/time .:" & $sDate)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

; 向memo控件写入文本
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite


