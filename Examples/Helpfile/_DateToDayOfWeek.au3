#include <Date.au3>

; Week day number for a given date
$iWeekday = _DateToDayOfWeek (@YEAR, @MON, @MDAY)
; Should be equal to @Wday
MsgBox(4096, "", "Todays WeekdayNumber is: " & $iWeekDay)
MsgBox(4096, "", "Today is a : " & _DateDayOfWeek($iWeekDay))
