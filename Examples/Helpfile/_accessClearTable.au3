#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
_accessClearTable($adSource, $adTable)