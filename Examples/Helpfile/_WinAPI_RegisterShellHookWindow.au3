#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hForm

$hForm = GUICreate('')
GUIRegisterMsg( _WinAPI_RegisterWindowMessage('SHELLHOOK'), '_ShellHookProc')
_WinAPI_RegisterShellHookWindow($hForm)

While 1
	Sleep(100)
WEnd

Func _ShellHookProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $hWnd
		Case $hForm
			Switch $wParam
				Case $HSHELL_WINDOWACTIVATED

					Local $Title = WinGetTitle($lParam)

					If IsString($Title) Then
						MsgBox('', 'Activated ', $Title)
					EndIf
			EndSwitch
	EndSwitch endfunc ;==>_ShellHookProc

;### Tidy Error -> func Not closed before "Func" statement.
;### Tidy Error -> "func" cannot be inside any IF/Do/While/For/Case/Func statement.
	Func OnAutoItExit()
		_WinAPI_DeregisterShellHookWindow($hForm)
	endfunc   ;==>OnAutoItExit


;### Tidy Error -> func is never closed in your script.
