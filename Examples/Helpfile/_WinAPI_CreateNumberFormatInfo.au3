#include <WinAPILocale.au3>

Local $Number = '123456789'

ConsoleWrite(_WinAPI_GetNumberFormat(0, $Number) & @CRLF)
ConsoleWrite(_WinAPI_GetNumberFormat(0, $Number, _WinAPI_CreateNumberFormatInfo(0, 1, 3, '', ',', 1)) & @CRLF)
