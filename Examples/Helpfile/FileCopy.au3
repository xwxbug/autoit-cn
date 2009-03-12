FileCopy("C:\*.au3", "D:\mydir\*.*")

; 复制一个文件夹及其内容
DirCreate("C:\new")
FileCopy("C:\old\*.*", "C:\new\")

FileCopy("C:\Temp\*.txt", "C:\Temp\TxtFiles\", 8)
; 右边的 'TxtFiles' 是目标目录,复制过去的文件名称和原始名称相同.

FileCopy("C:\Temp\*.txt", "C:\Temp\TxtFiles\", 9) ; 标志 = 1 + 8 (覆盖 + 创建目标目录结构)
; 复制TXT文件到目标目录中,如果目标目录不存在则创建.如果文件存在则覆盖.
