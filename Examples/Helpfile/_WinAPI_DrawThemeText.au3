#Include <FontConstants.au3>
#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Global $hForm, $hPic, $tRECT, $Pic, $hTheme, $hBitmap, $hObj, $hFont, $hSource, $hDC, $hDev, $hSv

; 创建界面
$hForm = GUICreate('MyGUI ', 160, 199)
$Pic = GUICtrlCreatePic('', 0, 0, 160, 199)
$hPic = GUICtrlGetHandle($Pic)

; 创建位图
$hDev = _WinAPI_GetDC($hPic)
$hDC = _WinAPI_CreateCompatibleDC($hDev)
$hSource = _WinAPI_CreateCompatibleBitmapEx($hDev, 160, 199, _WinAPI_SwitchColor( _WinAPI_GetSysColor($COLOR_3DFACE)))
$hSv = _WinAPI_SelectObject($hDC, $hSource)

; 绘制对象
$tRECT = _WinAPI_CreateRectEx(25, 25, 110, 25)
$hFont = _WinAPI_CreateFont(12, 0, 0, 0, $FW_NORMAL, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, $DEFAULT_PITCH, 'MS Shell Dlg')
_WinAPI_SetBkMode($hDC, $TRANSPARENT)
_WinAPI_SelectObject($hDC, $hFont)
$hTheme = _WinAPI_OpenThemeData($hForm, 'Button')
If Not @error Then
	For $i = 1 To 5
		_WinAPI_DrawThemeBackground($hTheme, 1, $i, $hDC, $tRECT)
		_WinAPI_DrawThemeText($hTheme, 1, $i, $hDC, 'OK ', $tRECT, BitOR($DT_CENTER, $DT_SINGLELINE, $DT_VCENTER))
		_WinAPI_OffsetRect($tRECT, 0, 31)
	Next
	_WinAPI_CloseThemeData($hTheme)
EndIf

; 合并位图
$hBitmap = _WinAPI_CreateCompatibleBitmap($hDev, 160, 199)
_WinAPI_SelectObject($hDC, $hBitmap)
_WinAPI_DrawBitmap($hDC, 0, 0, $hSource, $MERGECOPY)
_WinAPI_ReleaseDC($hPic, $hDev)
_WinAPI_SelectObject($hDC, $hSv)
_WinAPI_FreeObject($hSource)
_WinAPI_DeleteDC($hDC)

; 将位图设置到控件
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
$hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj $hBitmap Then
	_WinAPI_FreeObject($hBitmap)
EndIf

GUISetState()

Do
Until GUIGetMsg() = -3

