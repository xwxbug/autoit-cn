IniWrite("C:\Temp\myfile.ini", "设置", "坏人人数", "12345")

Local $var = IniReadSection("C:\Temp\myfile.ini", "section2")
If @error Then
	MsgBox(4096, "", "错误, 读取INI文件失败.")
Else
	For $i = 1 To $var[0][0]
		MsgBox(4096, "", "关键字: " & $var[$i][0] & @CRLF & "值: " & $var[$i][1])
	Next
EndIf
