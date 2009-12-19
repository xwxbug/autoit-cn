#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"

$yo = _accessListTables($adSource)
MsgBox(0, "", $yo)