#include <SQLite.au3>
#include <SQLite.dll.au3>

_SQLite_Startup()
ConsoleWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CRLF)
_SQLite_Open()
If $SQLITE_OK <> _SQLite_Exec(-1, "CREATE TABLE test (a', 'b');") Then _ ; 少了个引号
		MsgBox(4096, "SQLite Error", "Error Code: " & _SQLite_ErrCode() & @CRLF & "Error Message: " & _SQLite_ErrMsg())
_SQLite_Close()
_SQLite_Shutdown()
