#include <Date.au3>

; 指定日期的 ISO 星期序号 0=星期一 - 6=星期天
Local $iWeekday = _DateToDayOfWeekISO(@YEAR, @MON, @MDAY)
; 不同于 @Wday
MsgBox(4096, "", "Todays ISO WeekdayNumber is: " & $iWeekday)
