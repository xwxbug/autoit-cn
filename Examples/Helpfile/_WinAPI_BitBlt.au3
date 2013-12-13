#include <WinAPI.au3>
#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 600, $iHeight = 600, $iBgColor = 0x202020 ;$iBGColor format RRGGBB

	Global $hGUI = GUICreate("GDI+ example", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $hGUI) ;set GUI background color
	GUISetState()

	;create a faster buffered graphics frame set for smoother gfx object movements
	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight) ;create an empty bitmap
	Global $hHBITMAP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap) ;convert GDI+ bitmap to GDI bitmap
	_GDIPlus_BitmapDispose($hBitmap) ;delete GDI+ bitmap because not needed anymore

	Global $hDC = _WinAPI_GetDC($hGUI) ;get device context from GUI
	Global $hDC_Backbuffer = _WinAPI_CreateCompatibleDC($hDC) ;creates a memory device context compatible with the specified device
	Global $DC_Obj = _WinAPI_SelectObject($hDC_Backbuffer, $hHBITMAP) ;selects an object into the specified device context
	Global $hGfxCtxt = _GDIPlus_GraphicsCreateFromHDC($hDC_Backbuffer) ;create a graphics object from a device context (DC)
	_GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;set smoothing mode (8 X 4 box filter)
	_GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)

	Global $hPen = _GDIPlus_PenCreate() ;create a pen object

	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

	Local Const $iDeg = ACos(-1) / 180 ;ACos(-1) is nearly pi
	Local $iX_Center = $iWidth / 2, $iY_Center = $iHeight / 2, $iXPos, $iYPos, $iAngle = 0, $iRound = 0
	Local Const $iDots = 7, $iAngelDist = 360 / $iDots, $iRadius = 250
	Local $aCoordinates[$iDots][2] ;create an array to save coordinates of the x/y coordinates
	Do
		_GDIPlus_GraphicsClear($hGfxCtxt, 0xFF000000 + $iBgColor) ;clear bitmap with given color (AARRGGBB format)
		For $i = 0 To $iDots - 1
			$iXPos = $iX_Center + Cos($iAngle * $iDeg) * $iRadius ;calculate x position
			$iYPos = $iY_Center + Sin($iAngle * $iDeg) * $iRadius ;calculate y position
			$aCoordinates[$i][0] = $iXPos
			$aCoordinates[$i][1] = $iYPos
			_GDIPlus_PenSetColor($hPen, 0xFFFFFF00) ;set pen color for inner lines
			_GDIPlus_PenSetWidth($hPen, 2) ;set pen size for outer lines
			_GDIPlus_GraphicsDrawLine($hGfxCtxt, $aCoordinates[$i][0], $aCoordinates[$i][1], _ ;draw inner lines
					$aCoordinates[Mod(($i + $iDots / 2), $iDots)][0], $aCoordinates[Mod(($i + $iDots / 2), $iDots)][1], $hPen) ;draw to opposite side
			_GDIPlus_PenSetColor($hPen, 0xFFFF8000) ;set pen color
			_GDIPlus_PenSetWidth($hPen, 3) ;set pen size
			;array of coordinates should be filled before first draw to screen
			If $i < $iDots - 1 Then _GDIPlus_GraphicsDrawLine($hGfxCtxt, $aCoordinates[$i][0], $aCoordinates[$i][1], $aCoordinates[$i + 1][0], $aCoordinates[$i + 1][1], $hPen) ;;draw outer lines
			$iAngle += $iAngelDist ;increase angle to next dot
		Next
		;draw last line to 1st line
		_GDIPlus_GraphicsDrawLine($hGfxCtxt, $aCoordinates[$i - 1][0], $aCoordinates[$i - 1][1], $aCoordinates[0][0], $aCoordinates[0][1], $hPen)

		If $iRound Then _WinAPI_BitBlt($hDC, 0, 0, $iWidth, $iHeight, $hDC_Backbuffer, 0, 0, $SRCCOPY) ;copy backbuffer to screen (GUI)
		$iAngle -= 0.5 ;decrease overall angle
		$iRound += 1
	Until Not Sleep(30) ;Sleep() always returns 1 and Not 1 is 0 correspond to False

	_Exit()
EndFunc   ;==>Example

Func _Exit() ;cleanup GDI+ resources
	_GDIPlus_PenDispose($hPen)
	_WinAPI_SelectObject($hDC_Backbuffer, $DC_Obj)
	_GDIPlus_GraphicsDispose($hGfxCtxt)
	_WinAPI_DeleteObject($hHBITMAP)
	_WinAPI_ReleaseDC($hGUI, $hDC)
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>_Exit
