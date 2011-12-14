Run("notepad.exe")
WinWait("[CLASS:Notepad]")
Local $aPos = ControlGetPos("[CLASS:Notepad]", "", "Edit1")
MsgBox(0, "窗口状态:", "坐标: " & $aPos[0] & "," & $aPos[1] & @CRLF & "大小: " & $aPos[2] & "," & $aPos[3] )
