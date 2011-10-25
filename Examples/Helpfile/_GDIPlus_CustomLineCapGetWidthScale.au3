#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hJoinPath, $hCustomLineCap, $hPen, $iStrokeJoin
	Local $avPoints[4][2] = [[3],[-15, -15],[0, 0],[15, -15]]

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_CustomLineCapStrokeJoin Example ", 400, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建GraphicsPath并在其上添加两条线
	$hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddLines($hPath, $avPoints)

	; 创建CustomLineCap对象
	$hCustomLineCap = _GDIPlus_CustomLineCapCreate(0, $hPath)

	; 设置CustomLineCap对象的宽度
	_GDIPlus_CustomLineCapSetWidthScale($hCustomLineCap, 0.5)

	; 获取CustomLineCap对象的宽度
	$nWidthScale = _GDIPlus_CustomLineCapGetWidthScale($hCustomLineCap)

	; 创建画笔对象 , 并将其设置给CustomLineCap对象
	$hPen = _GDIPlus_PenCreate($GDIP_CORAL, 5, $UnitWorld)
	_GDIPlus_PenSetCustomEndCap($hPen, $hCustomLineCap)

	_GDIPlus_GraphicsDrawLine($hGraphics, 90, 100, 310, 310, $hPen)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_CustomLineCapDispose($hCustomLineCap)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

