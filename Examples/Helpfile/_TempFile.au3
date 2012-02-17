#include <File.au3>

Local $s_TempFile, $s_FileName

; 生成@TempDir中唯一的文件名
$s_TempFile = _TempFile()

; 生成给定目录中以tst_开头的唯一文件名
$s_FileName = _TempFile("C:\", "tst_", ".txt", 7)

MsgBox(4096, "Info", "Names suitable for new temporary file : " & @LF & $s_TempFile & @LF & $s_FileName)

Exit
