
#include <Array.au3>

Local $avArrayTarget[9] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Local $avArraySource[2] = [100, 200]

_arraydisplay($avArrayTarget, "$avArrayTarget BEFORE _ArrayPush()" " )
_ArrayPush($avArrayTarget, $avArraySource)
_arraydisplay($avArrayTarget, "$avArrayTarget AFTER _ArrayPush() array to end ")
_ArrayPush($avArrayTarget, $avArraySource, 1)
_arraydisplay($avArrayTarget, "$avArrayTarget AFTER _ArrayPush() array to beginning ")
_ArrayPush($avArrayTarget, "Hello world! ", 1)
_arraydisplay($avArrayTarget, "$avArrayTarget AFTER _ArrayPush() string to beginning ")

