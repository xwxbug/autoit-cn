#include<File.au3>

$avCommon = _FileListToArray(@CommonFilesDir)
$avUser = _FileListToArray(@UserProfileDir)
$sFile = @ScriptDir & "\Test.txt"

; Write first array to file by string file name
_FileWriteFromArray($sFile, $avCommon, 1)

; Open file and append second array
$hFile = FileOpen($sFile, 1) ; 1 = append
_FileWriteFromArray($hFile, $avUser, 1)
FileClose($hFile)

; Display results
Run("notepad.exe " & $sFile)
