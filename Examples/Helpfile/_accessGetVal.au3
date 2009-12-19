#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$adCol = 1
$yo = _accessGetVal($adSource, $adTable, $adCol)
MsgBox(0, "", $yo)