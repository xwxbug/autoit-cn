#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

Global $edit

_Main()

Func _Main()

	Local $GUI, $hQuery, $aRow, $aNames

	$GUI = GUICreate("SQLite FetchData", 400, 260)
	$edit = GUICtrlCreateEdit("", 2, 2, 394, 256, BitOR($ES_READONLY, $ES_AUTOVSCROLL))
	GUISetState()

	_SQLite_Startup()
	MemoWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CR)
	_SQLite_Open() ; 打开:内存:数据库
	_SQLite_Exec(-1, "CREATE table aTest (a,b,c);")
	_SQLite_Exec(-1, "INSERT INTO aTest(a,b,c) VALUES ('c','2','World');")
	_SQLite_Exec(-1, "INSERT INTO aTest(a,b,c) VALUES ('b','3','');")
	_SQLite_Exec(-1, "INSERT INTO aTest(a,b,c) VALUES ('a','1','Hello');")
	_SQlite_Query(-1, "SELECT ROWID,* FROM aTest ORDER BY a;", $hQuery)
	_SQLite_FetchNames($hQuery, $aNames)
	MemoWrite( StringFormat(" %-10s  %-10s  %-10s  %-10s ", $aNames[0], $aNames[1], $aNames[2], $aNames[3]) & @CR)
	While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK ; 读出下一行
		MemoWrite( StringFormat(" %-10s  %-10s  %-10s  %-10s ", $aRow[0], $aRow[1], $aRow[2], $aRow[3]) & @CR)
	WEnd
	_SQLite_Exec(-1, "DROP table aTest;")
	_SQLite_Close()
	_SQLite_Shutdown()

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

Func MemoWrite($s_text)
	GUICtrlSetData($edit, $s_text & @CRLF, 1)
endfunc   ;==>MemoWrite


