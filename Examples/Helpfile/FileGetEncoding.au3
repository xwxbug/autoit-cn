Local $encoding = FileGetEncoding(@WindowsDir & "\system.ini")
If $encoding=-1 Then
	MsgBox(4096, "错误", "不能获取文件编码.")
	Exit
Else
	MsgBox(4096, "", "文件编码为:" & $encoding)
EndIf
