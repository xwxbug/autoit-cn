
#include  <Date.au3>

; 从EPOCH(1970/01/01 00:00:00)开始计算的秒数
$iDateCalc = _DateDiff('s', "1970/01/01 00:00:00", _NowCalc())
msgbox(4096, "", "Number of seconds since EPOCH:" & $iDateCalc)

; 计算本年的小时数
$iDateCalc = _DateDiff('h', @YEAR & "/01/01 00:00:00", _NowCalc())
msgbox(4096, "", "Number of Hours this year:" & $iDateCalc)


