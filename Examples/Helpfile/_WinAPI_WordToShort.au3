#include <WinAPIMisc.au3>

Local $Value = 65535

ConsoleWrite(_WinAPI_WordToShort($Value) & @CRLF)
