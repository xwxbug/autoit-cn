#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>
#Include <ScreenCapture.au3>

Opt(" MustDeclareVars ", 1)

Global Const $sFileName = @MyDocumentsDir & " \SampleMeta.emf "

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hMetafile, $tColorMatrix, $hIA, $pColorMatrix

	; 初始化GDI+
	_GDIPlus_Startup()

	; 创建GUI窗体, 按ESC退出
	$hGUI = GUICreate(" _GDIPlus_ImageAttributesSetNoOp Example ", 600, 350)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_CreateTestMetafile($hGraphics)

	; 创建来自示例元文件的Metafile对象并开始播放记录
	$hMetafile = _GDIPlus_MetafileCreateFromFile($sFileName)
	; 创建用于调整图像颜色的ImageAttributes对象
	$hIA = _GDIPlus_ImageAttributesCreate()

	; 创建将红色转为绿色的颜色矩阵
	$tColorMatrix = _ColorMatrixCreateRedToGreen()
	$pColorMatrix = DllStructGetPtr($tColorMatrix)

	; 设置ImageAttributes颜色矩阵 , applies color adjustment to pens and brushes
	_GDIPlus_ImageAttributesSetColorMatrix($hIA, 2, True, $pColorMatrix)
	_GDIPlus_ImageAttributesSetColorMatrix($hIA, 3, True, $pColorMatrix)

	; 禁用对画笔的颜色调整但画刷可用
	_GDIPlus_ImageAttributesSetNoOp($hIA, 2, False) ; 打开
	_GDIPlus_ImageAttributesSetNoOp($hIA, 3, True) ; 关闭

	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hMetafile, 0, 0, 200, 350, 0, 0, 200, 350, $hIA)

	; 禁用对画刷的颜色调整但画笔可用
	_GDIPlus_ImageAttributesSetNoOp($hIA, 2, True) ; 关闭
	_GDIPlus_ImageAttributesSetNoOp($hIA, 3, False) ; 打开
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hMetafile, 0, 0, 200, 350, 200, 0, 200, 350, $hIA)

	; 重置画刷的颜色调整但禁用对画笔的颜色调整
	_GDIPlus_ImageAttributesSetNoOp($hIA, 2, False) ; 打开
	_GDIPlus_ImageAttributesSetNoOp($hIA, 3, True) ; 关闭

	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hMetafile, 0, 0, 200, 350, 400, 0, 200, 350, $hIA)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_ImageDispose($hMetafile)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 释放GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

; 该函数创建并保存示例元文件
Func _CreateTestMetafile($hGraphics)
	Local $hDC, $hMetafile, $hRedBrush, $hRedPen, $hImageContext

	; 获取将关联到元文件的图形设备场景
	$hDC = _GDIPlus_GraphicsGetDC($hGraphics)

	; 创建用以记录的Metafile对象
	$hMetafile = _GDIPlus_MetafileRecordFileName($sFileName, $hDC)

	; 获取图像图形场景并维持元文件的绘制
	$hImageContext = _GDIPlus_ImageGetGraphicsContext($hMetafile)

	; 记录填充的红色矩形
	$hRedBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000) ; Red
	_GDIPlus_GraphicsFillRect($hImageContext, 0, 0, 200, 175, $hRedBrush)

	; 记录使用红色笔绘制椭圆操作
	$hRedPen = _GDIPlus_PenCreate(0xFFFF0000, 5)
	_GDIPlus_GraphicsDrawEllipse($hImageContext, 0, 175, 200, 175, $hRedPen)

	; 释放设备场景
	_GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)

	; 保存元文件
	_GDIPlus_GraphicsDispose($hImageContext) ; 保留图像但解锁锁定

	; 清除
	_GDIPlus_PenDispose($hRedPen)
	_GDIPlus_BrushDispose($hRedBrush)
	_GDIPlus_ImageDispose($hMetafile)
endfunc   ;==>_CreateTestMetafile

; 该函数创建将红色转变为绿色的ColorMatrix结构
Func _ColorMatrixCreateRedToGreen()
	Local $tColorMatrix

	$tColorMatrix = _GDIPlus_ColorMatrixCreate()
	DllStructSetData($tColorMatrix, "m ", 0, 1) ; 红色组分的缩放因子为0(无)
	DllStructSetData($tColorMatrix, "m ", 1, 2) ; 红色通道的绿色组分的缩放因子为1(红色变为绿色)

	Return $tColorMatrix
endfunc   ;==>_ColorMatrixCreateRedToGreen

