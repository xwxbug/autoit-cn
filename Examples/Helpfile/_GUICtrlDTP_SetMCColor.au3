#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>
#include <Constants.au3>

$Debug_DTP = False 检查传递给 DTP 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

Global $iMemo

_Main()

Func _Main()
	Local $hDTP

	; 创建 GUI
	GUICreate("DateTimePick Set Month Calendar Color", 400, 300)
	$hDTP = GUICtrlGetHandle(GUICtrlCreateDate("", 2, 6, 190))
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 设置显示的格式
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; 设置月历背景颜色
	_GUICtrlDTP_SetMCColor($hDTP, 2, $CLR_MONEYGREEN)

	; 获取 DTP 颜色
	MemoWrite("Background between months: " & "0x" & Hex(_GUICtrlDTP_GetMCColor($hDTP, 0), 6))
	MemoWrite("Text within months ......: " & "0x" & Hex(_GUICtrlDTP_GetMCColor($hDTP, 1), 6))
	MemoWrite("Title background ........: " & "0x" & Hex(_GUICtrlDTP_GetMCColor($hDTP, 2), 6))
	MemoWrite("Title text ..............: " & "0x" & Hex(_GUICtrlDTP_GetMCColor($hDTP, 3), 6))
	MemoWrite("Background within months : " & "0x" & Hex(_GUICtrlDTP_GetMCColor($hDTP, 4), 6))
	MemoWrite("Header trailing .........: " & "0x" & Hex(_GUICtrlDTP_GetMCColor($hDTP, 5), 6))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
