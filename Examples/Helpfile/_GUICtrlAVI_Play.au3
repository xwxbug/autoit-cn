#include <GuiConstantsEx.au3>
#include <GuiAVI.au3>

Opt('MustDeclareVars ', 1)

$Debug_AVI = False ; 检查传递给AVI函数的类名, 设置为真并设置另一控件句柄观察其工作

Global $hAVI

_Example_Internal()
_Example_External()

Func _Example_Internal()
	Local $hGUI, $btn_start, $btn_stop

	; 创建界面
	$hGUI = GUICreate(" (Internal) AVI Play ", 300, 200)
	$hAVI = GUICtrlCreateAvi(@SystemDir & "\shell32.dll ", 160, 10, 10)
	$btn_start = GUICtrlCreateButton(" start ", 50, 150, 70, 22)
	$btn_stop = GUICtrlCreateButton(" stop ", 150, 150, 70, 22)
	GUISetState()

	; 循环至用户退出
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $btn_start
				; 播放部分的AVI片段
				_GUICtrlAVI_Play($hAVI)
			Case $btn_stop
				; 停止AVI片段
				_GUICtrlAVI_Stop($hAVI)
		EndSwitch
	WEnd

	; 关闭AVI片段
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()
endfunc   ;==>_Example_Internal

Func _Example_External()
	Local $hGUI, $btn_start, $btn_stop

	; 创建界面
	$hGUI = GUICreate("(External) AVI Play", 300, 200)
	$hAVI = _GUICtrlAVI_Create($hGUI, @SystemDir & "\Shell32.dll", 160, 10, 10)
	$btn_start = GUICtrlCreateButton("start", 50, 150, 70, 22)
	$btn_stop = GUICtrlCreateButton("stop", 150, 150, 70, 22)
	GUISetState()

	; 循环至用户退出
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $btn_start
				; 播放部分的AVI片段
				_GUICtrlAVI_Play($hAVI)
			Case $btn_stop
				; 停止AVI片段
				_GUICtrlAVI_Stop($hAVI)
		EndSwitch
	WEnd

	; 关闭AVI片段
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()
endfunc   ;==>_Example_External

