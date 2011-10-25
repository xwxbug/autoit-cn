#include <GuiConstantsEx.au3>
#include <EventLog.au3>
#include <WinAPI.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hEventLog, $hGUI, $hEvent, $iResult

	; 创建界面
	$hGUI = GUICreate(" EventLog ", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 300, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 建立事件
	$hEventLog = _EventLog__Open("", "Security ")
	$hEvent = _WinAPI_CreateEvent(0, False, False, "")
	_EventLog__Notify($hEventLog, $hEvent)

	; 等待发生新事件
	MemoWrite(" Waiting for new event ")
	$iResult = _WinAPI_WaitForSingleObject($hEvent)
	_WinAPI_CloseHandle($hEvent)
	_EventLog__Close($hEventLog)
	; 写入结果
	If $iResult = -1 Then
		MemoWrite(" Wait failed ")
	Else
		MemoWrite(" New event occurred ")
	EndIf

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

; 写入memo控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

