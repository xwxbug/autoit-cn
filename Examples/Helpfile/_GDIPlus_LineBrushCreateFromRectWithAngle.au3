#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $tRectF, $hPen, $fAngle

	$hGUI = GUICreate("GDI+", 830, 340)
	GUISetState()

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$fAngle = 45

	$tRectF = _GDIPlus_RectFCreate(10, 10, 400, 300)
	$hBrush = _GDIPlus_LineBrushCreateFromRectWithAngle($tRectF, 0xFF000000, 0xFFFFFFFF, $fAngle, False)
	_GDIPlus_LineBrushSetSigmaBlend($hBrush, 1)
	_GDIPlus_GraphicsFillRect($hGraphic, 10, 10, 400, 300, $hBrush)

	_GDIPlus_BrushDispose($hBrush)

	$tRectF = _GDIPlus_RectFCreate(420, 10, 400, 300)
	$hBrush = _GDIPlus_LineBrushCreateFromRectWithAngle($tRectF, 0xFF000000, 0xFFFFFFFF, $fAngle, True)
	_GDIPlus_LineBrushSetSigmaBlend($hBrush, 1)
	_GDIPlus_GraphicsFillRect($hGraphic, 420, 10, 400, 300, $hBrush)




	$hPen = _GDIPlus_PenCreate(0x6F00007F, 2)
	$fAngle *= 0.01745
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 10, 10 + Cos($fAngle) * 300, 10 + Sin($fAngle) * 300, $hPen)
	_GDIPlus_GraphicsDrawString($hGraphic, "$bIsAngleScalable = False", 10, 320)

	$fAngle = (400 / 300) * ATan($fAngle)
	_GDIPlus_GraphicsDrawLine($hGraphic, 420, 10, 420 + Cos($fAngle) * 300, 10 + Sin($fAngle) * 300, $hPen)
	_GDIPlus_GraphicsDrawString($hGraphic, "IsAngleScalable = True", 420, 320)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
