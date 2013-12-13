#include <WinAPIShPath.au3>

Local $Path = @SystemDir

ConsoleWrite('Before: ' & $Path & @CRLF)
ConsoleWrite('After : ' & _WinAPI_PathUnExpandEnvStrings($Path) & @CRLF)
