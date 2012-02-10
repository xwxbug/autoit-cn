#include <Constants.au3>
#include <GDIPlusEx.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
#include <StaticConstants.au3>

Opt('MustDeclareVars ', 1)

_Example()

Func _Example()
	Local $hGUI, $hBMP, $hBitmap, $hGraphic

	; 创建界面
	$hGUI = GUICreate(" _GDIPlus_HICONCreateFromBitmap Example ", 400, 200)
	$Label = GUICtrlCreateLabel("", 120, 20, 160, 160, $SS_ICON)
	GUISetState()

	; 初始化GDI+库
	_GDIPlus_Startup()

	; 将位图绘制到GUI
	$hBMP = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)
	$hIcon = _GDIPlus_HICONCreateFromBitmap($hBitmap)
	GUICtrlSendMsg($Label, $hBitmap, 370, $IMAGE_ICON, $hIcon) ; STM_SETIMAGE = 370

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; 清除资源
	_WinAPI_DestroyIcon($hIcon)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBMP)

	; 关闭GDI+库
	_GDIPlus_ShutDown()

endfunc   ;==>_Example

