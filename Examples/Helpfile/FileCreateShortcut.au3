; 为快捷方式设置 ctrl+alt+t 快速键
FileCreateShortcut(@WindowsDir & "\Explorer.exe", @DesktopDir & "\快捷方式创建例子.lnk", @WindowsDir, "/e,c:\", "这是资源管理器的快捷方式;-)", @SystemDir & "\shell32.dll", "^!t", "15", @SW_MINIMIZE)
