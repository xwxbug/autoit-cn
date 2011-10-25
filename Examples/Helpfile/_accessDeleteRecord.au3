#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$adCol = "a"
$Find = "A1"
$adOcc = "0"
$yo = _accessDeleteRecord($adSource, $adTable, $adCol, $Find, $adOcc)
msgbox(0, "", $yo)
