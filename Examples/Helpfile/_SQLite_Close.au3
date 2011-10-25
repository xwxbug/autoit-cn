#include <SQLite.au3>
#include <SQLite.dll.au3>

_SQLite_Startup()
If @error Then
	msgbox(16, "SQLite Error", "SQLite.dll Can't be Loaded!")
	Exit -1
EndIf
msgbox(4096, "_SQLite_LibVersion", & _SQLite_LibVersion() & @CR)
_SQLite_Open() ;  打开一个:内存:数据库
If @error Then
	msgbox(16, "SQLite Error", "Can't Load Database!")
	Exit -1
EndIf
_SQLite_Close()
_SQLite_Shutdown()

