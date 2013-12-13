#include <WinAPISys.au3>
#include <APISysConstants.au3>
#include <WinAPIGdi.au3>
#include <APIGdiConstants.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
#include <MsgBoxConstants.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

If (_WinAPI_GetVersion() < '6.1') Or (Not _WinAPI_DwmIsCompositionEnabled()) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later with enabled Aero theme.')
	Exit
EndIf

Local $Widht = @DesktopWidth / 2, $Height = @DesktopHeight / 2

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $Widht + 116, $Height + 51)
GUICtrlCreatePic('', 14, 14, $Widht + 2, $Height + 2, -1, $WS_EX_STATICEDGE)
GUICtrlSetState(-1, $GUI_DISABLE)
Local $hPic = GUICtrlGetHandle(-1)
Local $Check = GUICtrlCreateCheckbox('Protect against capture of window', 14, $Height + 23, 182, 21)
Local $Button = GUICtrlCreateButton('Capture', $Widht + 29, 13, 74, 25)
GUICtrlSetState(-1, BitOR($GUI_DEFBUTTON, $GUI_FOCUS))
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			_Capture()
		Case $Check
			If GUICtrlRead($Check) = $GUI_CHECKED Then
				_WinAPI_SetWindowDisplayAffinity($hForm, $WDA_MONITOR)
			Else
				_WinAPI_SetWindowDisplayAffinity($hForm, 0)
			EndIf
	EndSwitch
WEnd

Func _Capture()
	Local $hObj = _SendMessage($hPic, $STM_SETIMAGE, 0, 0)
	If $hObj Then
		_WinAPI_DeleteObject($hObj)
	EndIf
	Local $hDC = _WinAPI_GetDC($hPic)
	Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
	Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $Widht, $Height)
	Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
	Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
	$hObj = _ScreenCapture_Capture('', 0, 0, -1, -1, 0)
	Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hObj)
	_WinAPI_SetStretchBltMode($hDestDC, $HALFTONE)
	_WinAPI_StretchBlt($hDestDC, 0, 0, $Widht, $Height, $hSrcDC, 0, 0, @DesktopWidth, @DesktopHeight, $SRCCOPY)
	_WinAPI_ReleaseDC($hPic, $hDC)
	_WinAPI_SelectObject($hDestDC, $hDestSv)
	_WinAPI_DeleteDC($hDestDC)
	_WinAPI_SelectObject($hSrcDC, $hSrcSv)
	_WinAPI_DeleteObject($hObj)
	_WinAPI_DeleteDC($hSrcDC)
	_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
	$hObj = _SendMessage($hPic, $STM_GETIMAGE)
	If $hObj <> $hBitmap Then
		_WinAPI_DeleteObject($hBitmap)
	EndIf
EndFunc   ;==>_Capture
