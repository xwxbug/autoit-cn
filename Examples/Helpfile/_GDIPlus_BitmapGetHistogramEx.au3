#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

Opt("GUIOnEventMode", 1)

_Example()

Func _Example()
	Local $sFile = FileOpenDialog("Select an image", "", "Images (*.bmp;*.png;*.jpg;*.gif;*.tif)")
	If @error Or Not FileExists($sFile) Then Return

	If Not _GDIPlus_Startup() Then
		MsgBox($MB_SYSTEMMODAL, "ERROR", "GDIPlus.dll v1.1 not available")
		Return
	EndIf

	Global $hImage = _GDIPlus_ImageLoadFromFile($sFile)

	Global $iWidth = 600
	Global $iHeight = _GDIPlus_ImageGetHeight($hImage) * 600 / _GDIPlus_ImageGetWidth($hImage)

	Global $hGui = GUICreate("GDI+ v1.1", $iWidth, $iHeight)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	Global $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
	Global $hBmp_Buffer = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
	Global $hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)
	_GDIPlus_GraphicsDrawImageRect($hGfx_Buffer, $hImage, 0, 0, $iWidth, $iHeight)

	Global $hGui_Histogram = GUICreate("Histogram", 1029, 140)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	Global $hGraphics_H = _GDIPlus_GraphicsCreateFromHWND($hGui_Histogram)
	Global $hBmp_Buffer_H = _GDIPlus_BitmapCreateFromScan0(1029, 140)
	Global $hGfx_Buffer_H = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer_H)
	_GDIPlus_GraphicsSetSmoothingMode($hGfx_Buffer_H, 2)


	Global $tHistogram = _GDIPlus_BitmapGetHistogramEx($hImage)
	_DrawHistogram($tHistogram)


	GUIRegisterMsg($WM_PAINT, "WM_PAINT")
	GUIRegisterMsg($WM_ERASEBKGND, "WM_PAINT")
	GUISetState(@SW_SHOW, $hGui)
	GUISetState(@SW_SHOW, $hGui_Histogram)


	While Sleep(10)
	WEnd
EndFunc   ;==>_Example

Func _DrawHistogram($tHistogram)
	_GDIPlus_GraphicsClear($hGfx_Buffer_H, 0xFFFFFFFF)

	Local $iValue
	Local $fScale = 1 / $tHistogram.MaxGrey * 100

	Local $aPoly[259][2] = [[258]]
	$aPoly[257][0] = 256
	$aPoly[257][1] = 100
	$aPoly[258][0] = 1
	$aPoly[258][1] = 100

	Local $hBrush = _GDIPlus_LineBrushCreate(1, 0, 256, 0, 0xFF000000, 0xFFFF0000, 3)
	Local $hPen = _GDIPlus_PenCreate(0xBB000000, 1)

	For $i = 1 To 256
		$iValue = DllStructGetData($tHistogram, "Red", $i) * $fScale
		If $iValue > 100 Then $iValue = 100
		$aPoly[$i][0] = $i
		$aPoly[$i][1] = 100 - $iValue
	Next
	_GDIPlus_GraphicsResetTransform($hGfx_Buffer_H)
	_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer_H, 0, 20)
	_GDIPlus_GraphicsFillPolygon($hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsDrawPolygon($hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsFillRect($hGfx_Buffer_H, 1, 102, 255, 16, $hBrush)
	_GDIPlus_GraphicsDrawRect($hGfx_Buffer_H, 1, 102, 255, 16, $hPen)
	_GDIPlus_GraphicsDrawString($hGfx_Buffer_H, "Red", 30, -15)


	For $i = 1 To 256
		$iValue = DllStructGetData($tHistogram, "Green", $i) * $fScale
		If $iValue > 100 Then $iValue = 100
		$aPoly[$i][1] = 100 - $iValue
	Next
	_GDIPlus_LineBrushSetColors($hBrush, 0xFF000000, 0xFF00FF00)
	_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer_H, 257, 0)
	_GDIPlus_GraphicsFillPolygon($hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsDrawPolygon($hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsFillRect($hGfx_Buffer_H, 1, 102, 255, 16, $hBrush)
	_GDIPlus_GraphicsDrawRect($hGfx_Buffer_H, 1, 102, 255, 16, $hPen)
	_GDIPlus_GraphicsDrawString($hGfx_Buffer_H, "Green", 30, -15)


	For $i = 1 To 256
		$iValue = DllStructGetData($tHistogram, "Blue", $i) * $fScale
		If $iValue > 100 Then $iValue = 100
		$aPoly[$i][1] = 100 - $iValue
	Next
	_GDIPlus_LineBrushSetColors($hBrush, 0xFF000000, 0xFF0000FF)
	_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer_H, 257, 0)
	_GDIPlus_GraphicsFillPolygon($hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsDrawPolygon($hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsFillRect($hGfx_Buffer_H, 1, 102, 255, 16, $hBrush)
	_GDIPlus_GraphicsDrawRect($hGfx_Buffer_H, 1, 102, 255, 16, $hPen)
	_GDIPlus_GraphicsDrawString($hGfx_Buffer_H, "Blue", 30, -15)


	For $i = 1 To 256
		$iValue = DllStructGetData($tHistogram, "Grey", $i) * $fScale
		If $iValue > 100 Then $iValue = 100
		$aPoly[$i][1] = 100 - $iValue
	Next
	_GDIPlus_LineBrushSetColors($hBrush, 0xFF000000, 0xFFFFFFFF)
	_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer_H, 257, 0)
	_GDIPlus_GraphicsFillPolygon($hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsDrawPolygon($hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsFillRect($hGfx_Buffer_H, 1, 102, 255, 16, $hBrush)
	_GDIPlus_GraphicsDrawRect($hGfx_Buffer_H, 1, 102, 255, 16, $hPen)
	_GDIPlus_GraphicsDrawString($hGfx_Buffer_H, "Grey", 30, -15)


	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
EndFunc   ;==>_DrawHistogram


Func WM_PAINT($hWnd, $uMsgm, $wParam, $lParam)
	#forceref $uMsgm, $wParam, $lParam

	Switch $hWnd
		Case $hGui
			_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)
		Case $hGui_Histogram
			_GDIPlus_GraphicsDrawImage($hGraphics_H, $hBmp_Buffer_H, 0, 0)
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_PAINT


Func _Exit()
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGfx_Buffer_H)
	_GDIPlus_BitmapDispose($hBmp_Buffer_H)
	_GDIPlus_GraphicsDispose($hGraphics_H)
	_GDIPlus_GraphicsDispose($hGfx_Buffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	Exit
EndFunc   ;==>_Exit
