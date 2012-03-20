Local $sFldr1 = "C:\Test_1"
Local $sFldr2 = "C:\Test_2"

If DirGetSize($sFldr1) = -1 Then; 检查目录所占用的空间
	DirCreate($sFldr1); 创建目录文件
	Sleep(2000)
	DirMove($sFldr1, $sFldr2, 1); 移动目录文件
	Sleep(2000)
	DirRemove($sFldr2, 1); 删除目录文件及子目录
EndIf
