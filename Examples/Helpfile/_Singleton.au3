#include <Misc.au3>
if _Singleton("test",1) = 0 Then
	Msgbox(0,"Warning","An occurence of test is already running")
	Exit
EndIf
Msgbox(0,"OK","the first occurence of test is running")
