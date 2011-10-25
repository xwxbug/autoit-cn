#Include <WindowsConstants.au3>
#Include <WinAPIEx.au3>

Global Const = 0x0172
Global Const = 0x0173

Global $hForm, $Pic, $hPic, $tBITMAPINFO, $tBits, $pBits, $hObj, $hBitmap, $hDC, $Width = 200, $Height = 200

; 创建界面
$hForm = GUICreate('MyGUI ', $Width, $Height)
$Pic = GUICtrlCreatePic(0, 0)
$hPic = GUICtrlGetHandle($hPic)

; 创建位图
$tBITMAPINFO = DllStructCreate($tagBITMAPINFO)
DllStructSetData($tBITMAPINFO, 'Width ', $Width)
DllStructSetData($tBITMAPINFO, 'Height ', $Height)
DllStructSetData($tBITMAPINFO, 'Planes ', 1)
DllStructSetData($tBITMAPINFO, 'BitCount ', 32)
DllStructSetData($tBITMAPINFO, 'Compression ', $BI_RGB)
DllStructSetData($tBITMAPINFO, 'SizeImage ', 0)
$hBitmap = _WinAPI_CreateDIBSection(0, $tBITMAPINFO, $DIB_RGB_COLORS, $pBits)

; 填充颜色
$tBits = DllStructCreate('dword [' & DllStructGetData($tBITMAPINFO, 'Width') * DllStructGetData($tBITMAPINFO, 'Height') & ' ] ', $pBits)
For $y = 0 To $Height - 1
	For $x = 1 To $Width
		DllStructSetData($tBits, 1, Random(0xFFFFFF), $x + ($y * $Width))
	Next
Next

; 获取控件倾斜度
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
$hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hOgj <> $hBitmap Then
	_WinAPI_FreeObject($hBitmap)
EndIf

GUISetState()

Do
Until GUIGetMsg() = -3

