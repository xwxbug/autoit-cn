
#include  <Date.au3>

; 给定日期的周的日序号
$iWeekday = _DateToDayOfWeek(@YEAR, @MON, @MDAY)
; 与@Wday相同
msgbox(4096, "", "Todays WeekdayNumber is:" & $iWeekday)
msgbox(4096, "", "Today is a :" & _DateDayOfWeek($iWeekday))

