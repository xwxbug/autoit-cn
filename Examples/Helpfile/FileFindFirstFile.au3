; 显示当前目录中所有文件的文件名
$search = FileFindFirstFile("*.*")  

; 检查搜索是否成功
If $search = -1 Then
	MsgBox(0, "错误", "没有文件/目录 匹配搜索")
	Exit
EndIf

While 1
	$file = FileFindNextFile($search) 
	If @error Then ExitLoop
	
	MsgBox(4096, "文件:", $file)
WEnd

; 关闭搜索句柄
FileClose($search)
