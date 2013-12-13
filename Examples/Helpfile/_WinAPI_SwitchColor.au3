#include <WinAPIGdi.au3>

Local $Color = 0xAADDFF

$Color = _WinAPI_SwitchColor($Color)
ConsoleWrite('0x' & Hex($Color, 6) & @CRLF)
$Color = _WinAPI_SwitchColor($Color)
ConsoleWrite('0x' & Hex($Color, 6) & @CRLF)
