If FileExists("C:\autoexec.bat") Then
	MsgBox(4096, "C:\autoexec.bat 文件", "C:\autoexec.bat 文件存在")
Else
	MsgBox(4096,"C:\autoexec.bat 文件", "C:\autoexec.bat 文件不存在")
EndIf

If FileExists("C:\") Then
	MsgBox(4096, "C:\ 目录 ", "C:\ 目录存在")
Else
	MsgBox(4096,"C:\ 目录" , "C:\ 目录不存在")
EndIf

If FileExists("D:") Then
	MsgBox(4096, "驱动器 D:", "驱动器D:存在")
Else
	MsgBox(4096,"驱动器 D:", "驱动器D:不存在")
EndIf
