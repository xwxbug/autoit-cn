#include <Math.au3>

;find the greatest of 1,4,2,8,5,3
Dim $list[6] = [1,4,2,8,5,3]
$Max=_MaxLst($list)

;Display the value
MsgBox(0,"_MaxLst","The greatest of 1,4,2,8,5,3 is..."&$Max)
