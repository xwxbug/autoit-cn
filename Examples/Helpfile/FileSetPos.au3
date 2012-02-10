#include <Constants.au3>

Local Const $sFile = "test.txt"
Local $hFile = FileOpen($sFile, 2)

; 检查文件是否已打开
If $hFile = -1 Then
	MsgBox(4096, "错误", "无法打开文件.")
	Exit
EndIf

; 向此前已打开的文本文件尾追加一行数据.
FileWriteLine($hFile, "Line1")
FileWriteLine($hFile, "Line2")
FileWriteLine($hFile, "Line3")

; 保存该文本文件内存缓冲区数据到磁盘.相等于保存操作.
FileFlush($hFile)

; 读取当前文件坐标内容
MsgBox(4096, "", "位置: " & FileGetPos($hFile) & @CRLF & "数据: " & @CRLF & FileRead($hFile))

; 设置当前文件坐标.
Local $n = FileSetPos($hFile, 0, $FILE_BEGIN)

;读取当前文件坐标内容
MsgBox(4096, "", "位置: " & FileGetPos($hFile) & @CRLF & "数据: " & @CRLF & FileRead($hFile))

; 关闭此前已打开的文件.
FileClose($hFile)

;删除临时文件.
FileDelete($sFile)