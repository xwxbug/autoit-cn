#include <WinAPIShPath.au3>

Local $Path[5] = ['c:\path\file', 'c:\', 'c:', 'nodrive', StringFormat('d: %270s', '2')]

For $i = 0 To UBound($Path) - 2
	ConsoleWrite($Path[$i] & ' => ' & _WinAPI_PathGetDriveNumber($Path[$i]) & @CRLF)
Next

Local $Ret = _WinAPI_PathGetDriveNumber($Path[UBound($Path) - 1])
ConsoleWrite('TOO LONG STRING : @error = ' & @error & ' => "' & $Ret & '"' & @CRLF)
