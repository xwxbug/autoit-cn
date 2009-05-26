#include <SQLite.au3>
#include <SQLite.dll.au3>

Local $sSQliteDll
$sSQliteDll = _SQLite_Startup ()
If @error Then
	MsgBox(16, "SQLite Error", "SQLite.dll Can't be Loaded!")
	Exit - 1
EndIf
ConsoleWrite("_SQLite_LibVersion=" &_SQLite_LibVersion() & @CR)
MsgBox(0,"SQLite3.dll Loaded",$sSQliteDll)
_SQLite_Shutdown ()