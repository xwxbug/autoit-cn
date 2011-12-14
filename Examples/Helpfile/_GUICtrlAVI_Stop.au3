#include <GUIConstantsEx.au3>
#include <GuiAVI.au3>

$Debug_AVI = False ; 检查传递给 AVI 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $hAVI

_Example_Internal()
_Example_External()

Func _Example_Internal()
	Local $btn_start, $btn_stop

	; 创建 GUI
	GUICreate("(Internal) AVI Stop", 300, 200)
	$hAVI = GUICtrlCreateAvi(@SystemDir & "\shell32.dll", 160, 10, 10)
	$btn_start = GUICtrlCreateButton("start", 50, 150, 70, 22)
	$btn_stop = GUICtrlCreateButton("stop", 150, 150, 70, 22)
	GUISetState()

	; 循环直到用户退出
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $btn_start
				; 播放 AVI 剪辑的一部分
				_GUICtrlAVI_Play($hAVI)
			Case $btn_stop
				; 停止 AVI 剪辑
				_GUICtrlAVI_Stop($hAVI)
		EndSwitch
	WEnd

	; 关闭 AVI 剪辑
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()
EndFunc   ;==>_Example_Internal

Func _Example_External()
	Local $hGUI, $btn_start, $btn_stop

	; 创建 GUI
	$hGUI = GUICreate("(External) AVI Stop", 300, 200)
	$hAVI = _GUICtrlAVI_Create($hGUI, @SystemDir & "\Shell32.dll", 160, 10, 10)
	$btn_start = GUICtrlCreateButton("start", 50, 150, 70, 22)
	$btn_stop = GUICtrlCreateButton("stop", 150, 150, 70, 22)
	GUISetState()

	; 循环直到用户退出
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $btn_start
				; 播放 AVI 剪辑的一部分
				_GUICtrlAVI_Play($hAVI)
			Case $btn_stop
				; 停止 AVI 剪辑
				_GUICtrlAVI_Stop($hAVI)
		EndSwitch
	WEnd

	; 关闭 AVI 剪辑
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()
EndFunc   ;==>_Example_External
