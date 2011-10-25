#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Global Const $Pi = 4 * ATan(1)

Global $hForm, $Pic, $hPic, $tRECT, $tXFORM, $hObj, $hBitmap, $hBrush, $hPen, $hDC, $hMemDC, $hMemSv
Global $nM11, $nM12, $nM21, $nM22, $nDx, $nDy, $iXc, $iYc, $nAngle
; 创建界面
$hForm = GUICreate('MyGUI ', 340, 340)
$Pic = GUICtrlCreatePic('', 0, 0, 320, 320)
$hPic = GUICtrlGetHandle($Pic)

; 创建位图
$hDC = _WinAPI_GetDC($hPic)
$hMemDC = _WinAPI_CreateCompatibleDC($hDC)
$hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 340, 340, _WinAPI_SwitchColor( _WinAPI_GetSysColor($COLOR_3DFACE)))
$hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)

; 设置高级图形模式以便可设置世界坐标转换
_WinAPI_SetGraphicsMode($hMemDC, $GM_ADVANCED)

; 创建旋转5度的转换矩阵
$nAngle = $Pi / 36
$iXc = 170
$iYc = 170
$nM11 = Cos($nAngle)
$nM12 = Sin($nAngle)
$nM21 = -$nM12
$nM22 = $nM11
$nDx = $iXc * (1 - Cos($nAngle)) + $iYc * Sin($nAngle)
$nDy = $iYc * (1 - Cos($nAngle)) - $iXc * Sin($nAngle)
$tXFORM = _WinAPI_CreateTransform($nM11, $nM12, $nM21, $nM22, $nDx, $nDy)

; 按旋转绘制椭圆
$hBrush = _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($NULL_BRUSH))
$hPen = _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($DC_PEN))
_WinAPI_SetDCPenColor($hMemDC, 0xDD0000)
$tRECT = _WinAPI_CreateRect($iXc - 150, $iYc - 40, $iXc + 150, $iYc + 40)
For $i = 0 To 350 Step 5
	_WinAPI_ModifyWorldTransform($hMemDC, $tXFORM, $MWT_LEFTMULTIPLY)
	_WinAPI_Ellipse($hMemDC, $tRECT)
Next

; 释放对象
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hBrush)
_WinAPI_SelectObject($hMemDC, $hPen)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; 将位图设置到控件
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
$hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState()

Do
Until GUIGetMsg() = -3

