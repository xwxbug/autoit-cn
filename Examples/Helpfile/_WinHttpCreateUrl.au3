#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Creating URL out of array of components:
Global $aURL[8] = ["http", 1, "www.autoitscript.com", 80, "Jon", "deadPiXels", "admin.php"]
MsgBox(0, "Created URL", _WinHttpCreateUrl($aURL))
