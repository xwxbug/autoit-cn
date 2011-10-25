#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()

	Local $hGUI
	Local $Path[4] = [' C:\Path\File[5].txt ', 'C:\Path\File[12] ', 'C:\Path\File.txt ', 'C:\Path\[3].txt ']

	; 创建界面
	$hGUI = GUICreate(" _WinAPI_PathUndecorate ", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	For $i = 0 To 3
		MemoWrite( StringFormat('%-22s' & _WinAPI_PathUndecorate($Path[$i]), $Path[$i]) & @CR)
	Next

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

