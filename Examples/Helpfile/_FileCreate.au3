#include <File.au3>
If Not _FileCreate("error.log") Then
	MsgBox(4096, "´íÎó", " Error Creating/Resetting log.      error:" & @error)
EndIf
