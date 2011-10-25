#include <SQLite.au3>
#include <SQLite.dll.au3>

Local $sSQliteDll
$sSQliteDll = _SQLite_Startup()
If @error Then
	msgbox(16, "SQLite Error", "SQLite.dll Can't be Loaded!")
	Exit -1
EndIf
msgbox(0, "SQLite Info", "_SQLite_LibVersion=" _SQLite_LibVersion() & @CR & _
		"SQLite3.dll Loaded", $sSQliteDll)
_SQLite_Shutdown()

