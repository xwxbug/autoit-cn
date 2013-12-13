#include <WinAPIShPath.au3>

Local $Path[7] = ['c:\path\file', 'c:\path', 'c:\path\', 'c:\', 'c:', 'path', StringFormat('Long String %270s', '1')]

For $i = 0 To UBound($Path) - 2
	ConsoleWrite($Path[$i] & ' => ' & _WinAPI_PathFindFileName($Path[$i]) & @CRLF)
Next

Local $Ret = _WinAPI_PathFindFileName($Path[UBound($Path) - 1])
ConsoleWrite('@error = ' & @error & ' => "' & $Ret & '"' & @CRLF)
