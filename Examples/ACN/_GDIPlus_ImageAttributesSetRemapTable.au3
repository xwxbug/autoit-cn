#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hRedBrush, $hGreenBrush, $hBlueBrush, $hBitmap, $hBitmapContext, $hIA $iI, $iJ, $aRemapTable[4][2]

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体, 按ESC退出
	$hGUI = GUICreate("", 420, 350)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建Bitmap对象并获取其图形场景
	$hBitmap = _GDIPlus_BitmapCreateFromScan0(200, 200)
	$hBitmapContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)

	; 创建红绿蓝三种颜色的三个画刷
	$hRedBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000) ; 红色
	$hGreenBrush = _GDIPlus_BrushCreateSolid(0xFF00FF00) ; 绿色
	$hBlueBrush = _GDIPlus_BrushCreateSolid(0xFF0000FF) ; 蓝色

	For $iI = 0 To 9
		For $iJ = 0 To 9
			Switch Random(1, 3, 1)
				Case 1
					_GDIPlus_GraphicsFillRect($hBitmapContext, $iI * 20, $iJ * 20, 20, 20, $hRedBrush)
				Case 2
					_GDIPlus_GraphicsFillRect($hBitmapContext, $iI * 20, $iJ * 20, 20, 20, $hGreenBrush)
				Case Else
					_GDIPlus_GraphicsFillRect($hBitmapContext, $iI * 20, $iJ * 20, 20, 20, $hBlueBrush)
			EndSwitch
		Next
	Next

	; 不改变绘制图像
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)

	; 创建用于调整图像颜色的ImageAttributes对象
	$hIA = _GDIPlus_ImageAttributesCreate()
	; 定义替换图像颜色的重映射表
	$aRemapTable[0][0] = 3 ; 3个值

	; 用青色替换红色
	$aRemapTable[1][0] = 0xFFFF0000
	$aRemapTable[1][1] = 0xFF00FFFF
	; 用蓝色替换绿色
	$aRemapTable[2][0] = 0xFF00FF00
	$aRemapTable[2][1] = 0xFF0000FF
	; 用黄色替换蓝色
	$aRemapTable[3][0] = 0xFF0000FF
	$aRemapTable[3][1] = 0xFFFFFF00

	_GDIPlus_ImageAttributesSetRemapTable($hIA, 1, True, $aRemapTable)

	; 应用ImageAttributes颜色调整是绘制图像
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, 200, 200, 220, 0, 200, 200, $hIA)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_BrushDispose($hBlueBrush)
	_GDIPlus_BrushDispose($hGreenBrush)
	_GDIPlus_BrushDispose($hRedBrush)
	_GDIPlus_GraphicsDispose($hBitmapContext)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

