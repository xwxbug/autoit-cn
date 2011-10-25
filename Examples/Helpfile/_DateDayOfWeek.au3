
#include  <Date.au3>

; 获取长名称
$sLongDayName = _DateDayOfWeek(@WDAY)

; 获取省略名称
$sShortDayName = _DateDayOfWeek(@WDAY, 1)

msgbox(4096, "Day of Week", "Today is:" & $sLongDayName & " (" & $sShortDayName & ")")

