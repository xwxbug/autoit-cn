#include <File.au3>

$avCommon = _FileListToArray(@CommonFilesDir)
$avUser = _FileListToArray(@UserProfileDir)
$sFile = @ScriptDir & "\Test.txt"

; 通过文件名写入第一个数组
_FileWriteFromArray($sFile, $avCommon, 1)

; 打开文件附加第二个数组
$hFile = FileOpen($sFile, 1) ; 1 = 附加
_FileWriteFromArray($hFile, $avUser, 1)
FileClose($hFile)

; 显示结果
Run("notepad.exe" & $sFile)

