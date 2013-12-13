#include <WinAPIMisc.au3>

Local $Value = Int('0x1111111122222222')

ConsoleWrite('0x' & Hex(_WinAPI_HiDWord($Value)) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_LoDWord($Value)) & @CRLF)
