#include <WinAPIMisc.au3>
#include <WinAPI.au3>

Local $Value = _WinAPI_MakeQWord(0x55667788, 0x11223344)

ConsoleWrite('0x' & Hex($Value) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_SwapQWord($Value)) & @CRLF)
