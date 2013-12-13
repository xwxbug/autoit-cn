#include <WinAPIGdi.au3>
#include <APIGdiConstants.au3>
#include <WinAPISys.au3>

; Load image
Local $hSource = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\AutoIt.bmp', $IMAGE_BITMAP, 0, 0, BitOR($LR_LOADFROMFILE, $LR_CREATEDIBSECTION))

; Resize bitmap to 256x256 pixels
Local $hBitmap = _WinAPI_AdjustBitmap($hSource, 256, 256, $HALFTONE)

; Create compressed PNG data
Local $pData = 0
Local $Length = _WinAPI_CompressBitmapBits($hBitmap, $pData)

; Create .ico file
If Not @error Then
	Local $tICO = DllStructCreate('align 1;ushort Reserved;ushort Type;ushort Count;byte Header[20]')
	Local $tHDR = DllStructCreate('byte Width;byte Height;byte ColorCount;byte Reserved;ushort Planes;ushort BitCount;long Size;long Offset', DllStructGetPtr($tICO, 'Header'))
	DllStructSetData($tICO, 'Reserved', 0)
	DllStructSetData($tICO, 'Type', 1)
	DllStructSetData($tICO, 'Count', 1)
	DllStructSetData($tHDR, 'Width', 0)
	DllStructSetData($tHDR, 'Height', 0)
	DllStructSetData($tHDR, 'ColorCount', 0)
	DllStructSetData($tHDR, 'Reserved', 0)
	DllStructSetData($tHDR, 'Planes', 1)
	DllStructSetData($tHDR, 'BitCount', 32)
	DllStructSetData($tHDR, 'Size', $Length)
	DllStructSetData($tHDR, 'Offset', DllStructGetSize($tICO))
	Local $hFile = _WinAPI_CreateFile(@TempDir & '\MyIcon.ico', 1, 4)
	Local $Bytes
	_WinAPI_WriteFile($hFile, DllStructGetPtr($tICO), DllStructGetSize($tICO), $Bytes)
	_WinAPI_WriteFile($hFile, $pData, $Length, $Bytes)
	_WinAPI_CloseHandle($hFile)
EndIf

; Delete unnecessary bitmaps
_WinAPI_DeleteObject($hSource)
_WinAPI_DeleteObject($hBitmap)

; Free memory
_WinAPI_FreeMemory($pData)
