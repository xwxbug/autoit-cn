; 为快捷方式设置 ctrl+alt+t 快速键
FileCreateShortcut(@WindowsDir & "\Explorer.exe",@DesktopDir & "\Shortcut Test.lnk",@WindowsDir,"/e,c:\", "This is an Explorer link;-)", @SystemDir & "\shell32.dll", "^!t", "15", @SW_MINIMIZE)
