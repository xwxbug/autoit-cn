#include <Date.au3>

; 指定日期在一周中某天的数字
Local $iWeekday = _DateToDayOfWeek(@YEAR, @MON, @MDAY)
; 应该相当于 @Wday
MsgBox(4096, "", "Todays WeekdayNumber is: " & $iWeekday)
MsgBox(4096, "", "Today is a : " & _DateDayOfWeek($iWeekday))
