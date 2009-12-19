#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
$adTable = "Computer"
$adCol = "a TEXT(255) | b MEMO | c COUNTER | d INTEGER | e YESNO | f DATETIME | g CURRENCY | h OLEOBJECT"
$rData = "文本 | 备注 | 1 | 111";在DB1.mdb数据库中添加新记录，输入的必须是工作类型相应数据

_accessCreateDB($adSource);在脚本目录创建DB1.mdb数据库
_accessCreateTable($adSource, $adTable, $adCol);在DB1.mdb数据库中创建表
$yo = _accessAddRecord($adSource, $adTable, $rData, $adCol = 0);在DB1.mdb数据库中添加新记录
MsgBox(0, "提示", "数据库添加新记录<" & $rData & ">成功")