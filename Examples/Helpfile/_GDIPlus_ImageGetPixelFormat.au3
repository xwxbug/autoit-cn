#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>


Global $iMemo

_Main()

Func _Main()
	Local $hBitmap, $hImage, $aRet

	; 创建 GUI
	GUICreate("GDI+", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 初始化 GDI+ 库
	_GDIPlus_Startup()

	; 捕获到 32 位位图
	$hBitmap = _ScreenCapture_Capture("")
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)

	; 显示屏幕捕获的像素格式
	$aRet = _GDIPlus_ImageGetPixelFormat($hImage)
	MemoWrite("Image pixel format of screen capture: " & $aRet[1]);
	MemoWrite("Image pixel format constant: " & $aRet[0]);
	MemoWrite();

	; 保存屏幕捕获位图到文件
	_GDIPlus_ImageSaveToFile($hImage, @MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 清理资源
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)

	; 从文件中加载屏幕捕获位图
	$hImage = _GDIPlus_ImageLoadFromFile(@MyDocumentsDir & "\GDIPlus_Image.jpg")

	; 显示已保存文件的像素格式
	$aRet = _GDIPlus_ImageGetPixelFormat($hImage)
	MemoWrite("Image pixel format of saved file: " & $aRet[1]);
	MemoWrite("Image pixel format constant: " & $aRet[0]);

	; 清理资源
	_GDIPlus_ImageDispose($hImage)

	; 关闭 GDI+ 库
	_GDIPlus_Shutdown()

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage = '')
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
