#include <GuiConstantsEx.au3>
#include <GDIPlusEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $hContext, $hBitmap, $hIA, $aColorMap[2][2], $iI, $iJ, $iClr

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_GraphicsDrawImagePointsRect ", 400, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _GDIPlus_BrushCreateSolid()

	; 创建大小为180x120的位图对象
	$hBitmap = _GDIPlus_BitmapCreateFromScan0(180, 120)

	; 获取要在其中绘制位图的图形场景
	$hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsClear($hContext)

	For $iI = 0 To 5
		For $iJ = 0 To 3
			Switch Mod($iI + $iJ, 3)
				Case 0
					$iClr = 0xFFFF0000
				Case 1
					$iClr = 0xFF00FF00
				Case Else
					$iClr = 0xFF0000FF
			EndSwitch

			_GDIPlus_BrushSetSolidColor($hBrush, $iClr)
			_GDIPlus_GraphicsFillRect($hContext, $iI * 30, $iJ * 30, 30, 30, $hBrush)
		Next
	Next

	; 创建ImageAttribute对象调整图像颜色
	$hIA = _GDIPlus_ImageAttributesCreate()

	; 用黄色替换红色
	$aColorMap[0][0] = 1
	$aColorMap[1][0] = 0xFFFF0000 ; 红色
	$aColorMap[1][1] = 0xFFFFFF00 ; 黄色

	_GDIPlus_ImageAttributesSetRemapTable($hIA, 0, True, $aColorMap)

	; 绘制原始图像
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 5, 5)
	; 绘制剪裁的图像
	_GDIPlus_GraphicsDrawImagePointsRect($hGraphics, $hBitmap, 220, 5, 370, 5, 190, 125, 0, 0, 180, 120, 2, $hIA)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

