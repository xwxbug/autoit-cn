#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 100)
Local $Pic = GUICtrlCreatePic('', 20, 20, 360, 60)
Local $hPic = GUICtrlGetHandle($Pic)

; Create bitmap
Local $tRECT = _WinAPI_GetClientRect($hPic)
Local $Width = DllStructGetData($tRECT, 3) - DllStructGetData($tRECT, 1)
Local $Height = DllStructGetData($tRECT, 4) - DllStructGetData($tRECT, 2)
Local $hDC = _WinAPI_GetDC($hPic)
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $Width, $Height)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hSource = _WinAPI_CreateCompatibleBitmapEx($hDC, $Width, $Height, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hSource)
Local $hFont = _WinAPI_CreateFont(65, 0, 0, 0, $FW_NORMAL, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $ANTIALIASED_QUALITY, $DEFAULT_PITCH, 'Arial')
_WinAPI_SelectObject($hSrcDC, $hFont)
_WinAPI_DrawShadowText($hSrcDC, 'Shadow Text', 0xF06000, 0x808080, 3, 3, $tRECT, BitOR($DT_CENTER, $DT_SINGLELINE, $DT_VCENTER))
_WinAPI_BitBlt($hDestDC, 0, 0, $Width, $Height, $hSrcDC, 0, 0, $MERGECOPY)

_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteDC($hDestDC)
_WinAPI_SelectObject($hSrcDC, $hSrcSv)
_WinAPI_DeleteDC($hSrcDC)
_WinAPI_DeleteObject($hSource)
_WinAPI_DeleteObject($hFont)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
