#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hBrush1, $hBrush2

	; 创建 GUI
	GUICreate("GDI+", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 创建画刷
	_GDIPlus_Startup()
	$hBrush1 = _GDIPlus_BrushCreateSolid()
	$hBrush2 = _GDIPlus_BrushClone($hBrush1)

	; 显示画刷信息
	MemoWrite("Brush 1 handle : 0x" & Hex($hBrush1))
	MemoWrite("Brush 1 type ..: " & _GDIPlus_BrushGetType($hBrush1))
	MemoWrite("Brush 2 handle : 0x" & Hex($hBrush2))
	MemoWrite("Brush 2 type ..: " & _GDIPlus_BrushGetType($hBrush2))

	; 清理资源
	_GDIPlus_BrushDispose($hBrush2)
	_GDIPlus_BrushDispose($hBrush1)
	_GDIPlus_Shutdown()

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage = '')
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
