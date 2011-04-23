#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"
#include <Array.au3>

Opt("MustDeclareVars", 1)

; Time
Global $aTime = _WinHttpTimeToSystemTime("Sat, 21 Aug 2010 22:04:43 GMT")
_ArrayDisplay($aTime, "_WinHttpTimeToSystemTime()")

