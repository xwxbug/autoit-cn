#include <WinAPIShPath.au3>

Local $Data = _WinAPI_ParseUserName('ALX\Alexander')

ConsoleWrite('Domain: ' & $Data[0] & @CRLF)
ConsoleWrite('User:   ' & $Data[1] & @CRLF)
