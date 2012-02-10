Example1()
Example2()

Func Example1()
	;================================================
	;示例1 官方默认例子
	;================================================
	Local Const $sFile = "test.txt"
	Local $hFile = FileOpen($sFile, 1)

	; 检查文件是否已打开
	If $hFile = -1 Then
		MsgBox(4096, "错误", "无法打开文件.")
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
EndFunc   ;==>Example1

Func Example2()
	;================================================
	;示例2 ACN例子
	;================================================
	#include <Constants.au3>
	Local Const $aFile = "test.txt"
	Local $hFile = FileOpen($aFile, 1)

	; 检查文件是否已打开
	If $hFile = -1 Then
		MsgBox(0, "错误", "无法打开文件.")
		Exit
	EndIf

	; 向此前已打开的文本文件尾追加一行数据.
	FileWriteLine($hFile, "Line1")

	; 读取当前文件坐标内容
	MsgBox(0, "", "位置: " & FileGetPos($hFile) & @CRLF & "数据: " & @CRLF & FileRead($hFile))

	; 保存该文本文件内存缓冲区数据到磁盘.相等于保存操作.
	FileFlush($hFile)

	; 设置当前文件坐标.
	Local $n = FileSetPos($hFile, 0, $FILE_BEGIN)

	;读取当前文件坐标内容
	MsgBox(0, "", "位置: " & FileGetPos($hFile) & @CRLF & "数据: " & @CRLF & FileRead($hFile))

	; 关闭此前已打开的文件.
	FileClose($hFile)

	;删除临时文件.
	FileDelete($aFile)
EndFunc   ;==>Example2