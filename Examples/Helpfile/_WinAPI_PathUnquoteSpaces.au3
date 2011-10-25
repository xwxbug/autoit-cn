#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path = _WinAPI_AssocQueryString('.txt ', $ASSOCSTR_COMMAND)

msgbox(0, 'Result ', 'Command:' & $Path & @CRLF & _
		' Path:' & _WinAPI_PathUnquoteSpaces( _WinAPI_PathRemoveArgs($Path) @CRLF & _
		' Arguments:' & _WinAPI_PathGetArgs($Path))

