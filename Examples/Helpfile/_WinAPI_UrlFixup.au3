#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()

	Local $hGUI
	Local $Url[3] = [' http://www.microsoft.com ', 'htps:\\www.microsoft.com ', 'http:www.microsoft.com ']

	; 创建界面
	$hGUI = GUICreate(" _WinAPI_UrlFixup ", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	For $i = 0 To 2
		MemoWrite( StringFormat('%-27s' & _WinAPI_UrlFixup($Url[$i]), $Url[$i]) & @CR)
	Next

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

