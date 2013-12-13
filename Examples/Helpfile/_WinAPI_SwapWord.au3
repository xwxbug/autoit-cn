#include <WinAPIMisc.au3>

Local $Value = 0x1122

ConsoleWrite('0x' & Hex($Value, 4) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_SwapWord($Value), 4) & @CRLF)
