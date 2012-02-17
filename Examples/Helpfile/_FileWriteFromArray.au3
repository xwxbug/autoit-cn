#include<File.au3>

Local $avCommon = _FileListToArray(@CommonFilesDir)
Local $avUser = _FileListToArray(@UserProfileDir)
Local $sFile = @ScriptDir & "\Test.txt"

; 写入首个数组到由字符串表示名称的文件
_FileWriteFromArray($sFile, $avCommon, 1)

; 打开文件并附加第二个数组到文件
Local $hFile = FileOpen($sFile, 1) ; 1 = 附加
_FileWriteFromArray($hFile, $avUser, 1)
FileClose($hFile)

; 显示结果
Run("notepad.exe " & $sFile)
