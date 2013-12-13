#include <WinAPIShPath.au3>

Local $Path[5] = ['A:\Dir1\.\Dir2\..\Dir3', 'A:\Dir1\..\Dir2\.\Dir3', 'A:\Dir1\Dir2\.\Dir3\..\Dir4', 'A:\Dir1\.\Dir2\.\Dir3\..\Dir4\..', 'A:\..']

For $i = 0 To 4
	ConsoleWrite($Path[$i] & ' => ' & _WinAPI_PathCanonicalize($Path[$i]) & @CRLF)
Next
