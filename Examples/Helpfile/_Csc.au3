#include <Math.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hBrush, $hFormat, $hFamily, $hFont, $tLayout, $hPen, $hDashPen
	Dim $aPoint[802][2], $j = 0, $unitline = 0

	; 创建界面
	$hGUI = GUICreate("Cosecant", 400, 300)
	$hWnd = WinGetHandle("Cosecant")
	GUISetState()

	; 绘制字符串
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hWnd)
	$hBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
	$hFormat = _GDIPlus_StringFormatCreate()
	$hFamily = _GDIPlus_FontFamilyCreate("Arial")
	$hFont = _GDIPlus_FontCreate($hFamily, 8, 2)
	$tLayout = _GDIPlus_RectFCreate(200, 142, 50, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'o(0,0)', $hFont, $tLayout, $hFormat, $hBrush)
	$tLayout = _GDIPlus_RectFCreate(20, 70, 200, 20)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, 'Cosecant', $hFont, $tLayout, $hFormat, $hBrush)
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($hGraphic, 0, 140, 400, 140, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, 200, 0, 200, 300, $hPen)
	$hDashPen = _GDIPlus_PenCreate()
	_GDIPlus_PenSetDashStyle($hDashPen, $GDIP_DASHSTYLEDOT)

	
	$aPoint[0][0] = 801
	For $i = -12 To 12 Step 0.01
		$aPoint[$j][0] = $i * 20 + 200
		$aPoint[$j][1] = 140 - _Csc($i) * 50
		If $j Then
			If $j > 2 Then
				Dim $a0 = 140 - $aPoint[$j][1]
				Dim $a1 = 140 - $aPoint[$j - 1][1]
				Dim $a2 = 140 - $aPoint[$j - 2][1]
				If ($a1 - $a2) * ($a1 - $a0) > 0 Then
					_GDIPlus_GraphicsDrawLine($hGraphic, $aPoint[$j - 1][0], 0, $aPoint[$j - 1][0], 300, $hDashPen)
				Else
					If (140 - $a0) * (140 - $a2) < 0 Then
						_GDIPlus_GraphicsDrawLine($hGraphic, $aPoint[$j - 1][0] + 4, 0, $aPoint[$j - 1][0] + 4, 300, $hDashPen)
					EndIf
				EndIf
			EndIf
			If $aPoint[$j][1] * $aPoint[$j - 1][1] < 0 Then
				ReDim $aPoint[$j][2]
				$aPoint[0][0] = $j - 1
				_GDIPlus_GraphicsDrawCurve($hGraphic, $aPoint)
				$aPoint[0][0] = 0
				ReDim $aPoint[802][2]
				$aPoint[0][0] = 801
				$j = 0
			EndIf
		EndIf
		$j += 1
	Next
	;  For $i = -4 To 4 Step 0.01
	;   _GDIPlus_GraphicsDrawEllipse($hGraphic, $i * 50 + 200, 150 - _Excsc($i * $pi) * 50, 1, 1)
	;Next

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main
