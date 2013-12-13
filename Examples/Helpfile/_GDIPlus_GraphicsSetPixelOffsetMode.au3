#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 600, $iHeight = 600, $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	Global $hGUI = GUICreate("GDI+ example", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $hGUI) ;set GUI background color
	GUISetState()

	;create buffered graphics frame set for smoother gfx object movements
	Global $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	Global $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
	Global $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;sets the graphics object rendering quality (antialiasing)
	Global $hPen = _GDIPlus_PenCreate(0xFFFF8060, 2)
	_GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	Local $aPoints[11][4], $x, $y
	$aPoints[0][0] = 10

	For $y = 0 To 1
		For $x = 1 To 5
			$aPoints[$y * 5 + $x][0] = 100 + 300 * $y + 50 ;x coordinate of the point
			$aPoints[$y * 5 + $x][1] = 150 + $x * 50 ;y coordinate of the point
			$aPoints[$y * 5 + $x][2] = Random(-2, 2) ;x vector of the point
			$aPoints[$y * 5 + $x][3] = Random(-2, 2) ;y vector of the point
		Next
	Next

	Do
		_GDIPlus_GraphicsClear($hGfxCtxt, 0xFF000000 + $iBgColor) ;clear bitmap for repaint
		_GDIPlus_GraphicsDrawClosedCurve2($hGfxCtxt, $aPoints, 1.25, $hPen) ;draw closed curve
		_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0) ;copy bitmap to graphic handle (GUI)
		For $y = 1 To $aPoints[0][0]
			$aPoints[$y][0] += $aPoints[$y][2] ;calculate new x position
			If $aPoints[$y][0] < 0 Or $aPoints[$y][0] > $iWidth Then $aPoints[$y][2] *= -1 ;if vertical border is reached invert x vector
			$aPoints[$y][1] += $aPoints[$y][3] ;calculate new y position
			If $aPoints[$y][1] < 0 Or $aPoints[$y][1] > $iHeight Then $aPoints[$y][3] *= -1 ;if horizontal border is reached invert y vector
		Next
	Until Not Sleep(30) ;sleep 30 ms to avoid high cpu usage
EndFunc   ;==>Example

Func _Exit()
	;cleanup GDI+ resources
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGfxCtxt)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>_Exit
