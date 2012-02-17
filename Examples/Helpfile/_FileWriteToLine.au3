#include <File.au3>
;示例: 写入到 c:\test.txt 的第三行并覆盖它
_FileWriteToLine("c:\test.txt", 3, "my replacement for line 3", 1)
;示例: 写入到 c:\test.txt 的第三行但不覆盖它
_FileWriteToLine("c:\test.txt", 3, "my insertion", 0)