#include <WinAPIDlg.au3>
#include <APIDlgConstants.au3>
#include <WinAPISys.au3>
#include <MsgBoxConstants.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $Data = _WinAPI_ShellUserAuthenticationDlgEx('Authentication', 'To continue, type a login and password, and then click OK.', '', '', BitOR($CREDUIWIN_ENUMERATE_CURRENT_USER, $CREDUIWIN_CHECKBOX))
If @error Then Exit

Local $User = _WinAPI_ParseUserName($Data[0])
If @error Then
	Exit
EndIf

ConsoleWrite('Domain:   ' & $User[0] & @CRLF)
ConsoleWrite('User:     ' & $User[1] & @CRLF)
ConsoleWrite('Password: ' & $Data[1] & @CRLF)
ConsoleWrite('Save:     ' & $Data[2] & @CRLF)
ConsoleWrite('Package:  ' & $Data[3] & @CRLF)
