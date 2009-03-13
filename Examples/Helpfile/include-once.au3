;;; LIBRARY.AU3 ;;;
#include-once

Func myFunc()
	MsgBox(0,"", "Hello from library.au3")
EndFunc


;;; SCRIPT.AU3 ;;;
#include "Library.au3"
#include "Library.au3"  ;throws an error if #include-once was not used

MsgBox(0, "Example", "This is from 'script.au3' file")
myFunc()
Exit

; Running script.au3 will output the two message boxes:
; one saying "This is from 'script.au3' file" 
; and another saying "Hello from library.au3"