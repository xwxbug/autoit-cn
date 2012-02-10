#include <Color.au3>
#include <GDIPlusEx.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Opt(" MustDeclareVars ", 1)
Opt(" GUIOnEventMode ", 1)

_GDIPlus_Startup()

Local $hGUI = GUICreate("", 150, 150, -1, -1, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST))
Local $bg = 0xFFFFFF
GUISetBkColor($bg)
_WinAPI_SetLayeredWindowAttributes($hGUI, $bg)
GUISetState()

Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics(150, 150, $hGraphics)
Local $hBackbuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)

_GDIPlus_GraphicsSetSmoothingMode($hBackbuffer, 2)

Local $tRectF = _GDIPlus_RectFCreate(0, 0, 30, 30)
Local $hBrush = _GDIPlus_LineBrushCreateFromRectWithAngle($tRectF, 0xFF008000, 0xFF00FF00, 45, True, 1)

Local $pen_size = Floor(150 / 6)
Local $hPen = _GDIPlus_PenCreate(0, $pen_size)
Local $hPen2 = _GDIPlus_PenCreate2($hBrush, $pen_size)

HotKeySet('{esc} ', "_Exit ")

Local $fx, $sString

Local $font = " Arial "
Local $show_f = False
Local $show_bgc = False
Local $fsize = Floor(150 / 12)
Local $angle = 0
Local $sf = " %.2f "

Local $p, $percent = False
Local $dir = 1
Local $i = 0
Local $max = 150

While Sleep(30)
	$p = $i / $max
	$angle = $p * 360
	If $angle 0 Or $angle > 360 Then $dir *= -1
	_GDIPlus_GraphicsClear($hBackbuffer, 0xFFFFFFFF)
	_GDIPlus_PenSetColor($hPen, 0xFFE0FFE0)
	If $show_bgc Then _GDIPlus_GraphicsDrawEllipse($hBackbuffer, $pen_size / 2, $pen_size / 2, 150 - $pen_size, 150 - $pen_size, $hPen)
	_GDIPlus_GraphicsDrawArc($hBackbuffer, $pen_size / 2, $pen_size / 2, 150 - $pen_size, 150 - $pen_size, -90, $angle, $hPen2)
	If $show_f Then
		If $percent Then
			$sString = $p * 100
			$sf = " %.2f% "
			$fx = StringLen( StringFormat($sf, $sString)) * $fsize / 2.5
		Else
			$sString = $i
			$fx = StringLen( StringFormat($sf, $sString)) * $fsize / 2.5
		EndIf
		_GDIPlus_GraphicsDrawString($hBackbuffer, StringFormat($sf, $sString), 75 - $fx, 75 - $fsize * 0.75, $font, $fsize)
	EndIf
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, 150, 150)
	$i += 1 * $dir
WEnd

Func _Exit()
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hBackbuffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	Exit
endfunc   ;==>_Exit

