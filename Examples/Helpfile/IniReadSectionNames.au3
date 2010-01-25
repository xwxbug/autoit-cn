$var = IniReadSectionNames(@WindowsDir & "\win.ini")
If @error Then 
	MsgBox(4096, "", "错误, 读取INI文件失败.")
Else
	For $i = 1 To $var[0]
		MsgBox(4096, "", "字段名:" & $var[$i])
	Next
EndIf
