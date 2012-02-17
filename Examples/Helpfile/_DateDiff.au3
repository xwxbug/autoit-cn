#include <Date.au3>

; 计算一个跨越世纪后的秒数,(从1970/01/01 00:00:00) 
Local $iDateCalc = _DateDiff('s', "1970/01/01 00:00:00", _NowCalc())
MsgBox( 4096, "", "和现在比较经过的秒数: " & $iDateCalc )

; 计算今年经过的小时数
$iDateCalc = _DateDiff('h', @YEAR & "/01/01 00:00:00", _NowCalc())
MsgBox( 4096, "", "计算今年经过的小时数: " & $iDateCalc )
