#include <Access.au3>
$adSource = @ScriptDir & "\DB1.mdb"
msgbox(4096, '统计', '在数据库中有<' & _accessTableCount($adSource) & '>个表')
