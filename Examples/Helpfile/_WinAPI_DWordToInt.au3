#include <WinAPIMisc.au3>

Local $Value = 4294967295

ConsoleWrite(_WinAPI_DWordToInt($Value) & @CRLF)
