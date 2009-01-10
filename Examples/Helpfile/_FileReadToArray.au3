#include <file.au3>
Dim $aRecords
If Not _FileReadToArray("error.log",$aRecords) Then
   MsgBox(4096,"Error", " Error reading log to Array     error:" & @error)
   Exit
EndIf
For $x = 1 to $aRecords[0]
	Msgbox(0,'Record:' & $x, $aRecords[$x])
Next
