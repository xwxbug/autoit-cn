#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 281, 281)
Local $Pic = GUICtrlCreatePic('', 0, 0, 281, 281)
Local $hPic = GUICtrlGetHandle($Pic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 281, 281, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)
Local $hRgn = _WinAPI_CreateEllipticRgn(_WinAPI_CreateRectEx(40, 40, 201, 201))
_WinAPI_SelectClipRgn($hMemDC, $hRgn)
Local $aVertex[3][3] = [[140, -50, 0xFFFF00],[-50, 244, 0x00F0FF],[331, 244, 0xFF00FF]]
_WinAPI_GradientFill($hMemDC, $aVertex)
_WinAPI_DeleteObject($hRgn)
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
