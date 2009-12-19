#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$adCol = "a"
$adQuery = "文本"
$adcCol = "a"
$adData = "文本文本"
$yo = _accessUpdateRecord($adSource, $adTable, $adCol, $adQuery, $adcCol, $adData)
MsgBox(0, "", $yo)