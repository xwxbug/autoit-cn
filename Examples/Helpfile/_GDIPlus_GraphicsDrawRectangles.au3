#include <GuiConstantsEx.au3>
#include <GDIPlusEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPen, $aRects[4][4]
	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_GraphicsDrawRectangles Example ", 400, 350)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建画笔对象
	$hPen = _GDIPlus_PenCreate(0xFF000000, 3)

	; 定义矩形
	$aRects[0][0] = 3

	$aRects[1][0] = 0
	$aRects[1][1] = 0
	$aRects[1][2] = 100
	$aRects[1][3] = 200

	$aRects[2][0] = 100
	$aRects[2][1] = 200
	$aRects[2][2] = 150
	$aRects[2][3] = 50

	$aRects[3][0] = 300
	$aRects[3][1] = 0
	$aRects[3][2] = 50
	$aRects[3][3] = 100

	; 绘制矩形
	_GDIPlus_GraphicsDrawRectangles($hGraphics, $aRects, $hPen)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

