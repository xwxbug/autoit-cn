#include <WinAPIGdi.au3>
#include <WinAPIShPath.au3>
#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Global Const $sPng = @ScriptDir & '\Extras\Silverlight.png'

Global Const $STM_SETIMAGE = 0x0172

Local $hBitmap[2]
; Create 32 bits-per-pixel bitmap from a PNG image
_GDIPlus_Startup()
Local $hPng = _GDIPlus_ImageLoadFromFile($sPng)
$hBitmap[0] = _GDIPlus_BitmapCreateDIBFromBitmap($hPng)
Local $Width = _GDIPlus_ImageGetWidth($hPng)
Local $Height = _GDIPlus_ImageGetHeight($hPng)
_GDIPlus_ImageDispose($hPng)
_GDIPlus_Shutdown()

; Create 1 bits-per-pixel AND bitmask bitmap
$hBitmap[1] = _WinAPI_CreateANDBitmap($hBitmap[0])

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $Width * 2, $Height)
Global $Pic[2]
$Pic[0] = GUICtrlCreatePic('', 0, 0, $Width, $Height)
$Pic[1] = GUICtrlCreatePic('', $Width, 0, $Width, $Height)

; Set both bitmaps to controls
For $i = 0 To 1
	GUICtrlSendMsg($Pic[$i], $STM_SETIMAGE, 0, $hBitmap[$i])
Next

; Show GUI
GUISetState()

; Create and save icon to .ico file
Local $hIcon
Local $Path = FileSaveDialog('Save Icon', @ScriptDir, 'Icon Files (*.ico)', 2 + 16, _WinAPI_PathStripPath(_WinAPI_PathRenameExtension($sPng, '.ico')), $hForm)
If $Path Then
	$hIcon = _WinAPI_CreateIconIndirect($hBitmap[0], $hBitmap[1])
	If $hIcon Then
		_WinAPI_SaveHICONToFile($Path, $hIcon)
		_WinAPI_DestroyIcon($hIcon)
	EndIf
EndIf

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

; Unlike _GDIPlus_BitmapCreateHBITMAPFromBitmap() that creates a device-dependent bitmap (DDB), this function creates a device-independent bitmap (DIB) which may be used for semi-transparent images

Func _GDIPlus_BitmapCreateDIBFromBitmap($hBitmap)
	Local $aSize = DllCall($ghGDIPDll, 'uint', 'GdipGetImageDimension', 'ptr', $hBitmap, 'float*', 0, 'float*', 0)
	If @error Or $aSize[0] Then Return 0

	Local $tData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $aSize[2], $aSize[3], $GDIP_ILMREAD, $GDIP_PXF32ARGB)
	Local $pBits = DllStructGetData($tData, 'Scan0')
	If Not $pBits Then Return 0

	Local $hDIB = _WinAPI_CreateDIB($aSize[2], $aSize[3])
	If Not @error Then
		_WinAPI_SetBitmapBits($hDIB, $aSize[2] * $aSize[3] * 4, $pBits)
	EndIf
	_GDIPlus_BitmapUnlockBits($hBitmap, $tData)
	Return $hDIB
EndFunc   ;==>_GDIPlus_BitmapCreateDIBFromBitmap
