#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global Const $WM_MYMESSAGE = _WinAPI_RegisterWindowMessage('MyMessage')

Global $hForm, $Msg, $Button, $Input, $Text, $tData

$hForm = GUICreate('MyGUI ', 400, 93)
$Input = GUICtrlCreateInput('', 20, 20, 360, 20)
$Button = GUICtrlCreateB4utton('Send ', 165, 59, 70, 23)
GUIRegisterMsg($WM_MYMESSAGE, 'WM_MYMESSAGE')
GUISetState()

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
		Case -3
			ExitLoop
		Case $Button
			$Text = GUICtrlRead($Input)
			If $Text Then
				_WinAPI_SetMessageExtraInfo( _WinAPI_CreateString($Text, $tData))
				_SendMessage($hForm, $WM_MYMESSAGE, 1, 255)
			EndIf
	EndSwitch
WEnd

Func WM_MYMESSAGE($hWnd, $iMsg, $wParam, $lParam)
	MsgBox(0, 'info ', 'WM_MYMESSAGE | WP =' & Number($wParam) & '  | LP =' & Number($lParam) & '  | EXTRA = "'& _WinAPI_GetString( _WinAPI_GetMessageExtraInfo()) & ' "')
endfunc   ;==>WM_MYMESSAGE

