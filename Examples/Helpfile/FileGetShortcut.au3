; Sets a shortcut with ctrl+alt+t hotkey
FileCreateShortcut(@WindowsDir & "\Explorer.exe",@DesktopDir & "\Shortcut Test.lnk",@WindowsDir,"/e,c:\", "This is an Explorer link;-)", @SystemDir & "\shell32.dll", "^!t", "15", @SW_MINIMIZE)

; Read in the path of a shortcut
$details = FileGetShortcut(@DesktopDir & "\Shortcut Test.lnk")
MsgBox(0, "Path:", $details[0])
