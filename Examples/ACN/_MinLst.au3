#include <Math.au3>

;find the lowest of 1,4,2,8,5,3
Dim $list[6] = [1,4,2,8,5,3]
$Min=_MinLst($list)

;Display the value
MsgBox(0,"_MinLst","The lowest of 1,4,2,8,5,3 is..."&$Min)
