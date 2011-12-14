#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>

$Debug_S = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hSlider

	; 创建 GUI
	GUICreate("Slider Get Thumb Length", 400, 296)
	$hSlider = GUICtrlCreateSlider(2, 2, 396, 25, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_FIXEDLENGTH))
	GUISetState()

	; 获取滑块长度
	MsgBox(4160, "Information", "Thumb Length: " & _GUICtrlSlider_GetThumbLength($hSlider))

	; 设置滑块长度
	_GUICtrlSlider_SetThumbLength($hSlider, 10)

	; 获取滑块长度
	MsgBox(4160, "Information", "Thumb Length: " & _GUICtrlSlider_GetThumbLength($hSlider))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
