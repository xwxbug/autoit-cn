#include <GuiConstantsEx.au3>
#include <ClipBoard.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI

	; 创建 GUI
	$hGUI = GUICreate("Clipboard", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 打开剪贴板
	If Not _ClipBoard_Open($hGUI) Then _WinAPI_ShowError("_ClipBoard_Open failed")

	; 显示可用的剪贴板格式
	MemoWrite("Clipboard formats ..: " & _ClipBoard_CountFormats())

	; 清空剪贴板
	If Not _ClipBoard_Empty() Then _WinAPI_ShowError("_ClipBoard_Empty failed")

	; 显示可用的剪贴板格式
	MemoWrite("Clipboard formats ..: " & _ClipBoard_CountFormats())

	; 关闭剪贴板
	_ClipBoard_Close()

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; 写入消息到 memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite