
#include  <GuiConstantsEx.au3>
#include  <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hPen, $hEndCap, $iInset

	; 创建界面
	$hGUI = GUICreate("GDI+", 400, 300)
	$hWnd = WinGetHandle("GDI+")
	GUISetState()

	; 创建资源
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hWnd)
	$hPen = _GDIPlus_PenCreate(0xFF000000, 4)
	$hEndCap = _GDIPlus_ArrowCapCreate(3, 6)

	; 绘制箭头1
	$iInset = 0.5
	_GDIPlus_ArrowCapSetMiddleInset($hEndCap, $iInset)
	_GDIPlus_PenSetCustomEndCap($hPen, $hEndCap)
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 120, 390, 120, $hPen)

	; 绘制箭头2
	$iInset = _GDIPlus_ArrowCapGetMiddleInset($hEndCap) + 0.5
	_GDIPlus_ArrowCapSetMiddleInset($hEndCap, $iInset)
	_GDIPlus_PenSetCustomEndCap($hPen, $hEndCap)
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 150, 390, 150, $hPen)

	; 绘制箭头3
	$iInset = _GDIPlus_ArrowCapGetMiddleInset($hEndCap) + 0.5
	_GDIPlus_ArrowCapSetMiddleInset($hEndCap, $iInset)
	_GDIPlus_PenSetCustomEndCap($hPen, $hEndCap)
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 180, 390, 180, $hPen)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_ArrowCapDispose($hEndCap)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
endfunc   ;==>_Main

