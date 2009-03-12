Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]","")
$pos = ControlGetPos("[CLASS:Notepad]", "", "Edit1")
MsgBox(0, "窗口状态:", "坐标: " & $pos[0] & "," & $pos[1] & " 大小: " & $pos[2] & "," & $pos[3] )
