#include <WinAPIReg.au3>

Local $Ext = '.wav'
Local $Data = _WinAPI_AssocGetPerceivedType($Ext)

If IsArray($Data) Then
	ConsoleWrite('(' & $Ext & ')' & @CRLF)
	ConsoleWrite('--------------------' & @CRLF)
	ConsoleWrite('Type:   ' & $Data[0] & @CRLF)
	ConsoleWrite('Source: ' & $Data[1] & @CRLF)
	ConsoleWrite('String: ' & $Data[2] & @CRLF)
EndIf
