#include <WinAPIShPath.au3>

Local $Path = _WinAPI_PathRelativePathTo(@ScriptDir, 1, @MyDocumentsDir, 1)

ConsoleWrite('Relative path: ' & $Path & @CRLF)

If $Path Then
	ShellExecute($Path)
EndIf
