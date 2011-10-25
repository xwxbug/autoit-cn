#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Global $hForm, $Pic, $hPic, $hDC, $hMemDC, $hMemSv, $hBitmap, $pBits, $hDev, $hObj, $Path
Global $aColorTable, $tColorTable

; 8位图需要256个值的颜色数组
Dim $aColorTable[256]
For $i = 0 To 255
	$aColorTable[$i] = _WinAPI_RGB(0, $i, 255 - $i)
Next

; 从颜色数组创建颜色表
$tColorTable = _WinAPI_CreateDIBColorTable($aColorTable)

; 创建8位的DIB并获取其数位值的位置指针
$hBitmap = _WinAPI_CreateDIB(256, 256, 8, $tColorTable, 256)
$pBits = _WinAPI_GetExtended()

; 填充位图颜色索引
For $i = 0 To 255
	_WinAPI_FillMemory($pBits + 256 * $i, 256, $i)
Next

; 创建界面
$hForm = GUICreate('MyGUI ', 256, 256)
$Pic = GUICtrlCreatePic('', 0, 0, 256, 256)
$hPic = GUICtrlGetHandle($Pic)

; 从DIB创建DDB以修正控件中的显示位图
$hDC = _WinAPI_GetDC($hPic)
$hDev = _WinAPI_CreateCompatibleBitmap($hDC, 256, 256)
$hMemDC = _WinAPI_CreateCompatibleDC($hDC)
$hMemSv = _WinAPI_SelectObject($hMemDC, $hDev)
_WinAPI_TextOut($hMemDC, 0, 0, $hBitmap)
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; 将位图设置给控件
_SendMessage($hPic, $STM_SETIMAGE, 0, $hDev)
$hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hDev Then
	_WinAPI_FreeObject($hDev)
EndIf

GUISetState()

; 保存8像素位的位图到.bmp文件
$Path = FileSaveDialog('Save Image ', @Desktopdir, 'Bitmap Image Files (*.bmp) ', 2 + 16, @Desktopdir & ' \MyImage.bmp ', $hForm)
If $Path Then
	_WinAPI_SaveHBITMAPToFile($Path, $hBitmap, 2834, 2834)
EndIf

Do
Until GUIGetMsg() = -3

