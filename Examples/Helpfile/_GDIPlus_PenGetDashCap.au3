#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

_Main()

Func _Main()
	Local $hGUI, $hGraphic, $hPen

	; 创建 GUI
	$hGUI = GUICreate("GDI+", 400, 300)
	GUISetState()

	; 创建资源
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hPen = _GDIPlus_PenCreate(0xFF000000, 8)
	_GDIPlus_PenSetDashStyle($hPen, $GDIP_DASHSTYLEDASHDOT)
	_GDIPlus_PenSetDashCap($hPen, $GDIP_DASHCAPTRIANGLE)

	; 显示笔短划线帽
	MsgBox(4096, "信息", "Pen dash cap: " & _GDIPlus_PenGetDashCap($hPen))

	; 描绘线条
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 150, 390, 150, $hPen)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清理资源
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main
