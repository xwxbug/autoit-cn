#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

Global $Data = _WinAPI_AssocQueryString('.txt ', $ASSOCSTR_DEFAULTICON)
Global $Icon = _WinAPI_PathParseIconLocation($Data)
If IsArray($Icon) Then
	msgbox(0, 'Info ', 'DefaultIcon:' & $Data & @CRLF & _
			' Icon:' & $Icon[0] & @CRLF & _
			' Index:' & $Icon[1])
EndIf

