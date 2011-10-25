#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

msgbox('', '', _WinAPI_UrlCreateFromPath(@ScriptFullPath) & @CRLF & _WinAPI_UrlCreateFromPath(@ScriptName))

