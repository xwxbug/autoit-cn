;示例 1
Exit

;示例 2 
; 结束脚本: 没有命令行参数
If $CmdLine[0] = 0 Then Exit(1)

;示例 3 
; 打开第一命令行参数中指定的文件
$file = FileOpen($CmdLine[1], 0)

; 检查文件是否可读
If $file = -1 Then Exit(2)

; 如果文件为空的,脚本退出.(脚本运行是成功的)
$line = FileReadLine($file)
If @error = -1 Then Exit

;在这里加入文件处理代码
FileClose($file)
Exit ;如果是脚本的最后一行,这句就可有可无.
