#include <Array.au3>

Local $avArray[20]

; 为测试数组的元素赋值.
For $i = 0 To UBound($avArray) - 1
	$avArray[$i] = Random(-20000, 20000, 1)
Next

_ArrayDisplay($avArray, "$avArray")

MsgBox(4096, "_ArrayToString() getting $avArray items 1 to 7", _ArrayToString($avArray, @TAB, 1, 7))
