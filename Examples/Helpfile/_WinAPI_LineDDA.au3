#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Global $Count = 0, $Color = True
Local $hLineProc = DllCallbackRegister('_LineProc', 'none', 'int;int;lparam')
Local $pLineProc = DllCallbackGetPtr($hLineProc)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 280, 280)
Local $Pic = GUICtrlCreatePic('', 0, 0, 281, 281)
Local $hPic = GUICtrlGetHandle($Pic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 280, 280, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)
_WinAPI_LineDDA(40, 40, 240, 40, $pLineProc, $hMemDC)
_WinAPI_LineDDA(240, 40, 240, 240, $pLineProc, $hMemDC)
_WinAPI_LineDDA(240, 240, 40, 240, $pLineProc, $hMemDC)
_WinAPI_LineDDA(40, 240, 40, 40, $pLineProc, $hMemDC)
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

DllCallbackFree($hLineProc)

Func _LineProc($iX, $iY, $hDC)
	If Not Mod($Count, 10) Then
		$Color = Not $Color
	EndIf
	If $Color Then
		_WinAPI_SetPixel($hDC, $iX, $iY, 0xFF0000)
	Else
		_WinAPI_SetPixel($hDC, $iX, $iY, 0xFFFFFF)
	EndIf
	$Count += 1
EndFunc   ;==>_LineProc
