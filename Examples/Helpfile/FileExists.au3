If FileExists("C:\autoexec.bat") Then
	MsgBox(4096, "C:\autoexec.bat 文件", "存在")
Else
	MsgBox(4096,"C:\autoexec.bat 文件", "不存在")
EndIf

If FileExists("C:\") Then
	MsgBox(4096, "C:\ 目录 ", "存在")
Else
	MsgBox(4096,"C:\ 目录" , "不存在")
EndIf

If FileExists("D:") Then
	MsgBox(4096, "驱动器 D: ", "存在")
Else
	MsgBox(4096,"驱动器 D: ", "不存在")
EndIf
