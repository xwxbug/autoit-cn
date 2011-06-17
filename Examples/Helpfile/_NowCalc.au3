#include <Date.au3>

; 计算从 EPOCH (1970/01/01 00:00:00) 开始起的秒数
Local $iDateCalc = _DateDiff('s', "1970/01/01 00:00:00", _NowCalc())
MsgBox(4096, "", "Number of seconds since EPOCH: " & $iDateCalc)

; 计算今年至今的小时数
$iDateCalc = _DateDiff('h', @YEAR & "/01/01 00:00:00", _NowCalc())
MsgBox(4096, "", "Number of Hours this year: " & $iDateCalc)
