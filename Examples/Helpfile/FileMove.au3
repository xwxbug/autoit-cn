; 第一个例子:
FileWrite("c:\test.txt","测试测试")
FileMove("c:\test.txt", @DesktopDir & "\AU3_例子.au3")

; 第二个例子:
;   使用标志 '1'(覆盖) 和 '8' (自动创建目标目录结构)
;   从临时文件夹中移动所有的 txt 文件到 txtfiles 目录,而且预先检查
;   目标目录结构是否存在, 如果不存在就自动创建.
FileMove(@TempDir & "\*.txt", @TempDir & "\TxtFiles\", 9)
MsgBox(32,"","所有临时文件夹下的文本文件已经移动到了临时目录下面的TxtFiles文件夹下面")
DirRemove(@TempDir & "\TxtFiles\",1)