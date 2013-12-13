#include <WinAPIShPath.au3>

Local $Data = _WinAPI_ParseURL('http://www.microsoft.com')

ConsoleWrite('Protocol: ' & $Data[0] & @CRLF)
ConsoleWrite('Suffix:   ' & $Data[1] & @CRLF)
ConsoleWrite('Scheme:   ' & $Data[2] & @CRLF)
