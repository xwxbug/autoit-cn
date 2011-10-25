#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Global $iMemo, $hGUI, $aArray, $Drive = 0
Global $tStruct1, $tStruct2, $tStruct3, $Size

_Main()

Func _Main()

	; 创建界面
	$hGUI = GUICreate("_WinAPI_UnionStruct", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	$tStruct1 = DllStructCreate('byte[6]')
	For $i = 1 To 6
		DllStructSetData($tStruct1, 1, $i, $i)
	Next

	$tStruct2 = DllStructCreate('byte[2]')
	For $i = 1 To 2
		DllStructSetData($tStruct2, 1, $i + 6, $i)
	Next

	$tStruct3 = _WinAPI_UnionStruct($tStruct1, $tStruct2)

	$Size = DllStructGetSize($tStruct3)
	For $i = 1 To $Size
		MemoWrite( DllStructGetData($tStruct3, 1, $i))
	Next

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

