;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon@hiddensoft.com)
;
; Script Function:
;   Demo of using functions
;


; Prompt the user to run the script - use a Yes/No prompt (4 - see help file)
Local $answer = MsgBox(4, "AutoIt 例子", "这个脚本将会调用两个自定义函数.  运行?")


; Check the user's answer to the prompt (see the help file for MsgBox return values)
; If "No" was clicked (7) then exit the script
If $answer = 7 Then
	MsgBox(0, "AutoIt", "好的,再见!")
	Exit
EndIf


; Run TestFunc1
TestFunc1()

; Run TestFunc2
TestFunc2(20)

; Finished!
MsgBox(0, "AutoIt 例子", "完成!")
Exit


; TestFunc1
Func TestFunc1()
	MsgBox(0, "AutoIt 例子", "内部 TestFunc1()")
EndFunc   ;==>TestFunc1


; TestFunc2
Func TestFunc2($var)
	MsgBox(0, "AutoIt 例子", "内部 TestFunc2() - $var 为: " & $var)
EndFunc   ;==>TestFunc2
