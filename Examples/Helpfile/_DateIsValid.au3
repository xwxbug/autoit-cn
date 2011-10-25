
#include  <Date.au3>

$sDate = @YEAR & "/" & @MON & "/" & @MDAY

If _DateIsValid($sDate) Then
	msgbox(4096, "Valid Date", "The specified date is valid.")
Else
	msgbox(4096, "Valid Date", "The specified date is invalid.")
EndIf

