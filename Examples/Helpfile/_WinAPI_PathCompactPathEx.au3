#include <WinAPIShPath.au3>

Local $Path = @ScriptFullPath

ConsoleWrite('Before: ' & $Path & @CRLF)
ConsoleWrite('After : ' & _WinAPI_PathCompactPathEx($Path, 40) & @CRLF)
