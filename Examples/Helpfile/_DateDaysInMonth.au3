
#include  <Date.au3>

$iDays = _DateDaysInMonth(@YEAR, @MON)
msgbox(4096, "Days in Month", "This month has" & String($iDays) & " days in it.")

