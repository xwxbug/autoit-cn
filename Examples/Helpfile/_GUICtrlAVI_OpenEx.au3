#include <GuiConstantsEx.au3>
#include <GuiAVI.au3>

Opt('MustDeclareVars ', 1)

$Debug_AVI = False ; 检查传递给AVI函数的类名, 设置为真并设置另一控件句柄观察其工作

Global $hAVI

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" (External) AVI OpenEx ", 300, 100)
	$hAVI = _GUICtrlAVI_Create($hGUI, "", -1, 10, 10)
	GUISetState()

	; 播放示例AutoIt影片
	_GUICtrlAVI_OpenEx($hAVI, @SystemDir & " \Shell32.dll ", 150)

	; 播放示例AutoIt影片
	_GUICtrlAVI_Play($hAVI)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 关闭AVI片段
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()
endfunc   ;==>_Main

