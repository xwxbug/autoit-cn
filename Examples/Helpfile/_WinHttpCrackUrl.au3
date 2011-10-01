#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"
#include <Array.au3>

Opt("MustDeclareVars", 1)

; ·Ö½â URL
Global $aUrl = _WinHttpCrackUrl("http://www.autoitscript.com/forum/index.php?showforum=9")
_ArrayDisplay($aUrl, "_WinHttpCrackUrl()")
