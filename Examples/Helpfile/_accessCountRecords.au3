#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"

$yo = _accessCountRecords($adSource, $adTable)
MsgBox(0, '纪录数', '本表有' & _accessCountRecords($adSource, $adTable) & '条数据记录')