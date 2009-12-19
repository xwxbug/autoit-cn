#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"

_accessCreateDB($adSource)
MsgBox(0, "提示", "数据库创建成功，创建路径在：" & $adSource)