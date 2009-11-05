;可以用作调试用, 类似 MsgBox效果.

Local $var = "Test"
ConsoleWriteError("var=" & $var & @CRLF)
; Running this in a text editor which can trap console output should produce "var=Test"
