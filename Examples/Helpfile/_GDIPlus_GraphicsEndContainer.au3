#include <GuiConstantsEx.au3>
#include <GDIPlusEx.au3>

Opt(" MustDeclareVars ", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $iGraphicsCont

	; 初始化GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate(" _GDIPlus_GraphicsContainer Example ", 400, 350)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 设置图形对象的剪裁区域
	_GDIPlus_GraphicsSetClipRect($hGraphics, 10, 10, 150, 150)

	; 启动图形容器
	$iGraphicsCont = _GDIPlus_GraphicsBeginContainer2($hGraphics)

	; 设置容器的额外剪裁区域
	_GDIPlus_GraphicsSetClipRect($hGraphics, 100, 50, 100, 75)

	; 在容器中填充红色矩形
	$hBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000) ; 红色
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 400, $hBrush)

	; 结束容器并将图形状态重新设置为容器启动前的图形
	_GDIPlus_GraphicsEndContainer($hGraphics, $iGraphicsCont)

	; 在容器外填充蓝色矩形
	_GDIPlus_BrushSetFillColor($hBrush, 0x800000FF) ; 半透明蓝色
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 400, $hBrush)

	; 设置前两个剪辑区域到无限
	_GDIPlus_GraphicsResetClip($hGraphics)
	_GDIPlus_GraphicsDrawRect($hGraphics, 10, 10, 150, 150)
	_GDIPlus_GraphicsDrawRect($hGraphics, 100, 50, 100, 75)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除
	_GDIPlus_BrushDispose($hHatchBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	; 关闭GDI+
	_GDIPlus_Shutdown()
endfunc   ;==>_Example

