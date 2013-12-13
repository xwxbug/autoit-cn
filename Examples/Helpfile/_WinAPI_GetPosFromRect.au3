#include <WinAPIGdi.au3>

Local $Pos = _WinAPI_GetPosFromRect(_WinAPI_CreateRectEx(10, 10, 100, 100))

ConsoleWrite('Left:   ' & $Pos[0] & @CRLF)
ConsoleWrite('Top:    ' & $Pos[1] & @CRLF)
ConsoleWrite('Width:  ' & $Pos[2] & @CRLF)
ConsoleWrite('Height: ' & $Pos[3] & @CRLF)
