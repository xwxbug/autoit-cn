#include <GuiConstantsEx.au3>
#include <ClipBoard.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>

Global $iMemo, $hNext = 0

_Main()

Func _Main()
	Local $hGUI

	; 创建 GUI
	$hGUI = GUICreate("Clipboard", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 初始化剪贴板查看器
	$hNext = _ClipBoard_SetViewer($hGUI)

	GUIRegisterMsg($WM_CHANGECBCHAIN, "WM_CHANGECBCHAIN")
	GUIRegisterMsg($WM_DRAWCLIPBOARD, "WM_DRAWCLIPBOARD")

	MemoWrite("GUI handle ....: " & $hGUI)
	MemoWrite("Viewer handle .: " & _ClipBoard_GetViewer())

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 关闭剪贴板查看器
	_ClipBoard_ChangeChain($hGUI, $hNext)
EndFunc   ;==>_Main

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

; 处理 $WM_CHANGECBCHAIN 消息
Func WM_CHANGECBCHAIN($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg
	; Show that message was received
	MemoWrite("***** $WM_CHANGECBCHAIN *****")

	; If the next window is closing, repair the chain
	If $iwParam = $hNext Then
		$hNext = $ilParam
		; Otherwise pass the message to the next viewer
	ElseIf $hNext <> 0 Then
		_SendMessage($hNext, $WM_CHANGECBCHAIN, $iwParam, $ilParam, 0, "hwnd", "hwnd")
	EndIf
EndFunc   ;==>WM_CHANGECBCHAIN

; 处理 $WM_DRAWCLIPBOARD 消息
Func WM_DRAWCLIPBOARD($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg
	; Display any text on clipboard
	MemoWrite(_ClipBoard_GetData())

	; 传递消息到下一个查看器
	If $hNext <> 0 Then _SendMessage($hNext, $WM_DRAWCLIPBOARD, $iwParam, $ilParam)
EndFunc   ;==>WM_DRAWCLIPBOARD
