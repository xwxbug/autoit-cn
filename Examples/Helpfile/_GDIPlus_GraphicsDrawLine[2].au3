#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	_GDIPlus_Startup() ;initialize GDI+
	Local $iW = 600, $iH = 600
	Local Const $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	Global $hGUI = GUICreate("GDI+ example", $iW, $iH) ;create a test GUI
	GUISetBkColor($iBgColor, $hGUI) ;set GUI background color
	GUISetState()

	;create buffered graphics frame set for smoother gfx object movements
	Global $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	Global $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	Global $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;sets the graphics object rendering quality (antialiasing)
	Global $hPen = _GDIPlus_PenCreate(0xFF8080FF, 2)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

	Local Const $iDeg = ACos(-1) / 180, $iRadius = 300, $iWidth = $iW / 2, $iHeight = $iH / 2
	Local $iAngle = 0

	Do
		_GDIPlus_GraphicsClear($hGfxCtxt, 0xFF000000 + $iBgColor) ;clear bitmap for repaint
		_GDIPlus_GraphicsDrawEllipse($hGfxCtxt, $iWidth - $iRadius / 2 + $iRadius / 18, $iHeight - $iRadius / 2 + $iRadius / 18, $iRadius - $iRadius / 9, $iRadius - $iRadius / 9, $hPen) ;draw ellipse
		_GDIPlus_GraphicsDrawLine($hGfxCtxt, $iWidth + Cos($iAngle * $iDeg) * $iRadius, $iHeight + Sin($iAngle * $iDeg) * $iRadius, _ ;draw line
				$iWidth + Cos($iAngle * $iDeg + 180) * $iRadius, $iHeight + Sin($iAngle * $iDeg + 180) * $iRadius, $hPen)

		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iW, $iH) ;copy drawn bitmap to graphics handle (GUI)
		$iAngle += 0.5
	Until Not Sleep(20) ;sleep 20 ms to avoid high cpu usage
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
