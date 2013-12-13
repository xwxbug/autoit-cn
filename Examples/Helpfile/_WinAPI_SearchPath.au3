#include <WinAPIFiles.au3>

Global Const $File = 'Notepad.exe'

ConsoleWrite(_WinAPI_SearchPath($File) & @CRLF)
ConsoleWrite(_WinAPI_SearchPath($File, @SystemDir) & @CRLF)
