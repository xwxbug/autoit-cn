#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

Global $Url = ' http://social.msdn.microsoft.com/search/en-us?query=UrlEscape UrlUnescape '

msgbox('', '', _WinAPI_UrlEscape($Url, $URL_ESCAPE_SPACES_ONLY) & @CRLF & _WinAPI_UrlUnescape($Url))

