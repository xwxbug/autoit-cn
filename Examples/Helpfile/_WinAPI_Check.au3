#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt('MustDeclareVars ', 1)

#include  <WinAPIEx.au3>

SetError(-1)

_WinAPI_Check(" dummy ", @error, @error)

; @error被清除
; 不再显示消息框
_WinAPI_Check(" dummy ", @error, @error)

