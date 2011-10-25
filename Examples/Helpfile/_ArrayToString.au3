#include <Array.au3>

Dim $avArray[20]

; Ìî³ä²âÊÔÊı×é
For $i = 0 to UBound($avArray) - 1
	$avArray[$i] = Random(-20000, 20000, 1)
Next

_ArrayDisplay($avArray, "$avArray ")

msgbox(0, "_ArrayToString() getting $avArray items 1 to 7 ", _ArrayToString($avArray, @TAB, 1, 7))

