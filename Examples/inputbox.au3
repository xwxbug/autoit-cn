;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon@hiddensoft.com)
;
; Script Function:
;   Demonstrates the InputBox, looping and the use of @error.
;


; Prompt the user to run the script - use a Yes/No prompt (4 - see help file)
$answer = MsgBox(4, "AutoIt 例子 (英文+您系统的语言)", "这个脚本打开一个输入框,并要求您输入一些文本.  运行?")


; Check the user's answer to the prompt (see the help file for MsgBox return values)
; If "No" was clicked (7) then exit the script
If $answer = 7 Then
    MsgBox(4096, "AutoIt", "好的,再见!")
    Exit
EndIf

; Loop around until the user gives a valid "thesnow" answer
$bLoop = 1
While $bLoop = 1
    $text = InputBox("AutoIt 例子", "请输入:""thesnow"" 并单击确定")
    If @error = 1 Then
        MsgBox(4096, "错误", "您按下了 '取消' - 请重试!")
    Else
        ; They clicked OK, but did they type the right thing?
        If $text <> "thesnow" Then
            MsgBox(4096, "错误", "难道您不知道小名鼎鼎的 thesnow 吗? - 请重试!")
        Else
            $bLoop = 0    ; Exit the loop - ExitLoop would have been an alternative too :)
        EndIf
    EndIf
WEnd

; Print the success message
MsgBox(4096,"AutoIt 例子", "您输入了正确的单词!  恭喜.")

; Finished!
