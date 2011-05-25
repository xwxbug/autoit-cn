Local $file = FileOpen("test.txt", 1)

; 检查打开的文件是否可写
If $file = -1 Then
	MsgBox(0, "错误", "不能打开文件.")
	Exit
EndIf

FileWriteLine($file, "Line1")
FileWriteLine($file, "Line2" & @CRLF)
FileWriteLine($file, "Line3")

FileClose($file)
