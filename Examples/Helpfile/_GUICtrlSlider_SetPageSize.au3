#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>

$Debug_S = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hSlider

	; 创建 GUI
	GUICreate("Slider Set Page Size", 400, 296)
	$hSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState()

	; Get Page Size
	MsgBox(4160, "信息", "Page Size: " & _GUICtrlSlider_GetPageSize($hSlider))

	; Set Page Size
	_GUICtrlSlider_SetPageSize($hSlider, 4)

	; Get Page Size
	MsgBox(4160, "信息", "Page Size: " & _GUICtrlSlider_GetPageSize($hSlider))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
