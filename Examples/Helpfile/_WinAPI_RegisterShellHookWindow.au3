#include <WinAPISys.au3>
#include <APISysConstants.au3>

Opt('TrayAutoPause', 0)

OnAutoItExitRegister('OnAutoItExit')

Global $hForm = GUICreate('')
GUIRegisterMsg(_WinAPI_RegisterWindowMessage('SHELLHOOK'), 'WM_SHELLHOOK')
_WinAPI_RegisterShellHookWindow($hForm)

While 1
	Sleep(1000)
WEnd

Func WM_SHELLHOOK($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg

	Switch $hWnd
		Case $hForm
			Switch $wParam
				Case $HSHELL_WINDOWACTIVATED
					Local $Title = WinGetTitle($lParam)

					If IsString($Title) Then
						ConsoleWrite('Activated: ' & $Title & @CRLF)
					EndIf
			EndSwitch
	EndSwitch
EndFunc   ;==>WM_SHELLHOOK

Func OnAutoItExit()
	_WinAPI_DeregisterShellHookWindow($hForm)
EndFunc   ;==>OnAutoItExit
