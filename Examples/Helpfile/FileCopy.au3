; 注：1、源文件路径及目录路径结尾建议增加斜杠号'\'.
;     2、每个复制操作都建议使用标志参数操作.
;     3、FileCopy只是复制文件而不能复制文件夹，需要复制文件夹的请使用DirCopy.

; 复制 C:\New\ 目录中所有 *.au3 文件至 D:\MyAu3\ 目录中，不覆盖已存在的目标文件.
FileCopy("C:\New\*.au3", "D:\MyAu3\", 0)

; 复制 D:\MyAu3\ 目录中所有文件至 C:\New\ 目录中，覆盖已存在的目标文件.
FileCopy("D:\MyAu3\*.*", "C:\New\", 1)

; 复制 D:\MyAu3\ 目录中所有文件至 C:\New\test\ 目录中，当目标文件夹不存在则自动创建一个.
FileCopy("D:\MyAu3\*.*", "C:\New\test\", 8)

; 复制 C:\New\ 中所有文件至 D:\MyAu3\test\ 目录中，当目标文件夹不存在则自动创建一个，当目标文件存在，则覆盖已存在的文件.
FileCopy("C:\New\*.*", "D:\MyAu3\test\", 9)
