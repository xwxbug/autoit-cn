Local $file = FileOpen("test.txt", 1)

; 检查打开的文件可写
If $file = -1 Then
	MsgBox(4096, "错误", "不能打开文件.")
	Exit
EndIf

FileWrite($file, "Line1")
FileWrite($file, "Still Line1" & @CRLF)
FileWrite($file, "Line2")

FileClose($file)
