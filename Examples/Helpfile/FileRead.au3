$file = FileOpen("test.txt", 0)

; 检查打开的文件是否可为读
If $file = -1 Then
	MsgBox(0, "错误", "不能打开文件.")
	Exit
EndIf

; 每次读取一个字符,直到文件结束(译注:读中文必须设置为远大于1的值!)(译注的译注(thesnow):ANSI编码中,一个中文为两个字符/字节)
While 1
	$chars = FileRead($file, 1)
	If @error = -1 Then ExitLoop
	MsgBox(0, "读取的字符:", $chars)
Wend

FileClose($file)
