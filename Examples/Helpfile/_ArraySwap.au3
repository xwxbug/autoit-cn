#include <Array.au3>

Local $avArray[2]

$avArray[0] = "World!"
$avArray[1] = "Hello"

_ArrayDisplay($avArray, "默认值")
_ArraySwap($avArray[0], $avArray[1])
_ArrayDisplay($avArray, "互换两个项目")
