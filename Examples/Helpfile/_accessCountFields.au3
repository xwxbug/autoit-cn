#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$yo = _accessCountFields($adSource, $adTable)
msgbox(0, "", $yo)
