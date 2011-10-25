#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$oFile = @ScriptDir & "\DB1"
_accessSaveXML($adSource, $adTable, $oFile)
