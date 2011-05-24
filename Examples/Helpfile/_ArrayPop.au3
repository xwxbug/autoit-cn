#include <Array.au3>

Local $avArray[10]

$avArray[0] = "JPM"
$avArray[1] = "Holger"
$avArray[2] = "Jon"
$avArray[3] = "Larry"
$avArray[4] = "Jeremy"
$avArray[5] = "Valik"
$avArray[6] = "Cyberslug"
$avArray[7] = "Nutster"
$avArray[8] = "JdeB"
$avArray[9] = "Tylo"

MsgBox(0,"提示", "将会在列表视图中显示运行_ArrayPop()之前的一维或二维数组")
_ArrayDisplay($avArray, "运行前")
While UBound($avArray)
	MsgBox(0,"返回值提示", "将会返回数组的最后一个元素：" & _ArrayPop($avArray))
	_ArrayDisplay($avArray, "运行后")
WEnd
