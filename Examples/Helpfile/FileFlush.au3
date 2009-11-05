Local Const $sFile = "test.txt"
Local $hFile = FileOpen($sFile, 1)

; 检查文件是否已打开
If $hFile = -1 Then
	MsgBox(0, "错误", "无法打开文件.")
	Exit
EndIf

; 向此前已打开的文本文件尾追加一行数据.
FileWriteLine($hFile, "Line1")

; 运行记事本,此文本文件还未添加任何数据.
RunWait("notepad.exe " & $sFile)

; 保存该文本文件内存缓冲区数据到磁盘.相等于保存操作.
FileFlush($hFile)

; 运行记事本,显示保存的结果.
RunWait("notepad.exe " & $sFile)

; 关闭此前已打开的文件.
FileClose($hFile)

;删除临时文件.
FileDelete($sFile)

