#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Data = _WinAPI_GetCurrentHwProfile(), $result

If IsArray($Data) Then
	$result = ' State:' & $Data[0] & @CRLF $result &= ' GUID:' & $Data[1] & @CRLF $result &= ' Name:' & $Data[2] EndIf

	msgbox(64, '_WinAPI_GetCurrentHwProfile ', $result)


;### Tidy Error -> if is never closed in your script.
