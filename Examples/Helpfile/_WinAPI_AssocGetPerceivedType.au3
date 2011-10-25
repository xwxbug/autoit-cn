#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Ext = ' .wav '
Global $Data = _WinAPI_AssocGetPerceivedType($Ext)

If IsArray($Data) Then
	msgbox('', '('& $Ext & ' ) ', 'Type:' & $Data[0] & @CRLF & _
			' Source:' & $Data[1] & @CRLF & ' String:' & $Data[2])
EndIf

