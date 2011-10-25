
#include  <Date.au3>

If _DateIsLeapYear(@YEAR) Then
	msgbox(4096, "Leap Year", "This year is a leap year.")
Else
	msgbox(4096, "Leap Year", "This year is not a leap year.")
EndIf

