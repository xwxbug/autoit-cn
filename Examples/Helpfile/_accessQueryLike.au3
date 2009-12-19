#include <Access.au3>
#include <Array.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$adCol = "a"
$Find = ""
$adFull = 1
$yo = _accessQueryLike($adSource, $adTable, $adCol, $Find, $adFull)
_ArrayDisplay($yo, "返回值")
$aRecord = StringSplit($yo[1], Chr(28))
_ArrayDisplay($aRecord, "每个值")