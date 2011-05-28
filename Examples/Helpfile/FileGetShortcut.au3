; 设置快捷方式热键: ctrl+alt+t
FileCreateShortcut(@WindowsDir & "\Explorer.exe", @DesktopDir & "\快捷方式例子.lnk", @WindowsDir, "/e,c:\", "这是一个资源管理器的快捷方式;-)", @SystemDir & "\shell32.dll", "^!t", "15", @SW_MINIMIZE)

; 读取快捷方式路径
Local $details = FileGetShortcut(@DesktopDir & "\快捷方式例子.lnk")
MsgBox(0, "路径:", $details[0])
