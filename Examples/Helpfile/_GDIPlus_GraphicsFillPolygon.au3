
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GuiConstantsEx.au3>
#include  <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hWnd, $hGraphic, $aPoints[4][2]

	; 创建界面
	GUICreate("GDI+", 400, 300)
	$hWnd = WinGetHandle("GDI+")
	GUISetState()

	; 绘制多边形
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hWnd)

	$aPoints[0][0] = 3
	$aPoints[1][0] = 150
	$aPoints[1][1] = 150
	$aPoints[2][0] = 200
	$aPoints[2][1] = 100
	$aPoints[3][0] = 250
	$aPoints[3][1] = 150

	MsgBox(4096, "Information", "Fill Polygon")

	_GDIPlus_GraphicsFillPolygon($hGraphic, $aPoints)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

endfunc   ;==>_Main

