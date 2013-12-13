#include <WinAPIMisc.au3>

Local $Value = 0x11223344

ConsoleWrite('0x' & Hex($Value) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_SwapDWord($Value)) & @CRLF)
