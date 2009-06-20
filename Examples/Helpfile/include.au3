;;; TIME.AU3 ;;;
MsgBox(0,"", "现在时间为 " & @HOUR & ":" & @MIN & ":" & @SEC)

;;; SCRIPT.AU3 ;;;
#include "TIME.AU3"
MsgBox(0,"", "例子")
#include "TIME.AU3"
Exit

; Running script.au3 will output three message boxes:
; one with the time, one with 'Example', and another with the time.
