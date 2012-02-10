#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $iWidth = 300, $iHeight = 270, $hBrush[53], $dx, $dy, $k

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_HatchBrushCreate Example ", 340, 230, -1, -1, Default)

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, 0)
	GUISetState()

	For $i = 0 To UBound($hBrush) - 1
		$hBrush[$i] = _GDIPlus_HatchBrushCreate($i, 0xFF0000FF, 0xFFFFFFFF)
	Next

	$dx = Int($iWidth / 8)
	$dy = Int($iHeight / 7)

	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000)

	$k = 0
	For $i = 0 To $iHeight - 1 Step $dy
		For $j = 0 To $iWidth - 1 Step $dx
			If $k <= UBound($hBrush) - 1 Then
				_GDIPlus_GraphicsFillEllipse($hGraphics, $j, $i, $dx, $dy, $hBrush[$k])
			EndIf
			$k += 1
		Next
	Next

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	For $i = 0 To UBound($hBrush) - 1
		_GDIPlus_BrushDispose($hBrush[$i])
	Next
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

