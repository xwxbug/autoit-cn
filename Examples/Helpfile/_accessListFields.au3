#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"

$yo = _accessListFields($adSource, $adTable)
MsgBox(0, "", $yo)