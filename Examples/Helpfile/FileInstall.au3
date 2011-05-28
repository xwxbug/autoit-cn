; 编译的程序中将包含一个记事本主程序文件(路径:"C:\windows\notepad.exe"),编译的程序运行后释放到桌面
; 要包含进去的文件不能是一个变量表达式,因为编译器无法预测一个变量的值.
Local $b = True
If $b = True Then FileInstall("C:\windows\notepad.exe", @DesktopDir & "\notepad.exe")
