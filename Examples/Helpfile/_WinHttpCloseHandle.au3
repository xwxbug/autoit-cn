#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Initialize and get session handle
Global $hOpen = _WinHttpOpen()
If @error Then
	MsgBox(48, "Error", "Error initializing the usage of WinHTTP functions.")
	Exit 1
EndIf

; Close it
_WinHttpCloseHandle($hOpen)
If @error Then
	ConsoleWriteError("!Error closing the handle. @error = " & @error & @CRLF)
	MsgBox(48, "Error", "Error closing the handle." & @CRLF & "Error number is " & @error)
Else
	ConsoleWrite("+ Handle is succesfully closed." & @CRLF)
	MsgBox(64, "Closed", "Handle is succesfully closed.")
EndIf