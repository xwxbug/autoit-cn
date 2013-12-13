#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	Local Const $iW = 640, $iH = 240
	Global $hGUI, $hGraphics, $hBmp_Buffer, $hGfx_Bufffer, $hBrush_NA, $hBrush_A, $hPen_NA, $hPen_A
	Global $hPath, $hFormat, $hFamily, $tLayout

	$hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	GUISetOnEvent($GUI_EVENT_MOUSEMOVE, "_MouseMove")
	GUISetState()

	_GDIPlus_Startup()
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	$hGfx_Bufffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)
	_GDIPlus_GraphicsSetSmoothingMode($hGfx_Bufffer, $GDIP_SMOOTHINGMODE_HIGHQUALITY)

	$hBrush_NA = _GDIPlus_BrushCreateSolid(0xFF000066)
	$hBrush_A = _GDIPlus_BrushCreateSolid(0xFF00FF00)
	$hPen_NA = _GDIPlus_PenCreate(0xFF666600, 4)
	$hPen_A = _GDIPlus_PenCreate(0xFF00FF00, 4)

	$hPath = _GDIPlus_PathCreate()

	$hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, 1)
	$hFamily = _GDIPlus_FontFamilyCreate("Arial Black")
	$tLayout = _GDIPlus_RectFCreate(0, 0, $iW, $iH)
	_GDIPlus_PathAddString($hPath, "move mouse" & @LF & "over text", $tLayout, $hFamily, 0, 72, $hFormat)

	_MouseMove()

	While Sleep(10)
	WEnd
EndFunc   ;==>Example

Func _MouseMove()
	Local $sInfo = ""
	Local $aMouse = GUIGetCursorInfo()

	_GDIPlus_GraphicsClear($hGfx_Bufffer, 0xFF000000)
	_GDIPlus_GraphicsFillPath($hGfx_Bufffer, $hPath, $hBrush_NA)
	_GDIPlus_GraphicsDrawPath($hGfx_Bufffer, $hPath, $hPen_NA)
	Select
		Case _GDIPlus_PathIsOutlineVisiblePoint($hPath, $aMouse[0], $aMouse[1], $hPen_A, $hGfx_Bufffer)
			_GDIPlus_GraphicsDrawPath($hGfx_Bufffer, $hPath, $hPen_A)
			$sInfo = "mouse cursor touches path outline"
		Case _GDIPlus_PathIsVisiblePoint($hPath, $aMouse[0], $aMouse[1], $hGraphics)
			_GDIPlus_GraphicsFillPath($hGfx_Bufffer, $hPath, $hBrush_A)
			$sInfo = "mouse cursor in path fill area"
	EndSelect

	ToolTip($sInfo)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)
EndFunc   ;==>_MouseMove

Func _Exit()
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hBrush_NA)
	_GDIPlus_BrushDispose($hBrush_A)
	_GDIPlus_PenDispose($hPen_NA)
	_GDIPlus_PenDispose($hPen_A)

	_GDIPlus_GraphicsDispose($hGfx_Bufffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>_Exit
