#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

$Debug_DTP = False 检查传递给 DTP 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

Global $iMemo

_Main()

Func _Main()
	Local $hGui, $tLOGFONT, $hFont, $hDTP

	; 创建 GUI
	$hGui = GUICreate("DateTimePick Set Month Calendar Font", 400, 300)
	$hDTP = _GUICtrlDTP_Create($hGui, 2, 6, 190)
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 设置显示的格式
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; 创建用于月历控件的新字体
	$tLOGFONT = DllStructCreate($tagLOGFONT)
	DllStructSetData($tLOGFONT, "Height", 13)
	DllStructSetData($tLOGFONT, "Weight", 400)
	DllStructSetData($tLOGFONT, "FaceName", "Verdana")
	$hFont = _WinAPI_CreateFontIndirect($tLOGFONT)
	_GUICtrlDTP_SetMCFont($hDTP, $hFont)

	; 获取月历控件的字体句柄
	MemoWrite("Font Handle: " & "0x" & Hex(_GUICtrlDTP_GetMCFont($hDTP), 6))
	MemoWrite("IsPtr  = " & IsPtr(_GUICtrlDTP_GetMCFont($hDTP)) & " IsHWnd  = " & IsHWnd(_GUICtrlDTP_GetMCFont($hDTP)))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
