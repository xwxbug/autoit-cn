#include <GUIConstantsEx.au3>
#include <Clipboard.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $iFormat, $iCount

	; 创建界面
	$hGUI = GUICreate(" Clipboard ", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 打开剪贴板
	If Not _ClipBoard_Open($hGUI) Then _WinAPI_ShowError(" _ClipBoard_Open failed ")

	; 显示可用的剪贴板格式
	MemoWrite(" Clipboard formats ..:" & _ClipBoard_CountFormats())

	; 枚举剪贴板格式
	Do
		$iFormat = _ClipBoard_EnumFormats($iFormat)
		If $iFormat <> 0 Then
			$iCount += 1
			MemoWrite(" Clipboard format" & $iCount & " .:" & _ClipBoard_FormatStr($iFormat))
		EndIf
	Until $iFormat = 0

	; 关闭剪贴板
	_ClipBoard_Close()

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

