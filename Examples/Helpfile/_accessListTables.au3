#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"

$yo = _accessListTables($adSource)
msgbox(0, "", $yo)
