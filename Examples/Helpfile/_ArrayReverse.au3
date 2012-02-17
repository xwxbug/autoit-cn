#include <Array.au3>

Local $avArray[10] = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

_ArrayDisplay($avArray, "运行前")
_ArrayReverse($avArray)
_ArrayDisplay($avArray, "运行后反转数组顺序")
_ArrayReverse($avArray, 3, 6)
_ArrayDisplay($avArray, "运行后反转索引3到6的顺序")
