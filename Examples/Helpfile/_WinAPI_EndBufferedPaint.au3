#Include <Constants.au3>
#Include <GUIConstantsEx.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

If _WinAPI_GetVersion() ' 6.0 ' Then
	msgbox(16, 'Error ', 'Require Windows Vista or later.')
	Exit
EndIf

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Global $hPic, $hObj, $hIcon, $hTech, $hBitmap, $hBP, $hDC, $hSrcDC, $hSrcSv, $hDestDC, $hDestSv, $hNewDC

; 加载位图及图标
$hTech = _WinAPI_LoadImage(0, @TempDir & ' \Tech.bmp ', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
$hIcon = _WinAPI_ShellExtractIcon(@TempDir & ' \NVIDIA.ico ', 0, 256, 256)

; 创建界面
GUICreate('MyGUI ', 302, 302, -1, -1, $WS_POPUP, $WS_EX_TOPMOST)
GUICtrlCreatePic('', 0, 0, 302, 302)
$hPic = GUICtrlGetHandle(-1)

; 初始化缓冲的绘制
_WinAPI_BufferedPaintInit()

; 将位图选入场景
$hDC = _WinAPI_GetDC($hPic)
$hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
$hSrcSv = _WinAPI_SelectObject($hSrcDC, $hTech)

; 启动缓冲绘制操作
$hBP = _WinAPI_BeginBufferedPaint($hSrcDC, _WinAPI_CreateRectEx(22, 22, 256, 256), $hNewDC, $BPBF_COMPATIBLEBITMAP, 0, 0, 160)

; 绘制带有透明度的图标
_WinAPI_DrawIconEx($hNewDC, 22, 22, $hIcon)

; 结束缓冲绘制操作并刷新相关场景
_WinAPI_EndBufferedPaint($hBP)

; 合并位图并释放资源
$hDestDC = _WinAPI_CreateCompatibleDC($hDC)
$hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 302, 302, 0x606060)
$hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
_WinAPI_BitBlt($hDestDC, 1, 1, 300, 300, $hSrcDC, 0, 0, $MERGECOPY)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteDC($hDestDC)
_WinAPI_SelectObject($hSrcDC, $hSrcSv)
_WinAPI_DeleteDC($hSrcDC)
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_DeleteObject($hTech)
_WinAPI_DestroyIcon($hIcon)

; 将位图设置给控件
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
$hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

; 结束缓冲绘制
_WinAPI_BufferedPaintUnInit()

GUISetState()

Do
Until GUIGetMsg() = -3

