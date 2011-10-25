
#include  <SQLite.au3>
#include  <SQLite.dll.au3>

_SQLite_Startup()
_SQLite_SafeMode(False)
_SQLite_Exec(-1, "CREATE tblTest (a,b,c);") ; 没有打开的数据库, 由于SafeMode = false导致崩溃
_SQLite_Shutdown()

