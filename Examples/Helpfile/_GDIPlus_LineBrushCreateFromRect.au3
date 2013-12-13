#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $tRectF

	$hGUI = GUICreate("GDI+", 420, 320)
	GUISetState()

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsClear($hGraphic, 0xFF000000)

	$tRectF = _GDIPlus_RectFCreate(10, 10, 400, 300)
	$hBrush = _GDIPlus_LineBrushCreateFromRect($tRectF, 0xFF000000, 0xFFFFFFFF, 2)
	_GDIPlus_LineBrushSetSigmaBlend($hBrush, 1)

	_GDIPlus_GraphicsFillRect($hGraphic, 10, 10, 400, 300, $hBrush)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
