#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

_Main()

Func _Main()
	Local $hGUI, $hGraphic

	; 创建 GUI
	$hGUI = GUICreate("GDI+", 400, 300)
	GUISetState()

	; 描绘弧形
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsDrawArc($hGraphic, 160, 100, 10, 10, 180, 360)
	_GDIPlus_GraphicsDrawArc($hGraphic, 180, 100, 10, 10, 180, 360)
	_GDIPlus_GraphicsDrawArc($hGraphic, 160, 104, 30, 30, 160, -140)
	_GDIPlus_GraphicsDrawArc($hGraphic, 140, 80, 70, 70, 180, 360)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清理资源
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main
