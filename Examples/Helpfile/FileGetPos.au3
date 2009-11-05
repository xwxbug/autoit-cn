#include <Constants.au3>

Local Const $sFile = "test.txt"
Local $hFile = FileOpen($sFile, 2)

; 检查文件是否写入模式
If $hFile = -1 Then
	MsgBox(0, "错误", "无法打开文件.")
	Exit
EndIf

;写入文本.
FileWriteLine($hFile, "Line1")
FileWriteLine($hFile, "Line2")
FileWriteLine($hFile, "Line3")

; Flush the file to disk.
FileFlush($hFile)

; Check file position and try to read contents for current position.
MsgBox(0, "", "Position: " & FileGetPos($hFile) & @CRLF & "Data: " & @CRLF & FileRead($hFile))

; Now, adjust the position to the beginning.
Local $n = FileSetPos($hFile, 0, $FILE_BEGIN)

; Check file position and try to read contents for current position.
MsgBox(0, "", "Position: " & FileGetPos($hFile) & @CRLF & "Data: " & @CRLF & FileRead($hFile))

;关闭此前已打开的文件.
FileClose($hFile)

;删除临时文件.
FileDelete($sFile)
