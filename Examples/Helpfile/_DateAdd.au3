#include <Date.au3>

; 今天+5天
Local $sNewDate = _DateAdd('d', 5, _NowCalcDate())
MsgBox( 4096, "", "今天 + 5 天:" & $sNewDate )

; 今天减去两周
$sNewDate = _DateAdd('w', -2, _NowCalcDate())
MsgBox( 4096, "", "今天减去两周: " & $sNewDate )

; 当前时间 +15 分钟
$sNewDate = _DateAdd('n', 15, _NowCalc())
MsgBox( 4096, "", "当前时间 +15 分钟: " & $sNewDate )

; 计算从 1970/01/01 00:00:00 开始 经过 1087497645 秒后的时间
$sNewDate = _DateAdd('s', 1087497645, "1970/01/01 00:00:00")
MsgBox( 4096, "", "计算时间: " & $sNewDate )
