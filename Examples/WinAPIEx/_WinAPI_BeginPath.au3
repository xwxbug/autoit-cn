#Include <APIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Global $hForm, $Pic, $hPic, $hObj, $hBitmap, $hBrush, $hPen, $hDC, $hMemDC, $hMemSv

; 创建 GUI
$hForm = GUICreate('MyGUI', 241, 241)
$Pic = GUICtrlCreatePic('', 0, 0, 241, 241)
$hPic = GUICtrlGetHandle($Pic)

; 创建位图
$hDC = _WinAPI_GetDC($hPic)
$hMemDC = _WinAPI_CreateCompatibleDC($hDC)
$hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 241, 241, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
$hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)

; 创建路径
_WinAPI_BeginPath($hMemDC)
_WinAPI_MoveTo($hMemDC, 220, 78)
_WinAPI_LineTo($hMemDC, 170, 218)
_WinAPI_LineTo($hMemDC, 70, 218)
_WinAPI_LineTo($hMemDC, 20, 78)
_WinAPI_SetArcDirection($hMemDC, $AD_CLOCKWISE)
_WinAPI_ArcTo($hMemDC, _WinAPI_CreateRectEx(49, 22, 143, 143), 49, 78, 192, 78)
_WinAPI_CloseFigure($hMemDC)
_WinAPI_Ellipse($hMemDC, _WinAPI_CreateRectEx(70, 44, 101, 101))
_WinAPI_Ellipse($hMemDC, _WinAPI_CreateRectEx(90, 64, 61, 61))
_WinAPI_EndPath($hMemDC)

; 画大致轮廓并填充路径内部
$hBrush = _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($DC_BRUSH))
$hPen = _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($DC_PEN))
_WinAPI_SetDCBrushColor($hMemDC, 0xFFC000)
_WinAPI_SetDCPenColor($hMemDC, 0xDD0000)
_WinAPI_StrokeAndFillPath($hMemDC)

; 释放对象
_WinAPI_DeleteObject(_WinAPI_SelectObject($hDC, $hBrush))
_WinAPI_DeleteObject(_WinAPI_SelectObject($hDC, $hPen))
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; 设置位图到控件
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
$hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState()

Do
Until GUIGetMsg() = -3
