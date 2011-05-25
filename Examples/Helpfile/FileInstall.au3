; 编译的程序中将包含一个位图文件(路径:"C:\test.bmp"),编译的程序运行后释放为 "D:\ mydir\test.bmp"
Local $b = True
If $b = True Then FileInstall("C:\test.bmp", "D:\mydir\test.bmp")
