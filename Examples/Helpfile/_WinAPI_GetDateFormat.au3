#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>

ConsoleWrite(_WinAPI_GetDateFormat() & @CRLF)
ConsoleWrite(_WinAPI_GetDateFormat(0, 0, $DATE_LONGDATE) & @CRLF)
ConsoleWrite(_WinAPI_GetDateFormat(0, 0, 0, 'dddd dd, yyyy') & @CRLF)
