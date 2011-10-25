#include <Array.au3>

Local $avArray[2]

$avArray[0] = " World! "
$avArray[1] = " Hello "

_arraydisplay($avArray, "$avArray BEFORE _ArraySwap() ")
_ArraySwap($avArray[0], $avArray[1])
_arraydisplay($avArray, "$avArray AFTER _ArraySwap() ")

