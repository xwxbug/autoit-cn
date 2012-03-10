#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiSlider.au3>

$Debug_S = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

Global $iMemo

_Main()

Func _Main()
	Local $hSlider, $aTics

	; 创建 GUI
	GUICreate("Slider Get Logical Tic Positions", 400, 296)
	$hSlider = GUICtrlCreateSlider(2, 2, 300, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS))
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	$aTics = _GUICtrlSlider_GetLogicalTics($hSlider)
	MemoWrite("Number Tics Excluding 1st and last .....: " & UBound($aTics))
	For $x = 0 To UBound($aTics) - 1
		MemoWrite(StringFormat("(%02d) Logical Tick Position .............: %d", $x, $aTics[$x]))
	Next

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
