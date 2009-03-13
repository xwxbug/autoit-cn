#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt('MustDeclareVars', 1)

#include <WinAPI.au3>

SetError(-1)

_WinAPI_Check("dummy", @error, @error)

; @error is cleared so
; this one should not show a message box
_WinAPI_Check("dummy", @error, @error)