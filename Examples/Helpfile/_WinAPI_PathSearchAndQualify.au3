#include  <GuiConstantsEx.au3>
#include  <WinApiEx.au3>
#include  <WindowsConstants.au3>

Global $iMemo
Global Const $sPath1 = ' C:\\Test\\ '
Global Const $sPath2 = ' C:/Test/Test.txt '
Global Const $sPath3 = ' Notepad.exe '

_Main()

Func _Main()
	Local $hGUI, $aDisk

	; 创建界面
	$hGUI = GUICreate("Qualified Path", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 获取格式化的路径
	MemoWrite($sPath1 & ' =>' & _WinAPI_PathSearchAndQualify($sPath1) & @CR)
	MemoWrite($sPath2 & ' =>' & _WinAPI_PathSearchAndQualify($sPath2) & @CR)
	MemoWrite($sPath3 & ' =>' & _WinAPI_PathSearchAndQualify($sPath3) & @CR)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

