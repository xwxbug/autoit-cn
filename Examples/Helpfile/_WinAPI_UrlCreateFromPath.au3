#include <WinAPIShPath.au3>

Local $Path = @ScriptFullPath

$Path = _WinAPI_UrlCreateFromPath($Path)
ConsoleWrite($Path & @CRLF)

$Path = _WinAPI_PathCreateFromUrl($Path)
ConsoleWrite($Path & @CRLF)
