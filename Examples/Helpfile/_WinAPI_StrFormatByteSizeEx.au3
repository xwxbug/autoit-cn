#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Val[5] = [532, 1340, 23506, 240016, 2400000000]
Local $result

For $i = 0 To 4
	$result &= StringFormat('%10s %19s ', $Val[$i], _WinAPI_StrFormatByteSizeEx($Val[$i])) & @CRLF
Next

msgbox(0, 'result ', $$result)

