#include <WinAPIMisc.au3>

Local $Value = 0x00FA0000

ConsoleWrite('0x' & Hex(_WinAPI_LongMid($Value, 16, 4)) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_LongMid($Value, 20, 4)) & @CRLF)
