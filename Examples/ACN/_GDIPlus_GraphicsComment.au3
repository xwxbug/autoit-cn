#Include <GDIPlusEx.au3>
#Include <GUIConstantsEx.au3>

Opt(" MustDeclareVars ", 1)

Global $sText

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hDC, $hBrush, $hImageGraphics, $hMetafile, $pData, $tData, $iData, $sFileName, $hCallback, $pCallback

	; 初始化GDI+
	_GDIPlus_Startup()

	$sFileName = @MyDocumentsDir & " \SampleMeta.emf "

	$hGUI = GUICreate(" _GDIPlus_GraphicsBeginContainer Example ", 400, 350)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 获取将被关联到元文件的图形环境
	$hDC = _GDIPlus_GraphicsGetDC($hGraphics)

	; 创建用于记录的元文件(Metafile)对象
	$hMetafile = _GDIPlus_MetafileRecordFileName($sFileName, $hDC)

	; 获取图像的图形环境并绘制到元文件中
	$hImageGraphics = _GDIPlus_ImageGetGraphicsContext($hMetafile)

	; 记录半透明的绿色矩形
	$hBrush = _GDIPlus_BrushCreateSolid(0x8000FF00) ; Semi-transparent green
	_GDIPlus_GraphicsFillRect($hImageGraphics, 0, 0, 200, 200, $hBrush)

	; 创建批注数据
	$tData = DllStructCreate("char[9]")
	$pData = DllStructGetPtr($tData)
	$iData = 9
	DllStructSetData($tData, 1, "AutoIt v3 ")

	; 向元文件添加批注
	_GDIPlus_GraphicsComment($hImageGraphics, $pData, $iData)

	; 通过填充一个椭圆并添加额外批注记录另一动作
	_GDIPlus_BrushSetFillColor($hBrush, 0x80FF00FF)
	_GDIPlus_GraphicsFillEllipse($hImageGraphics, 200, 0, 150, 200, $hBrush)
	; Change the comment
	DllStructSetData($tData, 1, "Commented ")
	_GDIPlus_GraphicsComment($hImageGraphics, $pData, $iData)

	; 释放设备场景
	_GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)

	; 保存元文件
	_GDIPlus_GraphicsDispose($hImageGraphics) ; Image persisted and exclusive lock is unlocked
	_GDIPlus_ImageDispose($hMetafile)

	; 创建枚举回调函数以调用元文件中的每个记录
	$hCallback = DllCallbackRegister(" _MetafileEnum ", "int ", "int;uint;uint;ptr;ptr ")
	$pCallback = DllCallbackGetPtr($hCallback)

	; 从示例元文件创建Metafile对象并开始记录
	$hMetafile = _GDIPlus_MetafileCreateFromFile($sFileName)

	; 开始枚举元文件记录
	_GDIPlus_MetafileEnumerateDestPoint($hGraphics, $hMetafile, 0, 0, $pCallback, $hMetafile)

	; 绘制批注
	_GDIPlus_GraphicsDrawString($hGraphics, $sText, 20, 20)
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	DllCallbackFree($pCallback)
	_GDIPlus_ImageDispose($hMetafile)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

; $iRecordType - 预定义的记录类型(椭圆, 矩形, 批注等..)
; $iFlags	  - 指定记录属性的标记集
; $iDataSize   - 记录数据的字节数
; $pRecordData - 包含记录数据的缓冲区
; $pUserData   - 以前传递给源文件枚举函数的用户定义的数据

; 返回假时以退出枚举, 真时执行.
Func _MetafileEnum($iRecordType, $iFlags, $iDataSize, $pRecordData, $pUserData)
	Local $tText

	; 只运行椭圆
	Switch $iRecordType
		; 填充的椭圆及注释
		Case $GDIP_EMFPLUSRECORDTYPEFILLELLIPSE
			_GDIPlus_MetafilePlayRecord($pUserData, $iRecordType, $iFlags, $iDataSize, $pRecordData)

		Case $GDIP_EMFPLUSRECORDTYPECOMMENT
			$tText = DllStructCreate(" char[" & $iDataSize & " ] ", $pRecordData)
			$sText &= DllStructGetData($tText, 1) & @CRLF
	EndSwitch

	; 继续枚举
	Return True
endfunc   ;==>_MetafileEnum

