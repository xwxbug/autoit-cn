#include <GDIPlusEx.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Opt(" GUIOnEventMode ", 1)

Global $iWidth = 400
Global $iHeight = 300

Global $fSize = 0.2
Global $iRad = 8

Global $aMPos[2] = [0, 0], $aMPos_Old[2] = [0, 0]

_GDIPlus_Startup()

Global $hGui = GUICreate(" HeatMap ", $iWidth, $iHeight)
GUISetOnEvent($GUI_EVENT_CLOSE, "_EXIT ")
Global $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
Global $hBmpBuffer = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
Global $hGfxBuffer = _GDIPlus_ImageGetGraphicsContext($hBmpBuffer)
_GDIPlus_GraphicsSetSmoothingMode($hGfxBuffer, 2)
Global $hBmpHeat = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
Global $hGfxHeat = _GDIPlus_ImageGetGraphicsContext($hBmpHeat)
_GDIPlus_GraphicsSetSmoothingMode($hGfxHeat, 2)
_GDIPlus_GraphicsClear($hGfxBuffer, 0xFFFFFFFF)
_GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)

GUIRegisterMsg($WM_PAINT, "WM_PAINT ")
GUIRegisterMsg($WM_ERASEBKGND, "WM_ERASEBKGND ")
GUISetState()

While 1
	$aMPos = _MouseGetPos($hGui)
	If $aMPos[0] > 0 And $aMPos[0] $iWidth And $aMPos[1] > 0 And $aMPos[1] $iHeight And($aMPos[0] $aMPos_Old[0] Or $aMPos[1] $aMPos_Old[1]) Then
		_DrawHeat($aMPos[0], $aMPos[1])
		$aMPos_Old = $aMPos
	EndIf
WEnd

Func _DrawHeat($iX, $iY)
	$iX = $iX * $fSize
	$iY = $iY * $fSize

	Local $hPath = _GDIPlus_PathCreate(0)
	_GDIPlus_PathAddEllipse($hPath, $iX, $iY, $iRad * 2, $iRad * 2)
	Local $aColor[2] = [1, 0x00000000]
	Local $hPathBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	_GDIPlus_PathBrushSetCenterColor($hPathBrush, 0x20000000)
	_GDIPlus_PathBrushSetSurroundColorsWithCount($hPathBrush, $aColor)
	_GDIPlus_GraphicsFillPath($hGfxHeat, $hPath, $hPathBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hPathBrush)

	Local $BitmapData = _GDIPlus_BitmapLockBits($hBmpHeat, $iX, $iY, $iRad * 2, $iRad * 2, BitOR($GDIP_ILMREAD, $GDIP_ILMWRITE), $GDIP_PXF32ARGB)
	Local $Stride = DllStructGetData($BitmapData, "Stride ")
	Local $Width = DllStructGetData($BitmapData, "Width ")
	Local $Height = DllStructGetData($BitmapData, "Height ")
	Local $Scan0 = DllStructGetData($BitmapData, "Scan0 ")
	Local $PixelData, $Color, $Alpha, $R, $G, $B, $Tmp

	For $row = 0 To $Height - 1
		$PixelData = DllStructCreate(" dword[" & $Width & ' ] ', $Scan0 + ($row * $Stride))
		For $col = 1 To $Width
			$Color = DllStructGetData($PixelData, 1, $col)

			$Alpha = BitAND( BitShift($Color, 24), 0xFF)
			$R = BitAND( BitShift($Color, 16), 0xFF)
			$G = BitAND( BitShift($Color, 8), 0xFF)
			$B = BitAND($Color, 0xFF)
			Switch $Alpha
				Case 235 To 255
					$Tmp = 255 - $Alpha
					$R = 255 - $Tmp
					$G = $Tmp * 12
				Case 200 To 234
					$Tmp = 234 - $Alpha
					$R = 255 - ($Tmp * 8)
					$G = 255
				Case 150 To 199
					$Tmp = 199 - $Alpha
					$G = 255
					$B = $Tmp * 5
				Case 100 To 149
					$Tmp = 149 - $Alpha
					$G = 255 - ($Tmp * 5)
					$B = 255
				Case Else
					$B = 255
			EndSwitch
			If $R 0 Then $R = 0
			If $R > 0xFF Then $R = 0xFF
			If $G 0 Then $G = 0
			If $G > 0xFF Then $G = 0xFF
			If $B 0 Then $B = 0
			If $B > 0xFF Then $B = 0xFF
			DllStructSetData($PixelData, 1, BitOR( BitShift($Alpha, -24), BitShift($R, -16), BitShift($G, -8), $B), $col)
		Next
	Next
	_GDIPlus_BitmapUnlockBits($hBmpHeat, $BitmapData)

	_GDIPlus_GraphicsClear($hGfxBuffer, 0xFFFFFFFF)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpHeat, $iRad, $iRad, $iWidth * $fSize, $iHeight * $fSize, 0, 0, $iWidth, $iHeight)

	_GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)
endfunc   ;==>_DrawHeat

Func _MouseGetPos($hWnd = 0)
	Local $tPoint = DllStructCreate(" long X;long Y ")
	Local $aResult = DllCall(" user32.dll ", "bool ", "GetCursorPos ", "ptr ", DllStructGetPtr($tPoint))
	If @error Then Return SetError(@error, @extended, 0)
	If $hWnd Then _WinAPI_ScreenToClient($hWnd, $tPoint)
	Local $aReturn[2]
	$aReturn[0] = DllStructGetData($tPoint, 1)
	$aReturn[1] = DllStructGetData($tPoint, 2)
	Return $aReturn
endfunc   ;==>_MouseGetPos

Func WM_PAINT($hWnd, $uMsgm, $wParam, $lParam)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_PAINT

Func WM_ERASEBKGND($hWnd, $uMsgm, $wParam, $lParam)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)
	Return True
endfunc   ;==>WM_ERASEBKGND

Func _Exit()
	_GDIPlus_GraphicsDispose($hGfxHeat)
	_GDIPlus_BitmapDispose($hBmpHeat)
	_GDIPlus_GraphicsDispose($hGfxBuffer)
	_GDIPlus_BitmapDispose($hBmpBuffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	Exit
endfunc   ;==>_Exit

