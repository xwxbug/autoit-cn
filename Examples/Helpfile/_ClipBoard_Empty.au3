#include <GUIConstantsEx.au3>
#include <Clipboard.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" Clipboard ", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 打开剪贴板
	If Not _ClipBoard_Open($hGUI) Then _WinAPI_ShowError(" _ClipBoard_Open failed ")

	ShowData($hGUI)

	; 清空剪贴板
	If Not _ClipBoard_Empty() Then _WinAPI_ShowError(" _ClipBoard_Empty failed ")

	; 关闭剪贴板
	_ClipBoard_Close()

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

; 显示剪贴板统计量
Func ShowData($hGUI)
	MemoWrite(" GUI handle ............:" & $hGUI)
	MemoWrite(" Clipboard owner .......:" & _ClipBoard_GetOwner())
	MemoWrite(" Clipboard open window .:" & _ClipBoard_GetOpenWindow())
	MemoWrite(" Clipboard sequence ....:" & _ClipBoard_GetSequenceNumber())
	MemoWrite()
endfunc   ;==>ShowData

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

