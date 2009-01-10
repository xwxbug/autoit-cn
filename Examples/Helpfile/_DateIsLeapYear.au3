#include <Date.au3>

If _DateIsLeapYear( @YEAR ) Then
	MsgBox( 4096, "闰年", "今年是闰年,有366天(有闰月除外)." )
Else
	MsgBox( 4096, "闰年", "今年不是闰年." )
EndIf
