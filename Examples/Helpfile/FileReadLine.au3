$file = FileOpen("test.txt", 0)

; 检查打开的文件是否可读
If $file = -1 Then
	MsgBox(0, "错误", "不能打开文件.")
	Exit
EndIf

; 每次读取一行文本,直到文件结束.
While 1
	$line = FileReadLine($file)
	If @error = -1 Then ExitLoop
	MsgBox(0, "读取的行:", $line)
Wend

FileClose($file)
