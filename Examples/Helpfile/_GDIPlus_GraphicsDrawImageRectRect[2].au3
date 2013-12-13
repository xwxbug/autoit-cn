#include <GDIPlus.au3>
#include <ScreenCapture.au3>
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
	Local Const $iW = 300, $iH = 300
	Local $hHBmp = _ScreenCapture_Capture("", 4, @DesktopHeight - $iH, $iW + 4, @DesktopHeight) ;create a GDI bitmap by capturing an area on desktop
	Global $hBmp = _GDIPlus_BitmapCreateFromHBITMAP($hHBmp) ;convert GDI to GDI+ bitmap
	_WinAPI_DeleteObject($hHBmp) ;release GDI bitmap resource because not needed anymore
	Local $iVectorX = Random(1.5, 2.5), $iVectorY = Random(1.5, 2.5) ;define x and y vector
	Local $iX = 0.0, $iY = 0.0 ;define start coordinate

	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

	Do
		_GDIPlus_GraphicsClear($hGfxCtxt, 0xFF000000 + $iBgColor) ;clear bitmap for repaint
		_GDIPlus_GraphicsDrawImageRectRect($hGfxCtxt, $hBmp, 0, 0, $iW, $iH, $iX, $iY, $iW / 2, $iH) ;draw bitmap to backbuffer by halving the width
		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight) ;copy drawn bitmap to graphics handle (GUI)
		$iX += $iVectorX ;add x vector to current x position
		$iY += $iVectorY ;add y vector to current y position
		If $iX < 0 Or $iX > ($iWidth - $iW / 2) Then $iVectorX *= -1 ;when x border is reached reverse x vector
		If $iY < 0 Or $iY > ($iHeight - $iH) Then $iVectorY *= -1 ;when y border is reached reverse y vector
	Until Not Sleep(20) ;sleep 20 ms to avoid high cpu usage
EndFunc   ;==>Example

Func _Exit()
	;cleanup GDI+ resources
	_GDIPlus_GraphicsDispose($hGfxCtxt)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_BitmapDispose($hBmp)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>_Exit
