#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

; Load enhanced metafile (.emf) and retrieve it's dimension (x6)
Local $hEmf = _WinAPI_GetEnhMetaFile(@ScriptDir & '\Extras\Flag.emf')
Local $tSIZE = _WinAPI_GetEnhMetaFileDimension($hEmf)
Local $Width = 6 * DllStructGetData($tSIZE, 'X')
Local $Height = 6 * DllStructGetData($tSIZE, 'Y')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $Width, $Height)
Local $Pic = GUICtrlCreatePic('', 0, 0, $Width, $Height)
Local $hPic = GUICtrlGetHandle($Pic)

; Create bitmap from enhanced metafile
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, $Width, $Height, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)
Local $tRECT = _WinAPI_CreateRectEx(0, 0, $Width, $Height)
_WinAPI_PlayEnhMetaFile($hMemDC, $hEmf, $tRECT)

_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; Release enhanced metafile
_WinAPI_DeleteEnhMetaFile($hEmf)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
