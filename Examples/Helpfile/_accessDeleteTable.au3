#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"

_accessDeleteTable($adSource, $adTable)
