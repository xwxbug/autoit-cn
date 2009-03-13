;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon at hiddensoft com)
;
; Script Function:
;   Counts to 5 using a "for" loop


; Prompt the user to run the script - use a Yes/No prompt (4 - see help file)
$answer = MsgBox(4, "AutoIt 例子", "这个脚本将会运行5次 'For' 循环.  运行?")


; Check the user's answer to the prompt (see the help file for MsgBox return values)
; If "No" was clicked (7) then exit the script
If $answer = 7 Then
	MsgBox(0, "AutoIt 例子", "好的,再见!")
	Exit
EndIf


; Execute the loop 5 times
For $count = 1 To 5
	; Print the count
	MsgBox(0, "AutoIt 例子", "计数器为: " & $count)
Next
 
 
; Finished!
MsgBox(0, "AutoIt 例子", "完成!")