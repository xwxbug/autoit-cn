#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hCustomLineCap, $hClonedLineCap, $hPen
	Local $avPoints[4][2] = [[3],[-15, -15],[0, 0],[15, -15]]

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_CustomLineCap* Example ", 400, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建GraphicsPath并在其上添加两条线
	$hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddLines($hPath, $avPoints)

	; 创建CustomLineCap对象
	$hCustomLineCap = _GDIPlus_CustomLineCapCreate(0, $hPath)

	; 创建复制的CustomLineCap对象
	$hClonedLineCap = _GDIPlus_CustomLineCapClone($hCustomLineCap)

	; 创建画笔对象 , 将复制的线帽以自定义线帽分配 , 画一条直线
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_PenSetCustomEndCap($hPen, $hClonedLineCap)

	_GDIPlus_GraphicsDrawLine($hGraphics, 0, 0, 100, 100, $hPen)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_CustomLineCapDispose($hClonedLineCap)
	_GDIPlus_CustomLineCapDispose($hCustomLineCap)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

