#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	Local Const $iW = 400, $iH = 400
	Global $hGUI, $hGraphics, $hBmp_Buffer, $hGfx_Buffer, $hPen, $hPen2, $hPath, $hPath2

	$hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	GUISetState()

	_GDIPlus_Startup()
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	$hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	$hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)
	_GDIPlus_GraphicsSetSmoothingMode($hGfx_Buffer, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)

	$hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)
	$hPen2 = _GDIPlus_PenCreate(0xFFFFDD00, 3)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	Global $aPoints[201][2] = [[200]], $iRadius = 0
	For $i = 1 To $aPoints[0][0]
		$aPoints[$i][0] = Cos($i / 3.14) * $iRadius + $iW / 2
		$aPoints[$i][1] = Sin($i / 3.14) * $iRadius + $iH / 2
		$iRadius += 1
	Next

	_GDIPlus_PathAddCurve($hPath, $aPoints)

	$hPath2 = _GDIPlus_PathCreate() ;Create new path object
	Global $iOff = 1, $iNum = 4
	While Sleep(20)
		_GDIPlus_PathReset($hPath2)
		_GDIPlus_PathAddCurve3($hPath2, $aPoints, $iOff, $iNum)

		$iOff += 1
		If $iOff > $aPoints[0][0] - $iNum Then $iOff = 1

		_GDIPlus_GraphicsClear($hGfx_Buffer, 0xFF000000)
		_GDIPlus_GraphicsDrawPath($hGfx_Buffer, $hPath, $hPen) ;Draw path to graphics handle (GUI)
		_GDIPlus_GraphicsDrawPath($hGfx_Buffer, $hPath2, $hPen2) ;Draw path to graphics handle (GUI)
		_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)
	WEnd
EndFunc   ;==>Example

Func _Exit()
	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PathDispose($hPath2)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_PenDispose($hPen2)
	_GDIPlus_GraphicsDispose($hGfx_Buffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>_Exit
