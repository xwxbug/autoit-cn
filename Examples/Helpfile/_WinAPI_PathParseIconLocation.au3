#include <WinAPIShPath.au3>
#include <WinAPIReg.au3>
#include <APIRegConstants.au3>

Local $Data = _WinAPI_AssocQueryString('.txt', $ASSOCSTR_DEFAULTICON)
Local $Icon = _WinAPI_PathParseIconLocation($Data)

If IsArray($Icon) Then
	ConsoleWrite('DefaultIcon: ' & $Data & @CRLF)
	ConsoleWrite('Icon: ' & $Icon[0] & @CRLF)
	ConsoleWrite('Index: ' & $Icon[1] & @CRLF)
EndIf
