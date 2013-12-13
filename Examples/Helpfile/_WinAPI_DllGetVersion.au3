#include <WinAPIShellEx.au3>
#include <APIShellExConstants.au3>

Global Const $sDll = @SystemDir & '\comctl32.dll'

Local $Text
Local $Data = _WinAPI_DllGetVersion($sDll)
Switch @error
	Case 0
		Switch $Data[3]
			Case $DLLVER_PLATFORM_WINDOWS
				$Text = 'Windows 95/98'
			Case $DLLVER_PLATFORM_NT
				$Text = 'NT-based'
			Case Else
				$Text = 'Unknown platform'
		EndSwitch
		ConsoleWrite($sDll & ' => ' & $Data[0] & '.' & $Data[1] & '.' & $Data[2] & ' (' & $Text & ')' & @CRLF)
	Case 3
		ConsoleWrite('DllGetVersion not implemented in ' & $sDll & '.' & @CRLF)
	Case Else
		ConsoleWrite('Unable to retrieve version information.' & @CRLF)
EndSwitch
