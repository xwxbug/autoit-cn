#include <WinAPIRes.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>

Global $Duration = Default, $hBitmap = _WinAPI_CreateSolidBitmap(0, 0x00AEFF, 10, 14)

OnAutoItExitRegister('OnAutoItExit')

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 93)
Local $Input = GUICtrlCreateInput('', 20, 20, 360, 20)
Local $Button = GUICtrlCreateButton('Exit', 165, 59, 70, 23)
GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $Button
			ExitLoop
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg

	Switch $hWnd
		Case $hForm
			Switch _WinAPI_LoWord($wParam)
				Case $Input
					Switch _WinAPI_HiWord($wParam)
						Case $EN_KILLFOCUS
							_WinAPI_HideCaret($lParam)
							_WinAPI_DestroyCaret()
							_WinAPI_SetCaretBlinkTime($Duration)
							$Duration = Default
						Case $EN_SETFOCUS
							$Duration = _WinAPI_SetCaretBlinkTime(-1)
							_WinAPI_CreateCaret($lParam, $hBitmap)
							_WinAPI_ShowCaret($lParam)
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func OnAutoItExit()
	_WinAPI_DeleteObject($hBitmap)
	If Not IsKeyword($Duration) Then
		_WinAPI_SetCaretBlinkTime($Duration)
	EndIf
EndFunc   ;==>OnAutoItExit
