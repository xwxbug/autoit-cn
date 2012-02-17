#include <SQLite.au3>
#include <SQLite.dll.au3>

_SQLite_Startup()
ConsoleWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CRLF)
_SQLite_Open()
_SQLite_Exec(-1, "CREATE TABLE test (a, b);") ; 创建表
_SQLite_Exec(-1, "INSERT INTO test VALUES ('1', '2');") ; 插入第一行
_SQLite_Exec(-1, "INSERT INTO test VALUES ('3', '4');") ; 插入第二行
MsgBox(4096, "SQLite", "The last SQL statement changed " & _SQLite_Changes() & " rows" & @CRLF & _
		"All statements during this session changed " & _SQLite_TotalChanges() & " rows")
_SQLite_Close()
_SQLite_Shutdown()
