#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Run(@SystemDir & '\calc.exe')
Local $hWnd = WinWaitActive("[CLASS:CalcFrame]", '', 3)
If Not $hWnd Then
	Exit
EndIf

; Create GUI
Local $Size = WinGetPos($hWnd)
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $Size[2] + 80, $Size[3] + 80)
Local $Pic = GUICtrlCreatePic('', 40, 40, $Size[2], $Size[3])
Local $hPic = GUICtrlGetHandle($Pic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $Size[2], $Size[3])
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBmp = _WinAPI_CreateCompatibleBitmap($hDC, $Size[2], $Size[3])
Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hBmp)
_WinAPI_PrintWindow($hWnd, $hSrcDC)
_WinAPI_BitBlt($hDestDC, 0, 0, $Size[2], $Size[3], $hSrcDC, 0, 0, $MERGECOPY)

_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_SelectObject($hSrcDC, $hSrcSv)
_WinAPI_DeleteDC($hDestDC)
_WinAPI_DeleteDC($hSrcDC)
_WinAPI_DeleteObject($hBmp)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

WinClose("[CLASS:CalcFrame]", "")
