#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 600, 300)
	GUISetState()

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	Local $hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics(600, 300, $hGraphics)
	Local $hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)
	_GDIPlus_GraphicsSetSmoothingMode($hGfx_Buffer, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGfx_Buffer, 0xFF000000)

	Local $hPen = _GDIPlus_PenCreate(0xFFFFBB00, 2)

	Local $hPath = _GDIPlus_PathCreate()
	Local $hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, 1)
	Local $hFamily = _GDIPlus_FontFamilyCreate("Arial")
	Local $tLayout = _GDIPlus_RectFCreate(0, 0, 600, 300)
	_GDIPlus_PathAddString($hPath, "AutoIt freaks out!", $tLayout, $hFamily, 0, 112, $hFormat)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_FontFamilyDispose($hFamily)

	Local $hIter = _GDIPlus_PathIterCreate($hPath)
	Local $iIterCnt = _GDIPlus_PathIterGetSubpathCount($hIter)
	Local $hSubPath = _GDIPlus_PathCreate();Path to get the subpath figure
	Local $hMatrix = _GDIPlus_MatrixCreate()

	Local $iTimer = TimerInit(), $aBounds = 0
	; Loop until user exits
	Do
		If TimerDiff($iTimer) > 40 Then
			_GDIPlus_GraphicsClear($hGfx_Buffer, 0xFF000000)
			For $i = 1 To $iIterCnt
				_GDIPlus_PathReset($hSubPath);reset path transformation
				_GDIPlus_PathIterNextSubpathPath($hIter, $hSubPath)

				$aBounds = _GDIPlus_PathGetWorldBounds($hSubPath)
				_GDIPlus_MatrixSetElements($hMatrix, 1, 0, 0, 1, 0, 0);reset matrix
				_GDIPlus_MatrixTranslate($hMatrix, -($aBounds[0] + $aBounds[2] / 2), -($aBounds[1] + $aBounds[3] / 2))
				_GDIPlus_MatrixRotate($hMatrix, Random(-24, 24), True)
				_GDIPlus_MatrixTranslate($hMatrix, $aBounds[0] + $aBounds[2] / 2, $aBounds[1] + $aBounds[3] / 2, True)
				_GDIPlus_PathTransform($hSubPath, $hMatrix)

				_GDIPlus_GraphicsDrawPath($hGfx_Buffer, $hSubPath, $hPen)
			Next
			_GDIPlus_PathIterRewind($hIter)

			_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)
			$iTimer = TimerInit()
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_PathDispose($hSubPath)
	_GDIPlus_PathIterDispose($hIter)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGfx_Buffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
