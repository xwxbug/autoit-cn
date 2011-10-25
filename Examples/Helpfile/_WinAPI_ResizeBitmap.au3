#Include <Constants.au3>
#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Global $var = FileOpenDialog('pls choose a .bmp file ', @WindowsDir & ' \ ', 'bmp file (*.bmp) ', 1 + 4)
Global $hForm, $Label, $hInstance, $hCursor = _WinAPI_LoadCursorFromFile($var)

Global $tSIZE, $hBitmap

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Global $hForm, $Pic, $hPic, $tSIZE, $Width, $Height, $hObj, $hFit, $hBitmap

; 加载并缩放(x2)图像
$hBitmap = _WinAPI_LoadImage(0, $var, $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
$tSIZE = _WinAPI_GetBitmapDimension($hBitmap)
$Width = 2 * DllStructGetData($tSIZE, 'X')
$Height = 2 * DllStructGetData($tSIZE, 'Y')
$hFit = _WinAPI_ResizeBitmap($hBitmap, $Width, $Height)
_WinAPI_DeleteObject($hBitmap)

; 创建界面
$hForm = GUICreate('MyGUI ', $Width, $Height)
$Pic = GUICtrlCreatePic('', 0, 0, $Width, $Height)
$hPic = GUICtrlGetHandle($Pic)

; 将位图设置到控件
_SendMessage($hPic, $STM_SETIMAGE, 0, $hFit)
$hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj $hFit Then
	_WinAPI_DeleteObject($hFit)
EndIf

GUISetState()

Do
Until GUIGetMsg() = -3

