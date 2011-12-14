#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>

$Debug_S = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hInput, $hInput2, $hSlider

	; 创建 GUI
	GUICreate("Slider Set Buddy", 400, 296)
	$hSlider = GUICtrlCreateSlider(95, 2, 205, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	$hInput = GUICtrlCreateInput("0", 2, 25, 90, 20)
	$hInput2 = GUICtrlCreateInput("0", 2, 25, 90, 20)
	GUISetState()

	; 设置伙伴控件到左边
	_GUICtrlSlider_SetBuddy($hSlider, True, $hInput)
	; 设置伙伴控件到右边
	_GUICtrlSlider_SetBuddy($hSlider, False, $hInput2)

	; 获取左边的伙伴控件
	MsgBox(4160, "Information", "Buddy Handle: " & _GUICtrlSlider_GetBuddy($hSlider, True))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
