#include <Date.au3>

; 获取长名称
Local $sLongMonthName = _DateToMonth(@MON)

; 获取简称
Local $sShortMonthName = _DateToMonth(@MON, 1)

MsgBox(4096, "Month of Year", "The month is: " & $sLongMonthName & " (" & $sShortMonthName & ")")
