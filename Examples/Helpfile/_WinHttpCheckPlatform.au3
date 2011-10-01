#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

If Not _WinHttpCheckPlatform() Then
	MsgBox(48, "Caution", "WinHTTP not available on your system!")
	Exit 1
EndIf

;... 代码的剩余部分
