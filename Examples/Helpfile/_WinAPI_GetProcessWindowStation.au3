#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hObj[2] = [_WinAPI_GetProcessWindowStation(), _WinAPI_GetThreadDesktop( _WinAPI_GetCurrentThreadID())]
Global $result

For $i = 0 To 1
	If Not $i Then
		$result = ' -------------------------------' & @CRLF
	EndIf
	$result &= ' Handle:' & $hObj[$i] & @CRLF
	$result &= ' Type:' & _WinAPI_GetUserObjectInformation($hObj[$i], $UOI_TYPE) & @CRLF
	$result &= ' Name:' & _WinAPI_GetUserObjectInformation($hObj[$i], $UOI_NAME) & @CRLF
	$result &= ' -------------------------------' & @CRLF
Next
msgbox(0, 'Result ', $result)

