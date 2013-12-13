#include <WinAPIShPath.au3>
#include <APIREgConstants.au3>
#include <WinAPIReg.au3>

Local $Path = _WinAPI_AssocQueryString('.txt', $ASSOCSTR_COMMAND)

ConsoleWrite('Command: ' & $Path & @CRLF)
ConsoleWrite('Path: ' & _WinAPI_PathUnquoteSpaces(_WinAPI_PathRemoveArgs($Path)) & @CRLF)
ConsoleWrite('Arguments: ' & _WinAPI_PathGetArgs($Path) & @CRLF)
