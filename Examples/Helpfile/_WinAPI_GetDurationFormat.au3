#include <WinAPILocale.au3>

Local $Duration = (90 * 60 + 14) * 1000 * 1000 * 10

ConsoleWrite(_WinAPI_GetDurationFormat(0, $Duration, 'hh:mm:ss') & @CRLF)
ConsoleWrite(_WinAPI_GetDurationFormat(0, $Duration, 'mm:ss') & @CRLF)
ConsoleWrite(_WinAPI_GetDurationFormat(0, $Duration, 'ss') & @CRLF)
