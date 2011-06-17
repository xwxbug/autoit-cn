#include <Date.au3>

; 今天的儒略日 (Julian date).
Local $sJulDate = _DateToDayValue(@YEAR, @MON, @MDAY)
MsgBox(4096, "", "Todays Julian date is: " & $sJulDate)

; 计算 14 天之前.
Local $Y, $M, $D
$sJulDate = _DayValueToDate($sJulDate - 14, $Y, $M, $D)
MsgBox(4096, "", "14 days ago:" & $M & "/" & $D & "/" & $Y & "  (" & $sJulDate & ")")
