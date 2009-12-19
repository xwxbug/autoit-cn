#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$adCol = "a TEXT(10) | b MEMO | c COUNTER | d INTEGER | e YESNO | f DATETIME | g CURRENCY | h OLEOBJECT"

_accessCreateDB($adSource);在脚本目录创建DB1.mdb数据库
_accessCreateTable($adSource, $adTable, $adCol);在DB1.mdb数据库中创建表
MsgBox(0, "提示", "数据库<" & $adTable & ">表创建成功，创建内容为" & $adCol)