#include <Date.au3>
; ISO Week day number for a given date 0=Monday - 6=Sunday
$iWeekday = _DateToDayOfWeekISO (@YEAR, @MON, @MDAY)
; NOT equal to @Wday
MsgBox(4096, "", "Todays ISO WeekdayNumber is: " & $iWeekDay)
