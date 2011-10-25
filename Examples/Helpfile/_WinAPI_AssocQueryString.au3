#include  <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Ext = '.au3'

msgbox("", $Ext & '  File ', 'Type:' & _WinAPI_AssocQueryString($Ext, $ASSOCSTR_FRIENDLYDOCNAME) & @CRLF & _
		' Command:' & _WinAPI_AssocQueryString($Ext, $ASSOCSTR_COMMAND) & @CRLF & _
		' Executable:' & _WinAPI_AssocQueryString($Ext, $ASSOCSTR_EXECUTABLE) & @CRLF & _
		' Icon:' & _WinAPI_AssocQueryString($Ext, $ASSOCSTR_DEFAULTICON))

