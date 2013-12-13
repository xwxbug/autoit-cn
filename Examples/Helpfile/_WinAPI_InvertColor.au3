#include <WinAPIGdi.au3>

Local $Color = 0xAADDFF

$Color = _WinAPI_InvertColor($Color)
ConsoleWrite('0x' & Hex($Color, 6) & @CRLF)
$Color = _WinAPI_InvertColor($Color)
ConsoleWrite('0x' & Hex($Color, 6) & @CRLF)
