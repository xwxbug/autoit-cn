
#include  <SQLite.au3>
#include  <SQLite.dll.au3>

Local $hQuery, $aRow, $sMsg
_SQLite_Startup()
_SQLite_Open() ; 打开:内存:数据库
_SQLite_Exec(-1, "CREATE table aTest (a,b,c);") ; 创建表
_SQLite_Exec(-1, "INSERT INTO aTest(a,b,c) VALUES ('c','2','World');") ; 插入数据
_SQLite_Exec(-1, "INSERT INTO aTest(a,b,c) VALUES ('b','3','');") ; 插入数据
_SQLite_Exec(-1, "INSERT INTO aTest(a,b,c) VALUES ('a','1','Hello');") ; 插入数据
_SQlite_Query(-1, "SELECT c FROM aTest ORDER BY a;", $hQuery) ; 查询
While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
	$sMsg &= $aRow[0]
WEnd
_SQLite_Exec(-1, "DROP table aTest;") ; 移除表
msgbox(0, "SQLite" & _SQLite_LibVersion(), "Get Data using a Query :" & $sMsg)
_SQLite_Close()
_SQLite_Shutdown()

;~ 输出:
;~
;~ Hello World

