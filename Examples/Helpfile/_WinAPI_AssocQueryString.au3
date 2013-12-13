#include <WinAPIReg.au3>
#include <APIRegConstants.au3>

Local $Ext = '.au3'

ConsoleWrite('(' & $Ext & ')' & @CRLF)
ConsoleWrite('--------------------' & @CRLF)
ConsoleWrite('Type: ' & _WinAPI_AssocQueryString($Ext, $ASSOCSTR_FRIENDLYDOCNAME) & @CRLF)
ConsoleWrite('Command: ' & _WinAPI_AssocQueryString($Ext, $ASSOCSTR_COMMAND) & @CRLF)
ConsoleWrite('Executable: ' & _WinAPI_AssocQueryString($Ext, $ASSOCSTR_EXECUTABLE) & @CRLF)
ConsoleWrite('Icon: ' & _WinAPI_AssocQueryString($Ext, $ASSOCSTR_DEFAULTICON) & @CRLF)
