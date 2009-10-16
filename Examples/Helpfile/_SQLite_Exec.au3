#include <sqlite.au3>
#include <sqlite.dll.au3>

Local $hQuery,$aRow
_SQLite_Startup()
ConsoleWrite("_SQLite_LibVersion=" &_SQLite_LibVersion() & @CRLF)
_SQLite_Open()
; Whithout $sCallback its an Resultless query
_SQLite_Exec(-1,"Create table tblTest (a,b int,c single not null);" & _
                "Insert into tblTest values ('1',2,3);" & _
                "Insert into tblTest values (Null,5,6);")

$d = _SQLite_Exec(-1,"Select oid,* From tblTest","_cb") ; _cb Will be called for each row
Func _cb($aRow)
	For $s In $aRow
		ConsoleWrite($s & @TAB)
	Next
	ConsoleWrite(@CRLF)
	; Return $SQLITE_ABORT ; Would Abort the process and trigger an @error in _SQLite_Exec()
EndFunc
_SQLite_Close()
_SQLite_Shutdown()

; Output:
;~ 	rowid	a	b	c
;~ 	1		1	2	3
;~ 	2			5	6
