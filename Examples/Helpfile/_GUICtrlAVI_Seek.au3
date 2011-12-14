#include <GUIConstantsEx.au3>
#include <GuiAVI.au3>

$Debug_AVI = False ; 检查传递给 AVI 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $hAVI

_Example_Internal()
_Example_External()

Func _Example_Internal()
	; 创建 GUI
	GUICreate("(Internal) AVI Seek", 300, 100)
	$hAVI = GUICtrlCreateAvi(@SystemDir & "\shell32.dll", 160, 10, 10)
	GUISetState()

	; 循环直到用户退出
	Do
		Sleep(100)
		; 查找到 AVI 剪辑中的一个随机帧
		_GUICtrlAVI_Seek($hAVI, Random(1, 30, 1))
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 关闭 AVI 剪辑
	_GUICtrlAVI_Close($hAVI)


	GUIDelete()
EndFunc   ;==>_Example_Internal

Func _Example_External()
	Local $hGUI

	; 创建 GUI
	$hGUI = GUICreate("(External) AVI Seek", 300, 100)
	$hAVI = _GUICtrlAVI_Create($hGUI, @SystemDir & "\Shell32.dll", 160, 10, 10)
	GUISetState()

	; 循环直到用户退出
	Do
		Sleep(100)
		; 查找到 AVI 剪辑中的一个随机帧
		_GUICtrlAVI_Seek($hAVI, Random(1, 30, 1))
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 关闭 AVI 剪辑
	_GUICtrlAVI_Close($hAVI)


	GUIDelete()
EndFunc   ;==>_Example_External
