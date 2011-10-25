#include  <File.au3>
; 示例: 替换写入到c:\test.txt第三行
_FileWriteToLine(" c:\test.txt ", 3, "my replacement for line 3 ", 1)
; 示例: 不替换写入到c:\test.txt第三行
_FileWriteToLine(" c:\test.txt ", 3, "my insertion ", 0)

