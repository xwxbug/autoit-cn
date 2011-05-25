;;; TIME.AU3 ;;;
MsgBox(0,"", "现在时间为 " & @HOUR & ":" & @MIN & ":" & @SEC)

;;; SCRIPT.AU3 ;;;
MsgBox(0,"", "例子")
#include "TIME.AU3"
Exit

; Running script.au3 will output two message boxes:
; one with 'Example', followed by one with the time.
