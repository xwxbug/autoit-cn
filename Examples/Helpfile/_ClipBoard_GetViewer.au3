#include <GuiConstantsEx.au3>
#include <ClipBoard.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>

Opt('MustDeclareVars ', 1)

Global $iMemo, $hNext = 0

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" Clipboard ", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 初始化剪贴板查看器
	$hNext = _ClipBoard_SetViewer($hGUI)

	GUIRegisterMsg($WM_CHANGECBCHAIN, "WM_CHANGECBCHAIN ")
	GUIRegisterMsg($WM_DRAWCLIPBOARD, "WM_DRAWCLIPBOARD ")

	MemoWrite(" GUI handle ....:" & $hGUI)
	MemoWrite(" Viewer handle .:" & _ClipBoard_GetViewer())

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 关闭剪贴板查看器
	_ClipBoard_ChangeChain($hGUI, $hNext)
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

; 处理$WM_CHANGECBCHAIN消息
Func WM_CHANGECBCHAIN($hWnd, $iMsg, $iwParam, $ilParam)
	; 显示收到的消息
	MemoWrite(" ***** $WM_CHANGECBCHAIN ***** ")

	; 如果下一窗口正在关闭 , 修复剪贴板链
	If $iwParam = $hNext Then
		$hNext = $ilParam
		; 否则将消息传递到下一查看器
	ElseIf $hNext <> 0 Then
		_SendMessage($hNext, $WM_CHANGECBCHAIN, $iwParam, $ilParam, 0, "hwnd ", "hwnd ")
	EndIf
endfunc   ;==>WM_CHANGECBCHAIN

; 处理$WM_DRAWCLIPBOARD消息
Func WM_DRAWCLIPBOARD($hWnd, $iMsg, $iwParam, $ilParam)
	; 显示剪贴板上的任意文本
	MemoWrite( _ClipBoard_GetData())

	; 将消息传递到下一查看器
	If $hNext <> 0 Then _SendMessage($hNext, $WM_DRAWCLIPBOARD, $iwParam, $ilParam)
endfunc   ;==>WM_DRAWCLIPBOARD

