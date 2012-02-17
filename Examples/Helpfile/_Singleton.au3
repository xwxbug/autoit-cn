#include <Misc.au3>
If _Singleton("test", 1) = 0 Then
	MsgBox(4096, "Warning", "An occurence of test is already running")
	Exit
EndIf
MsgBox(4096, "OK", "the first occurence of test is running")
