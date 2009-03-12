$file = FileOpen("test.txt", 0)

; 检查打开的文件是否可读
If $file = -1 Then
	MsgBox(0, "错误", "不能打开文件.")
	Exit
EndIf

FileClose($file)


; 自动创建目录结构的另外一个例子.
$file = FileOpen("test.txt", 10) ; 等同 2 + 8 (清除 + 创建目录)

If $file = -1 Then
	MsgBox(0, "错误", "不能打开文件.")
	Exit
EndIf

FileClose($file)