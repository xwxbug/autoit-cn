#include <SQLite.au3>
#include <SQLite.dll.au3>

Local $hQuery, $aRow
_SQLite_Startup()
ConsoleWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CRLF)
_SQLite_Open()
; 没有 $sCallback 这是没意义的语句
_SQLite_Exec(-1, "Create table tblTest (a,b int,c single not null);" & _
		"Insert into tblTest values ('1',2,3);" & _
		"Insert into tblTest values (Null,5,6);")

Local $d = _SQLite_Exec(-1, "Select rowid,* From tblTest", "_cb") ; 将对每行调用 _cb

Func _cb($aRow)
	For $s In $aRow
		ConsoleWrite($s & @TAB)
	Next
	ConsoleWrite(@CRLF)
	; 返回 $SQLITE_ABORT ; 会中断进程并在 _SQLite_Exec() 中触发 @error
EndFunc   ;==>_cb
_SQLite_Close()
_SQLite_Shutdown()

; 输出
;~ 	1		1	2	3
;~ 	2			5	6
