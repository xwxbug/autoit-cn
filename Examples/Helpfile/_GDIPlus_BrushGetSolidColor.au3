#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>

_Main()

Func _Main()
	Local $hGUI, $Label1, $label2, $hGraphic, $hBrush1, $iClr1, $iClr2

	; 创建 GUI
	$hGUI = GUICreate("GDI+", 345, 150)
	$Label1 = GUICtrlCreateLabel("", 2, 2, 150, 20)
	$label2 = GUICtrlCreateLabel("", 202, 2, 150, 20)
	GUISetState()
	Sleep(100)

	; 初始化 GDIPlus
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; 创建实心画刷
	$hBrush1 = _GDIPlus_BrushCreateSolid()

	; 获取实心画刷颜色
	$iClr1 = _GDIPlus_BrushGetSolidColor($hBrush1)

	; 使用原来的画刷颜色描绘图形
	_GDIPlus_GraphicsFillEllipse($hGraphic, 25, 25, 100, 100, $hBrush1)

	; 设置新的画刷颜色 (0xFFFF0000 = 红色)
	_GDIPlus_BrushSetSolidColor($hBrush1, 0xFFFF0000)

	; 获取新的实新画刷颜色
	$iClr2 = _GDIPlus_BrushGetSolidColor($hBrush1)

	; 使用新的画刷颜色描绘图形
	_GDIPlus_GraphicsFillRect($hGraphic, 220, 25, 100, 100, $hBrush1)

	; 把原来的画刷颜色写入 Label1
	GUICtrlSetData($Label1, "Brush orignal color: " & Hex($iClr1))

	; 把新的画刷颜色写入 Label2
	GUICtrlSetData($label2, "Brush new color: " & Hex($iClr2))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清理资源
	_GDIPlus_BrushDispose($hBrush1)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()

EndFunc   ;==>_Main
