#include <Access.au3>
Dim $yo
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$adCol = "a"
$Find = "文本1"
$yo = _accessQueryStr($adSource, $adTable, $adCol, $Find)
msgbox(0, "1", $yo);成功则返回字段的值，失败则返回空字符串
