#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>

_Main()

Func _Main()
	Local $hGUI, $hBMP, $hBitmap, $hGraphic

	; 捕获屏幕的左上角
	$hBMP = _ScreenCapture_Capture("", 0, 0, 400, 300)

	; 创建 GUI
	$hGUI = GUICreate("GDI+", 400, 300)
	GUISetState()

	; 初始化 GDI+ 库
	_GDIPlus_Startup()

	; 在 GUI 中描绘位图
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hBitmap, 0, 0)

	; 清理资源
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBMP)

	; 关闭 GDI+ 库
	_GDIPlus_Shutdown()

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE


EndFunc   ;==>_Main
