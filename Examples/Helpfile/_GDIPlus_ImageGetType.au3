#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>


Global $iMemo

_Main()

Func _Main()
	Local $hBitmap, $hImage, $iImageType, $sImageType

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

	$iImageType = _GDIPlus_ImageGetType($hImage)
	Switch $iImageType
		Case $GDIP_IMAGETYPE_UNKNOWN
			$sImageType = "Unrecognized bitmap format or not image file"
		Case $GDIP_IMAGETYPE_BITMAP ; BMP, PNG, GIF, JPEG, TIFF, ICO, EXIF
			$sImageType = "Bitmap"
		Case $GDIP_IMAGETYPE_METAFILE ; EMF, WMF
			$sImageType = "Metafile"
	EndSwitch

	; 显示图像类型: 未定义 = 0, 位图 = 1, 图元文件 = 2)
	MemoWrite("Image type: " & $sImageType);

	; 清理资源
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)

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
