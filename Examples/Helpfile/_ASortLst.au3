#include "Math.au3"

;make a list
Dim $anLst[3] = [3, 2, 1]
;display the list
MsgBox(0, "Initial List", String($anLst[0]) & String($anLst[1]) & String($anLst[2]))

;sort the list
$anLst = _ASortLst($anLst)
;display the sorted list
MsgBox(0, "Sorted List", String($anLst[0]) & String($anLst[1]) & String($anLst[2]))

