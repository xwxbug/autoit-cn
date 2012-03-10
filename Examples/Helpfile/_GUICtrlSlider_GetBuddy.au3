#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>

$Debug_S = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hInput, $hInput2, $hSlider

	; 创建 GUI
	GUICreate("Slider Get Buddy", 400, 296)
	$hSlider = GUICtrlCreateSlider(95, 2, 205, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	$hInput = GUICtrlCreateInput("0", 2, 25, 90, 20)
	$hInput2 = GUICtrlCreateInput("0", 2, 25, 90, 20)
	GUISetState()

	; Set buddy to left
	_GUICtrlSlider_SetBuddy($hSlider, True, $hInput)
	; Set buddy to right
	_GUICtrlSlider_SetBuddy($hSlider, False, $hInput2)

	; Get Buddy from the left
	MsgBox(4160, "Information", "Buddy Handle: " & _GUICtrlSlider_GetBuddy($hSlider, True))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
