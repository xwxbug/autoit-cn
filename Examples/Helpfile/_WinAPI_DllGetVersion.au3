#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global Const $sDll = @SystemDir & ' \comctl32.dll '

Global $Data, $Text

$Data = _WinAPI_DllGetVersion($sDll)
Switch @error
	Case 0
		Switch $Data[3]
			Case $DLLVER_PLATFORM_WINDOWS
				$Text = ' Windows 95/98 '
			Case $DLLVER_PLATFORM_NT
				$Text = ' NT-based '
			Case Else
				$Text = ' Unknown platform '
		EndSwitch
		msgbox(0, 'dll version ', $sDll & '  =>' & $Data[0] & ' .' & $Data[1] & ' .' & $Data[2] & '  ('& $Text & ' )')
	Case 3
		msgbox(0, 'error ', 'DllGetVersion not implemented in' & $sDll & ' .')
	Case Else
		msgbox(0, 'error ', 'Unable to retrieve version information.')
EndSwitch

