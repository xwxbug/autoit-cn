#include <String.au3>
#include <array.au3>
$aArray1 = _StringBetween('[18][20][3][5][500][60]', '[', ']');Not using SRE
_ArrayDisplay($aArray1, 'Default Search')
$aArray2 = _StringBetween('[18][20][3][5][500][60]', '\[', '\]', -1, 1);Using SRE
_ArrayDisplay($aArray2, 'StringRegExp Search')