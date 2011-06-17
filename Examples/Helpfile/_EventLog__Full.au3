#include <GuiConstantsEx.au3>
#include <EventLog.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hEventLog

	; 创建 GUI
	GUICreate("EventLog", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 300, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	$hEventLog = _EventLog__Open("", "Application")
	MemoWrite("Log full ........: " & _EventLog__Full($hEventLog))
	MemoWrite("Log record count : " & _EventLog__Count($hEventLog))
	MemoWrite("Log oldest record: " & _EventLog__Oldest($hEventLog))
	_EventLog__Close($hEventLog)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
