#include <File.au3>

Local $aRecords
If Not _FileReadToArray("error.log", $aRecords) Then
	MsgBox(4096, "´íÎó", " Error reading log to Array     error:" & @error)
	Exit
EndIf
For $x = 1 To $aRecords[0]
	MsgBox(4096, 'Record:' & $x, $aRecords[$x])
Next
