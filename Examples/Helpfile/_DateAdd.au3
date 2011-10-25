
#include  <Date.au3>

; 今天加5天
$sNewDate = _DateAdd('d', 5, _NowCalcDate())
msgbox(4096, "", "Today + 5 days:" & $sNewDate)

; 今天减2周
$sNewDate = _DateAdd('w', -2, _NowCalcDate())
msgbox(4096, "", "Today minus 2 weeks:" & $sNewDate)

; 当前时间加15分
$sNewDate = _DateAdd('n', 15, _NowCalc())
msgbox(4096, "", "Current time +15 minutes:" & $sNewDate)

; 可返回从1970/01/01 00:00:00以来的秒的计算后的事件日志日期
$sNewDate = _DateAdd('s', 1087497645, "1970/01/01 00:00:00")
msgbox(4096, "", "Date:" & $sNewDate)

