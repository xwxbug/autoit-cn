#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>

Local $ID = _WinAPI_GetUserDefaultLCID()

ConsoleWrite('Language => ' & _WinAPI_GetLocaleInfo($ID, $LOCALE_SLANGUAGE) & @CRLF)
ConsoleWrite('Date format => ' & _WinAPI_GetLocaleInfo($ID, $LOCALE_SSHORTDATE) & @CRLF)
ConsoleWrite('Time format => ' & _WinAPI_GetLocaleInfo($ID, $LOCALE_STIMEFORMAT) & @CRLF)
ConsoleWrite('Currency name => ' & _WinAPI_GetLocaleInfo($ID, $LOCALE_SNATIVECURRNAME) & @CRLF)
ConsoleWrite('Monetary symbol => ' & _WinAPI_GetLocaleInfo($ID, $LOCALE_SCURRENCY) & @CRLF)
