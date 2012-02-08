;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon@hiddensoft.com)
;
; Script Function:
;   Demo of using multiple lines in a message box
;

; Use the @CRLF macro to create a newline in a MsgBox - it is similar to the \n in v2.64
;~ @CR=回车
;~ @LF=换行
;~ @CRLF=回车+换行

MsgBox(0, "AutoIt 例子", "这是第一行" & @CRLF & "这是第二行" & @CRLF & "这是第三行")
