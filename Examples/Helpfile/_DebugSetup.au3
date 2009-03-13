#cs ----------------------------------------------------------------------------
	
	AutoIt Version: 3.2.8.1
	Author:         David Nuttall
	
	Script Function:
	Base script to show functionality of Debug functions.
	
#ce ----------------------------------------------------------------------------

AutoItSetOption("MustDeclareVars", 1)

#include <Debug.au3>

_DebugSetup ("Check Excel")
For $i = 1 To 4
	WinActivate("Microsoft Excel")
	; interact with Excel
	Send("{Down}")
	_DebugOut ("Moved Mouse Down", 1) 	; forces debug notepad window to take control
Next
