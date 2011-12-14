#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>

$Debug_S = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hSlider

	; 创建 GUI
	GUICreate("Slider Get Unicode Format", 400, 296)
	$hSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState()

	; 获取 Unicode 格式
	MsgBox(4160, "Information", "Unicode Format: " & _GUICtrlSlider_GetUnicodeFormat($hSlider))

	; 设置 Unicode 格式
	MsgBox(4160, "Information", "Previous Unicode Format: " & _GUICtrlSlider_SetUnicodeFormat($hSlider, False))

	; 获取 Unicode 格式
	MsgBox(4160, "Information", "Unicode Format: " & _GUICtrlSlider_GetUnicodeFormat($hSlider))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
