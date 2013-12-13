#include <WinAPIShPath.au3>
#include <WinAPIReg.au3>
#include <APIRegConstants.au3>

Local $Path = _WinAPI_AssocQueryString('.txt', $ASSOCSTR_COMMAND)
ConsoleWrite('Command: ' & $Path & @CRLF)
ConsoleWrite('Path: ' & _WinAPI_PathRemoveArgs($Path) & @CRLF)
ConsoleWrite('Arguments: ' & _WinAPI_PathGetArgs($Path) & @CRLF & @CRLF)

$Path = '1 2 3'
ConsoleWrite('Command: ' & $Path & @CRLF)
ConsoleWrite('Path: ' & _WinAPI_PathRemoveArgs($Path) & @CRLF)
ConsoleWrite('Arguments: ' & _WinAPI_PathGetArgs($Path) & @CRLF & @CRLF)

$Path = StringFormat('very long string %260s', "1")
ConsoleWrite('Command: ' & $Path & @CRLF)
ConsoleWrite('Path: ' & _WinAPI_PathRemoveArgs($Path) & @CRLF)
ConsoleWrite('Arguments: "' & _WinAPI_PathGetArgs($Path) & '"' & @CRLF & @CRLF)
