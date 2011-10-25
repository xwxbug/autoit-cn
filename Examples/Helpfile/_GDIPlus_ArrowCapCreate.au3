
#include  <GuiConstantsEx.au3>
#include  <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hPen, $hEndCap

	; 创建界面
	$hGUI = GUICreate("GDI+", 400, 300)
	$hWnd = WinGetHandle("GDI+")
	GUISetState()

	; 创建资源
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hWnd)
	$hPen = _GDIPlus_PenCreate(0xFF000000, 2)
	$hEndCap = _GDIPlus_ArrowCapCreate(3, 6)
	_GDIPlus_PenSetCustomEndCap($hPen, $hEndCap)

	; 显示终点线帽
	MsgBox(4096, "Information", "Pen end cap: 0x" & Hex( _GDIPlus_PenGetCustomEndCap($hPen)))

	; 绘制箭头
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 120, 390, 120, $hPen)
	_GDIPlus_PenSetWidth($hPen, 4)
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 150, 390, 150, $hPen)
	_GDIPlus_PenSetWidth($hPen, 6)
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

