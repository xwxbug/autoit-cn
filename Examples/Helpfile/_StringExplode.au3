#include  <String.au3>
#include  <Array.au3>

$text = " 1##2##3##4##5##6##7##8 "
$array1 = _StringExplode($text, "## ", 0)
_arraydisplay($array1, "StringExplode 0 ")

;œ‘ æ
;[0] = 1
;[1] = 2
;[2] = 3
;[3] = 4
;[4] = 5
;[5] = 6
;[6] = 7
;[7] = 8

$array2 = _StringExplode($text, "## ", 4)
_arraydisplay($array2, "StringExplode 4 ")

;œ‘ æ
;[0] = 1
;[1] = 2
;[2] = 3
;[3] = 4
;[4] = 5##6##7##8

$array3 = _StringExplode($text, "## ", -3)
_arraydisplay($array3, "StringExplode -3 ")

;œ‘ æ
;[0] = 1
;[1] = 2
;[2] = 3
;[3] = 4
;[4] = 5

