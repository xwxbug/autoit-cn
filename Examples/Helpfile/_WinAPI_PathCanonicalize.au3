#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Path[5] = [' A:\Dir1\.\Dir2\..\Dir3 ', 'A:\Dir1\..\Dir2\.\Dir3 ', 'A:\Dir1\Dir2\.\Dir3\..\Dir4 ', 'A:\Dir1\.\Dir2\.\Dir3\..\Dir4\.. ', 'A:\.. ']
Local $result

For $i = 0 To 4
	$result &= $Path[$i] & '  =>' & _WinAPI_PathCanonicalize($Path[$i]) & @CRLF
Next

msgbox(0, 'result ', $$result)

