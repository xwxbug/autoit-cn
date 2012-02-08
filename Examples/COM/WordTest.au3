; Word Automation Example
;
; Based on AutoItCOM version 3.1.0
;
; Beta version 06-02-2005

Local $objWord = ObjCreate("Word.Application")

MsgBox(0, "WordTest", "Your Word Version is : " & $objWord.Version)
MsgBox(0, "WordTest", "Build: " & $objWord.Build)

$objWord.Quit ; Get rid of Word


